//
//Copyright (c) 2011, Tim Cinel
//All rights reserved.
//
//Redistribution and use in source and binary forms, with or without
//modification, are permitted provided that the following conditions are met:
//* Redistributions of source code must retain the above copyright
//notice, this list of conditions and the following disclaimer.
//* Redistributions in binary form must reproduce the above copyright
//notice, this list of conditions and the following disclaimer in the
//documentation and/or other materials provided with the distribution.
//* Neither the name of the <organization> nor the
//names of its contributors may be used to endorse or promote products
//derived from this software without specific prior written permission.
//
//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
//DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//


#import "ActionSheetDatePicker.h"
#import "CoreActionSheetMonthYearPicker.h"
#import <objc/message.h>

@interface ActionSheetDatePicker()

@property (nonatomic, assign) ActionSheetDatePickerMode datePickerMode;
@property (nonatomic, strong) NSDate *selectedDate;

@end

@implementation ActionSheetDatePicker

const CGFloat kActionSheetDefaultHeight = 216;

@synthesize datePickerStyle = _datePickerStyle;

-(UIDatePickerStyle)datePickerStyle {
    if (_datePickerStyle != UIDatePickerStyleAutomatic) {
        return _datePickerStyle;
    } else {
        return UIDatePickerStyleWheels;
    }
}

+ (instancetype)showPickerWithTitle:(NSString *)title
           datePickerMode:(ActionSheetDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate
                   target:(id)target action:(SEL)action origin:(id)origin {
    ActionSheetDatePicker *picker = [[ActionSheetDatePicker alloc] initWithTitle:title datePickerMode:datePickerMode selectedDate:selectedDate target:target action:action origin:origin];
    [picker showActionSheetPicker];
    return picker;
}

+ (instancetype)showPickerWithTitle:(NSString *)title
           datePickerMode:(ActionSheetDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate
                   target:(id)target action:(SEL)action origin:(id)origin cancelAction:(SEL)cancelAction {
    ActionSheetDatePicker *picker = [[ActionSheetDatePicker alloc] initWithTitle:title datePickerMode:datePickerMode selectedDate:selectedDate target:target action:action origin:origin cancelAction:cancelAction];
    [picker showActionSheetPicker];
    return picker;
}

+ (instancetype)showPickerWithTitle:(NSString *)title
           datePickerMode:(ActionSheetDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate
              minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate
                   target:(id)target action:(SEL)action origin:(id)origin {
    ActionSheetDatePicker *picker = [[ActionSheetDatePicker alloc] initWithTitle:title datePickerMode:datePickerMode selectedDate:selectedDate target:target action:action origin:origin];
    [picker setMinimumDate:minimumDate];
    [picker setMaximumDate:maximumDate];
    [picker showActionSheetPicker];
    return picker;
}

+ (instancetype)showPickerWithTitle:(NSString *)title
           datePickerMode:(ActionSheetDatePickerMode)datePickerMode
             selectedDate:(NSDate *)selectedDate
                doneBlock:(ActionDateDoneBlock)doneBlock
              cancelBlock:(ActionDateCancelBlock)cancelBlock
                   origin:(UIView*)view
{
    ActionSheetDatePicker* picker = [[ActionSheetDatePicker alloc] initWithTitle:title
                                                                  datePickerMode:datePickerMode
                                                                    selectedDate:selectedDate
                                                                       doneBlock:doneBlock
                                                                     cancelBlock:cancelBlock
                                                                          origin:view];
    [picker showActionSheetPicker];
    return picker;
}

+ (instancetype)showPickerWithTitle:(NSString *)title
           datePickerMode:(ActionSheetDatePickerMode)datePickerMode
             selectedDate:(NSDate *)selectedDate
              minimumDate:(NSDate *)minimumDate
              maximumDate:(NSDate *)maximumDate
                doneBlock:(ActionDateDoneBlock)doneBlock
              cancelBlock:(ActionDateCancelBlock)cancelBlock
                   origin:(UIView*)view
{
    ActionSheetDatePicker* picker = [[ActionSheetDatePicker alloc] initWithTitle:title
                                                                  datePickerMode:datePickerMode
                                                                    selectedDate:selectedDate
                                                                       doneBlock:doneBlock
                                                                     cancelBlock:cancelBlock
                                                                          origin:view];
    [picker setMinimumDate:minimumDate];
    [picker setMaximumDate:maximumDate];
    [picker showActionSheetPicker];
    return picker;
}

- (id)initWithTitle:(NSString *)title datePickerMode:(ActionSheetDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate target:(id)target action:(SEL)action origin:(id)origin
{
    self = [self initWithTitle:title datePickerMode:datePickerMode selectedDate:selectedDate target:target action:action origin:origin cancelAction:nil];
    return self;
}

- (instancetype)initWithTitle:(NSString *)title datePickerMode:(ActionSheetDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate target:(id)target action:(SEL)action origin:(id)origin
{
    self = [self initWithTitle:title datePickerMode:datePickerMode selectedDate:selectedDate target:target action:action origin:origin cancelAction:nil];
    self.minimumDate = minimumDate;
    self.maximumDate = maximumDate;
    return self;
}

- (instancetype)initWithTitle:(NSString *)title datePickerMode:(ActionSheetDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate target:(id)target action:(SEL)action origin:(id)origin cancelAction:(SEL)cancelAction
{
    self = [super initWithTarget:target successAction:action cancelAction:cancelAction origin:origin];
    if (self) {
        self.title = title;
        self.datePickerMode = datePickerMode;
        self.selectedDate = selectedDate;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title datePickerMode:(ActionSheetDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate target:(id)target action:(SEL)action cancelAction:(SEL)cancelAction origin:(id)origin
{
    self = [super initWithTarget:target successAction:action cancelAction:cancelAction origin:origin];
    if (self) {
        self.title = title;
        self.datePickerMode = datePickerMode;
        self.selectedDate = selectedDate;
        self.minimumDate = minimumDate;
        self.maximumDate = maximumDate;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
               datePickerMode:(ActionSheetDatePickerMode)datePickerMode
                 selectedDate:(NSDate *)selectedDate
                    doneBlock:(ActionDateDoneBlock)doneBlock
                  cancelBlock:(ActionDateCancelBlock)cancelBlock
                       origin:(UIView*)origin
{
    self = [self initWithTitle:title datePickerMode:datePickerMode selectedDate:selectedDate target:nil action:nil origin:origin];
    if (self) {
        self.onActionSheetDone = doneBlock;
        self.onActionSheetCancel = cancelBlock;
    }
    return self;
}

- (CoreActionSheetMonthYearPickerMode) CoreActionSheetMonthYearPickerMode {
    switch (self.datePickerMode) {
        case ActionSheetDatePickerModeMonthAndYear:
            return CoreActionSheetMonthYearPickerModeMonthAndYear;
        case ActionSheetDatePickerModeYear:
            return CoreActionSheetMonthYearPickerModeYear;
        default:
            return CoreActionSheetMonthYearPickerModeMonthAndYear;
    }
}

- (UIDatePickerMode) uiDatePickerMode {
    switch (self.datePickerMode) {
        case ActionSheetDatePickerModeTime:
            return UIDatePickerModeTime;
        case ActionSheetDatePickerModeDate:
            return UIDatePickerModeDate;
        case ActionSheetDatePickerModeDateAndTime:
            return UIDatePickerModeDateAndTime;
        case ActionSheetDatePickerModeCountDownTimer:
            return UIDatePickerModeCountDownTimer;
        default:
            return UIDatePickerModeTime;
    }
}

- (BOOL) isSystemDatePicker {
    switch (self.datePickerMode) {
        case ActionSheetDatePickerModeTime:
        case ActionSheetDatePickerModeDate:
        case ActionSheetDatePickerModeDateAndTime:
        case ActionSheetDatePickerModeCountDownTimer:
            return YES;
        case ActionSheetDatePickerModeMonthAndYear:
        case ActionSheetDatePickerModeYear:
            return NO;
    }
}

- (UIView *)configuredPickerView {
    UIView* datePicker;
    if ([self isSystemDatePicker]) {
        datePicker = [self createSystemDatePicker];
    } else {
        datePicker = [self createCustomPicker];
    }
    
    //need to keep a reference to the picker so we can clear the DataSource / Delegate when dismissing (not used in this picker, but just in case somebody uses this as a template for another picker)
    self.pickerView = datePicker;

    return datePicker;
}

- (UIView*) createCustomPicker {
    CoreActionSheetMonthYearPicker *datePicker = [[CoreActionSheetMonthYearPicker alloc] initWithFrame: CGRectMake(0, 40, self.viewSize.width, kActionSheetDefaultHeight)];
    datePicker.datePickerMode = [self CoreActionSheetMonthYearPickerMode];
    datePicker.maximumDate = self.maximumDate;
    datePicker.minimumDate = self.minimumDate;
    datePicker.calendar = self.calendar;
    datePicker.locale = self.locale;
    datePicker.pickerTextAttributes = self.pickerTextAttributes;
    datePicker.date = self.selectedDate;
    [datePicker addTarget:self action:@selector(eventForDatePicker:) forControlEvents:UIControlEventValueChanged];
    return datePicker;
}

- (UIView*) createSystemDatePicker {
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame: CGRectMake(0, 40, self.viewSize.width, kActionSheetDefaultHeight)];
    datePicker.datePickerMode = [self uiDatePickerMode];
    datePicker.maximumDate = self.maximumDate;
    datePicker.minimumDate = self.minimumDate;
    datePicker.minuteInterval = self.minuteInterval;
    datePicker.calendar = self.calendar;
    datePicker.timeZone = self.timeZone;
    datePicker.locale = self.locale;
    if (@available(iOS 13.4, *)) {
        datePicker.preferredDatePickerStyle = self.datePickerStyle;
    } else {
        UIColor *textColor = [self.pickerTextAttributes valueForKey:NSForegroundColorAttributeName];
        if (textColor) {
            [datePicker setValue:textColor forKey:@"textColor"]; // use ObjC runtime to set value for property that is not exposed publicly
        }
    }
    
    // if datepicker is set with a date in countDownMode then
    // 1h is added to the initial countdown
    if (self.datePickerMode == ActionSheetDatePickerModeCountDownTimer) {
        datePicker.countDownDuration = self.countDownDuration;
        // Due to a bug in UIDatePicker, countDownDuration needs to be set asynchronously
        // more info: http://stackoverflow.com/a/20204317/1161723
        dispatch_async(dispatch_get_main_queue(), ^{
            datePicker.countDownDuration = self.countDownDuration;
        });
    } else {
        [datePicker setDate:self.selectedDate animated:NO];
    }
    
    [datePicker addTarget:self action:@selector(eventForDatePicker:) forControlEvents:UIControlEventValueChanged];

    return datePicker;
}

- (void)notifyTarget:(id)target didSucceedWithAction:(SEL)action origin:(id)origin
{
    if (self.onActionSheetDone)
    {
        if (self.datePickerMode == ActionSheetDatePickerModeCountDownTimer)
            self.onActionSheetDone(self, @(((UIDatePicker *)self.pickerView).countDownDuration), origin);
        else
            self.onActionSheetDone(self, self.selectedDate, origin);

        return;
    }
    else if ([target respondsToSelector:action])
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if (self.datePickerMode == ActionSheetDatePickerModeCountDownTimer) {
            [target performSelector:action withObject:@(((UIDatePicker *)self.pickerView).countDownDuration) withObject:origin];

        } else {
            [target performSelector:action withObject:self.selectedDate withObject:origin];
        }
#pragma clang diagnostic pop
        else
            NSAssert(NO, @"Invalid target/action ( %s / %s ) combination used for ActionSheetPicker", object_getClassName(target), sel_getName(action));
}

- (void)notifyTarget:(id)target didCancelWithAction:(SEL)cancelAction origin:(id)origin
{
    if (self.onActionSheetCancel)
    {
        self.onActionSheetCancel(self);
        return;
    }
    else
        if ( target && cancelAction && [target respondsToSelector:cancelAction] )
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:cancelAction withObject:origin];
#pragma clang diagnostic pop
        }
}

- (void)eventForDatePicker:(id)sender
{
    if (!sender)
        return;
    
    if ([sender isKindOfClass:[UIDatePicker class]]) {
        UIDatePicker *datePicker = (UIDatePicker *)sender;
        self.selectedDate = datePicker.date;
        self.countDownDuration = datePicker.countDownDuration;
        return;
    }
    
    if ([sender isKindOfClass:[CoreActionSheetMonthYearPicker class]]) {
        CoreActionSheetMonthYearPicker *datePicker = (CoreActionSheetMonthYearPicker *)sender;
        self.selectedDate = datePicker.date;
        return;
    }
}

- (void)customButtonPressed:(id)sender {
    UIBarButtonItem *button = (UIBarButtonItem*)sender;
    NSInteger index = button.tag;
    NSAssert((index >= 0 && index < self.customButtons.count), @"Bad custom button tag: %zd, custom button count: %zd", index, self.customButtons.count);
    NSDictionary *buttonDetails = (self.customButtons)[(NSUInteger) index];
    NSAssert(buttonDetails != NULL, @"Custom button dictionary is invalid");

    ActionType actionType = (ActionType) [buttonDetails[kActionType] integerValue];
    switch (actionType) {
        case ActionTypeValue: {
            NSAssert([self.pickerView respondsToSelector:@selector(setDate:animated:)], @"Bad pickerView for ActionSheetDatePicker, doesn't respond to setDate:animated:");
            NSDate *itemValue = buttonDetails[kButtonValue];
            id picker = self.pickerView;
            if (self.datePickerMode != ActionSheetDatePickerModeCountDownTimer)
            {
                if ([picker isKindOfClass:[UIDatePicker class]]) {
                    UIDatePicker *datePicker = (UIDatePicker *)picker;
                    [datePicker setDate:itemValue animated:YES];
                }
                
                if ([picker isKindOfClass:[CoreActionSheetMonthYearPicker class]]) {
                    CoreActionSheetMonthYearPicker *datePicker = (CoreActionSheetMonthYearPicker *)picker;
                    [datePicker setDate:itemValue animated:YES];
                }
                
                [self eventForDatePicker:picker];
            }
            break;
        }

        case ActionTypeBlock:
        case ActionTypeSelector:
            [super customButtonPressed:sender];
            break;

        default:
            NSAssert(false, @"Unknown action type");
            break;
    }
}

- (CGFloat)getDatePickerHeight
{
    CGFloat height = kActionSheetDefaultHeight;
    if ([self isSystemDatePicker]) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 140000 // Xcode 12 and iOS 14, or greater
        if (@available(iOS 14.0, *)) {
            if (_datePickerStyle == UIDatePickerStyleCompact) {
                height = 90.0;
            } else if (_datePickerStyle == UIDatePickerStyleInline) {
                switch (_datePickerMode) {
                    case ActionSheetDatePickerModeDate:
                        height = 350.0;
                        break;
                    case ActionSheetDatePickerModeTime:
                        height = 90.0;
                        break;
                    default: // ActionSheetDatePickerModeDateAndTime
                        height = 400.0;
                        break;
                }
            }
        }
#endif
    }
    return height;
}

@end
