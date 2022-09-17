//
//  CoreActionSheetMonthYearPicker.m
//  CoreActionSheetPicker
//
//  Created by Nguyen Truong Luu on 9/16/22.
//  Copyright © 2022 Petr Korolev. All rights reserved.
//

#import "CoreActionSheetMonthYearPicker.h"

//
// CoreActionSheetMonthYearPickerViewDelegate
//

@protocol CoreActionSheetMonthYearPickerViewDelegate
- (void)didSelectDate;
@end

//
// CoreActionSheetMonthYearPickerView
//

@interface CoreActionSheetMonthYearPickerView : UIPickerView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) CoreActionSheetMonthYearPickerMode datePickerMode;
@property (nonatomic, retain) NSLocale *locale;
@property (nonatomic, copy) NSCalendar *calendar;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSDate *minimumDate;
@property (nonatomic, retain) NSDate *maximumDate;
@property (nonatomic, retain) NSMutableDictionary *pickerTextAttributes;
@property (nonatomic, assign) id<CoreActionSheetMonthYearPickerViewDelegate> pickerDelegate;

- (void)setDate:(NSDate *)date animated:(BOOL)animated;

@end

@implementation CoreActionSheetMonthYearPickerView {
    // Picker data (list of months and years)
    NSArray *_months;
    NSArray *_years;

    // Cached min/max year/month values
    // We do this to avoid expensive NSDateComponents-based date math in pickerView:viewForRow
    NSInteger _minimumYear;
    NSInteger _maximumYear;
    NSInteger _minimumMonth;
    NSInteger _maximumMonth;
}

@synthesize datePickerMode;
@synthesize locale = _locale;
@synthesize calendar = _calendar;
@synthesize date = _date;
@synthesize minimumDate;
@synthesize maximumDate;
@synthesize pickerDelegate;

// Default min/max year values used if minimumDate/maximumDate is not set
// These values match that of UIDatePicker
const NSInteger kMinYear = 1;
const NSInteger kMaxYear = 10000;

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initCommon];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initCommon];
    }
    return self;
}

- (void)initCommon {
    self.dataSource = self;
    self.delegate = self;
    self.showsSelectionIndicator = YES;

    // Initialize default cached values
    [self initCachedValues];

    // Initialize picker data
    [self initPickerData];

    // Set default date to today
    _date = [NSDate date];
}

- (void)initCachedValues {
    _minimumYear = -1;
    _maximumYear = -1;
    _minimumMonth = -1;
    _maximumMonth = -1;
}

- (void)initPickerData {
    // Form list of months
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:self.locale];
    _months = [dateFormatter monthSymbols];

    // Form list of years
    [dateFormatter setDateFormat:@"yyyy"];
    NSDateComponents *comps = [[NSDateComponents alloc] init];

    NSMutableArray *years = [[NSMutableArray alloc] init];
    for( int year = kMinYear ; year <= kMaxYear ; ++year ) {
        [comps setYear:year];
        NSDate *yearDate = [self.calendar dateFromComponents:comps];
        NSString *yearStr = [dateFormatter stringFromDate:yearDate];

        [years addObject:yearStr];
    }
    _years = years;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    // Set initial picker selection
    [self selectionFromDate:NO];
}

#pragma mark - Date picker mode

- (void)setDatePickerMode:(CoreActionSheetMonthYearPickerMode)mode {
    datePickerMode = mode;

    [self reloadAllComponents];
    [self selectionFromDate:NO];
}

#pragma mark - Locale

- (NSLocale *)locale {
    if( _locale == nil ) {
        _locale = [self.calendar locale];
    }
    return _locale;
}

- (void)setLocale:(NSLocale *)loc {
    _locale = loc;
}

#pragma mark - Calendar

- (NSCalendar *)calendar {
    if( _calendar == nil ) {
        _calendar = [NSCalendar currentCalendar];
    }
    return _calendar;
}

- (void)setCalendar:(NSCalendar *)cal {
    _calendar = cal;
}

#pragma mark - Date

- (NSDate *)date {
    return _date;
}

- (void)setDate:(NSDate *)dt {
    [self setDate:dt animated:NO];
}

- (void)setDate:(NSDate *)dt animated:(BOOL)animated {
    _date = dt;
    [self selectionFromDate:animated];
}

#pragma mark - Min / Max date

- (void)setMinimumDate:(NSDate *)minDate {
    minimumDate = minDate;

    // Pre-calculate min year & month
    if( minimumDate != nil ) {
        NSDateComponents *comps = [self.calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth) fromDate:minimumDate];
        _minimumYear = comps.year;
        _minimumMonth = comps.month;
    } else {
        _minimumYear = -1;
        _minimumMonth = -1;
    }

    [self reloadAllComponents];
}

- (void)setMaximumDate:(NSDate *)maxDate {
    maximumDate = maxDate;

    // Pre-calculate max year & month
    if( maximumDate != nil ) {
        NSDateComponents *comps = [self.calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth) fromDate:maximumDate];
        _maximumYear = comps.year;
        _maximumMonth = comps.month;
    } else {
        _maximumYear = -1;
        _maximumMonth = -1;
    }

    [self reloadAllComponents];
}

- (void)setPickerTextAttributes:(NSMutableDictionary *)attributes {
    _pickerTextAttributes = attributes;
    
    [self reloadAllComponents];
}

#pragma mark - Date <-> selection

- (void)selectionFromDate:(BOOL)animated {
    // Extract the month and year from the current date value
    NSDateComponents* comps = [self.calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth) fromDate:self.date];
    NSInteger month = [comps month];
    NSInteger year = [comps year];
    
    // Select the corresponding rows in the UI
    if( datePickerMode == CoreActionSheetMonthYearPickerModeYear ) {
        [self selectRow:(year - kMinYear) inComponent:0 animated:animated];
    } else {
        [self selectRow:(month - 1) inComponent:0 animated:animated];
        [self selectRow:(year - kMinYear) inComponent:1 animated:animated];
    }
}

- (NSDate *)dateFromSelection {
    NSInteger month, year;

    // Get the currently selected month and year
    if( datePickerMode == CoreActionSheetMonthYearPickerModeYear ) {
        month = 1;
        year  = [self selectedRowInComponent:0] + kMinYear;
    } else {
        month = [self selectedRowInComponent:0] + 1;
        year  = [self selectedRowInComponent:1] + kMinYear;
    }

    // Assemble into a date object
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];

    return [self.calendar dateFromComponents:comps];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return (datePickerMode == CoreActionSheetMonthYearPickerModeYear) ? 1 : 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    BOOL isYearComponent = (datePickerMode == CoreActionSheetMonthYearPickerModeYear) || (component == 1);
    return isYearComponent ? [_years count] : [_months count];
}

#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    // Create (or reuse) the label instance
    UILabel *label = (UILabel *)view;
    if( label == nil ) {
        CGSize rowSize = [pickerView rowSizeForComponent:component];
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rowSize.width, rowSize.height)];
        label.adjustsFontSizeToFitWidth = YES;
    }

    // Is this the year component?
    BOOL isYearComponent = (datePickerMode == CoreActionSheetMonthYearPickerModeYear) || (component == 1);

    // Is the month or year represented by this component out of bounds? (i.e. < min or > max)
    BOOL outOfBounds = NO;
    if( isYearComponent ) {
        NSInteger year = row + kMinYear;

        if( ((maximumDate != nil) && (year > _maximumYear)) ||
            ((minimumDate != nil) && (year < _minimumYear)) ) {
            outOfBounds = YES;
        }
    } else {
        NSInteger month = row + 1;

        // Extract the year from the current date
        NSDateComponents *comps = [self.calendar components:(NSCalendarUnitYear) fromDate:self.date];
        NSInteger year = comps.year;

        if( ( (maximumDate != nil) && ((year > _maximumYear) || ((year == _maximumYear) && (month > _maximumMonth))) ) ||
            ( (minimumDate != nil) && ((year < _minimumYear) || ((year == _minimumYear) && (month < _minimumMonth))) ) ) {
            outOfBounds = YES;
        }
    }

    // Set label text & color
    label.attributedText =  [[NSAttributedString alloc] initWithString: [(isYearComponent ? _years : _months) objectAtIndex:row] attributes: self.pickerTextAttributes];
    label.textColor = (outOfBounds ? [UIColor grayColor] : [UIColor blackColor]);

    return label;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    // Update date value
    _date = [self dateFromSelection];

    // If the currently selected date < the min date, reset it to the min date
    if( (minimumDate != nil) && ([self compareMonthYear:self.date with:minimumDate] == NSOrderedAscending) ) {
        [self setDate:minimumDate animated:YES];
    }

    // If the currently selected date > the min date, reset it to the max date
    if( (maximumDate != nil) && ([self compareMonthYear:self.date with:maximumDate] == NSOrderedDescending) ) {
        [self setDate:maximumDate animated:YES];
    }

    // If the year was changed, reload the month picker
    // This is to refresh the enabled/disabled state of the months
    BOOL isYearComponent = (datePickerMode == CoreActionSheetMonthYearPickerModeYear) || (component == 1);
    if( isYearComponent ) {
        [self reloadComponent:0];
    }

    // Notify delegate
    [pickerDelegate didSelectDate];
}

- (NSComparisonResult)compareMonthYear:(NSDate *)date1 with:(NSDate *)date2 {
    NSDateComponents *comps = [self.calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth) fromDate:date1];
    date1 = [self.calendar dateFromComponents:comps];

    comps = [self.calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth) fromDate:date2];
    date2 = [self.calendar dateFromComponents:comps];

    return [date1 compare:date2];
}

@end

//
// CoreActionSheetMonthYearPicker
//

@interface CoreActionSheetMonthYearPicker (Delegate) <CoreActionSheetMonthYearPickerViewDelegate>
@end

@implementation CoreActionSheetMonthYearPicker {
    CoreActionSheetMonthYearPickerView *_pickerView;
}

@synthesize datePickerMode;
@synthesize locale;
@synthesize calendar;
@synthesize date;
@synthesize minimumDate;
@synthesize maximumDate;
@synthesize pickerTextAttributes;

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _pickerView = [[CoreActionSheetMonthYearPickerView alloc] initWithFrame: self.bounds];
        [self initCommon];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _pickerView = [[CoreActionSheetMonthYearPickerView alloc] initWithCoder:aDecoder];
        CGSize pickerSize = [_pickerView sizeThatFits:CGSizeZero];
        _pickerView.frame = CGRectMake( 0, 0, pickerSize.width, pickerSize.height );
        [self initCommon];
    }
    return self;
}

- (void)initCommon {
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            _pickerView.frame.size.width,
                            _pickerView.frame.size.height);
    _pickerView.pickerDelegate = self;
    [self addSubview:_pickerView];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [_pickerView sizeThatFits:size];
}

- (void)didSelectDate {
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - CoreActionSheetMonthYearPicker API

- (CoreActionSheetMonthYearPickerMode)datePickerMode {
    return _pickerView.datePickerMode;
}

- (void)setDatePickerMode:(CoreActionSheetMonthYearPickerMode)dpm {
    _pickerView.datePickerMode = dpm;
}

- (NSLocale *)locale {
    return _pickerView.locale;
}

- (void)setLocale:(NSLocale *)loc {
    _pickerView.locale = loc;
}

- (NSCalendar *)calendar {
    return _pickerView.calendar;
}

- (void)setCalendar:(NSCalendar *)cal {
    _pickerView.calendar = cal;
}

- (NSDate *)date {
    return _pickerView.date;
}

- (void)setDate:(NSDate *)dt {
    [_pickerView setDate:dt];
}

- (void)setDate:(NSDate *)dt animated:(BOOL)animated {
    [_pickerView setDate:dt animated:animated];
}

- (NSDate *)minimumDate {
    return _pickerView.minimumDate;
}

- (void)setMinimumDate:(NSDate *)minDate {
    _pickerView.minimumDate = minDate;
}

- (NSDate *)maximumDate {
    return _pickerView.maximumDate;
}

- (void)setMaximumDate:(NSDate *)maxDate {
    _pickerView.maximumDate = maxDate;
}

- (NSMutableDictionary *)pickerTextAttributes {
    return _pickerView.pickerTextAttributes;
}

- (void)setPickerTextAttributes:(NSMutableDictionary *)attributes {
    _pickerView.pickerTextAttributes = attributes;
}

@end
