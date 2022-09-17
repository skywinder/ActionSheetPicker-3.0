//
//  CoreActionSheetMonthYearPicker.h
//  CoreActionSheetPicker
//
//  Created by Nguyen Truong Luu on 9/16/22.
//  Copyright © 2022 Petr Korolev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CoreActionSheetMonthYearPickerModeMonthAndYear,  // Display month and year
    CoreActionSheetMonthYearPickerModeYear           // Display just the year
} CoreActionSheetMonthYearPickerMode;

@interface CoreActionSheetMonthYearPicker : UIControl <NSCoding>

// The mode of the date picker - see the CoreActionSheetMonthYearPickerMode enum
// Default is CoreActionSheetMonthYearPickerModeMonthAndYear
@property (nonatomic) CoreActionSheetMonthYearPickerMode datePickerMode;

// The locale used by the date picker
// Default is [NSLocale currentLocale]. Setting nil returns to default
@property (nonatomic, retain) NSLocale *locale;

// The calendar to use for the date picker
// Default is [NSCalendar currentCalendar]. Setting nil returns to default
@property (nonatomic, copy) NSCalendar *calendar;

// The date displayed by the date picker
// Default is current date when picker is created
@property (nonatomic, retain) NSDate *date;

// The minimum date that the date picker should show
// Default is nil (Jan 1, 0001 in the UI)
@property (nonatomic, retain) NSDate *minimumDate;

// The maximum date that the date picker should show
// Default is nil (Dec 31, 10000 in the UI)
@property (nonatomic, retain) NSDate *maximumDate;

// Used to specify Picker Label attributes.
// Default with a NSMutableParagraphStyle to set label align center.
@property (nonatomic, retain) NSMutableDictionary *pickerTextAttributes;

// Sets the date to display in the date picker
// If animated is YES, animate the wheels to display the new date
- (void)setDate:(NSDate *)date animated:(BOOL)animated;

@end

