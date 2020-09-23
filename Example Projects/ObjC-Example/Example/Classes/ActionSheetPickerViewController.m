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


#import <CoreActionSheetPicker/ActionSheetDatePicker.h>
#import "ActionSheetPickerViewController.h"
#import "NSDate+TCUtils.h"
#import "ActionSheetPickerCustomPickerDelegate.h"
#import "TestTableViewController.h"

@interface ActionSheetPickerViewController ()
- (void)measurementWasSelectedWithBigUnit:(NSNumber *)bigUnit smallUnit:(NSNumber *)smallUnit element:(id)element;

- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element;

- (void)animalWasSelected:(NSNumber *)selectedIndex element:(id)element;
@end

@implementation ActionSheetPickerViewController

@synthesize animalTextField = _animalTextField;
@synthesize dateTextField = _dateTextField;

@synthesize animals = _animals;
@synthesize selectedIndex = _selectedIndex;
@synthesize selectedDate = _selectedDate;
@synthesize selectedBigUnit = _selectedBigUnit;
@synthesize selectedSmallUnit = _selectedSmallUnit;
@synthesize actionSheetPicker = _actionSheetPicker;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.animals = @[@"Aardvark", @"Beaver", @"Cheetah", @"Deer", @"Elephant", @"Frog", @"Gopher", @"Horse", @"Impala", @"...", @"Zebra"];
    self.selectedDate = [NSDate date];
    self.selectedTime = [NSDate date];

    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
// iOS6 support
// ---
- (BOOL)shouldAutorotate
{
    return YES;
}
#else

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
#endif

#pragma mark - IBActions

- (IBAction)selectABlock:(UIControl *)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
        }
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
    };
    NSArray *colors = @[@"Red", @"Green", @"Blue", @"Orange"];
    [ActionSheetStringPicker showPickerWithTitle:@"Select a Block" rows:colors initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
}

- (IBAction)selectALocale:(UIControl *)sender {
    ActionLocaleDoneBlock done = ^(ActionSheetLocalePicker *picker, NSTimeZone *selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue.name];
        }
    };
    ActionLocaleCancelBlock cancel = ^(ActionSheetLocalePicker *picker) {
        NSLog(@"Locale Picker Canceled");
    };
    ActionSheetLocalePicker *picker = [[ActionSheetLocalePicker alloc] initWithTitle:@"Select Locale:" initialSelection:[[NSTimeZone alloc] initWithName:@"Antarctica/McMurdo"] doneBlock:done cancelBlock:cancel origin:sender];

    [picker addCustomButtonWithTitle:@"My locale" value:[NSTimeZone localTimeZone]];
    __weak UIControl *weakSender = sender;
    [picker addCustomButtonWithTitle:@"Hide" actionBlock:^{
        if ([weakSender respondsToSelector:@selector(setText:)]) {
            [weakSender performSelector:@selector(setText:) withObject:[NSTimeZone localTimeZone].name];
        }
    }];

    picker.hideCancel = YES;
    [picker showActionSheetPicker];
}


- (IBAction)selectADate:(UIControl *)sender {

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *minimumDateComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    [minimumDateComponents setYear:2000];
    NSDate *minDate = [calendar dateFromComponents:minimumDateComponents];
    NSDate *maxDate = [NSDate date];


    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"" datePickerMode:UIDatePickerModeDate selectedDate:self.selectedDate
                                                          minimumDate:minDate
                                                          maximumDate:maxDate
                                                               target:self action:@selector(dateWasSelected:element:) origin:sender];

    [self.actionSheetPicker addCustomButtonWithTitle:@"Today" value:[NSDate date]];
    [self.actionSheetPicker addCustomButtonWithTitle:@"Yesterday" value:[[NSDate date] TC_dateByAddingCalendarUnits:NSCalendarUnitDay amount:-1]];
    self.actionSheetPicker.hideCancel = YES;
    [self.actionSheetPicker showActionSheetPicker];
}

- (IBAction)selectACountdown:(UIControl *)sender {

    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@""
                                                       datePickerMode:UIDatePickerModeCountDownTimer
                                                         selectedDate:nil
                                                            doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {

                                                                NSLog(@"selectedDate: %@", selectedDate);
                                                                self.countDownTextField.text = [selectedDate stringValue];
                                                                NSLog(@"picker.countDownDuration, %f", picker.countDownDuration);
                                                                self.countDownTextField.text = [NSString stringWithFormat:@"%f", picker.countDownDuration];

                                                            } cancelBlock:^(ActionSheetDatePicker *picker) {

                NSLog(@"Cancel clicked");

            }                                                  origin:sender];

    [(ActionSheetDatePicker *) _actionSheetPicker setCountDownDuration:120];
    self.actionSheetPicker.hideCancel = YES;
    [self.actionSheetPicker showActionSheetPicker];
}


- (IBAction)selectATime:(id)sender {


    NSInteger minuteInterval = 5;
    //clamp date
    NSInteger referenceTimeInterval = (NSInteger) [self.selectedTime timeIntervalSinceReferenceDate];
    NSInteger remainingSeconds = referenceTimeInterval % (minuteInterval * 60);
    NSInteger timeRoundedTo5Minutes = referenceTimeInterval - remainingSeconds;
    if (remainingSeconds > ((minuteInterval * 60) / 2)) {/// round up
        timeRoundedTo5Minutes = referenceTimeInterval + ((minuteInterval * 60) - remainingSeconds);
    }

    self.selectedTime = [NSDate dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval) timeRoundedTo5Minutes];

    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Select a time" datePickerMode:UIDatePickerModeTime selectedDate:self.selectedTime target:self action:@selector(timeWasSelected:element:) origin:sender];
    datePicker.minuteInterval = minuteInterval;
    [datePicker addCustomButtonWithTitle:@"value" value:[NSDate date]];
    [datePicker addCustomButtonWithTitle:@"sel" target:self selector:@selector(dateSelector)];
    [datePicker addCustomButtonWithTitle:@"Block" actionBlock:^{
        NSLog(@"Block invoked");
    }];
    [datePicker showActionSheetPicker];
}

- (void)dateSelector {
    NSLog(@"SELECTOR");
}

- (IBAction)selectAMeasurement:(UIControl *)sender {
    [ActionSheetDistancePicker showPickerWithTitle:@"Select Length" bigUnitString:@"m" bigUnitMax:330 selectedBigUnit:self.selectedBigUnit smallUnitString:@"cm" smallUnitMax:99 selectedSmallUnit:self.selectedSmallUnit target:self action:@selector(measurementWasSelectedWithBigUnit:smallUnit:element:) origin:sender];
}

- (IBAction)selectAMusicalScale:(UIControl *)sender {

    ActionSheetPickerCustomPickerDelegate *delg = [[ActionSheetPickerCustomPickerDelegate alloc] init];

    NSNumber *yass1 = @1;
    NSNumber *yass2 = @2;

    NSArray *initialSelections = @[yass1, yass2];

    [ActionSheetCustomPicker showPickerWithTitle:@"Select Key & Scale" delegate:delg showCancelButton:NO origin:sender
                               initialSelections:initialSelections];
}

- (IBAction)showTableView:(id)sender {
    TestTableViewController *tableViewController = [[UIStoryboard storyboardWithName:@"Storyboard"
                                                                              bundle:nil] instantiateViewControllerWithIdentifier:@"TestTableViewController"];
    [self.navigationController pushViewController:tableViewController animated:YES];
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)selectAnAnimal:(UIControl *)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Select Animal" rows:self.animals initialSelection:self.selectedIndex target:self successAction:@selector(animalWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];

}

- (IBAction)customButtons:(id)sender {

    /* Example ActionSheetPicker using custom cancel and done Buttons */
    ActionLocaleDoneBlock done = ^(ActionSheetLocalePicker *picker, NSTimeZone *selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue.name];
        }
    };

    ActionSheetLocalePicker *picker = [[ActionSheetLocalePicker alloc] initWithTitle:@"Select Locale:" initialSelection:[[NSTimeZone alloc] initWithName:@"Antarctica/McMurdo"] doneBlock:done cancelBlock:nil origin:sender];
    [picker addCustomButtonWithTitle:@"My locale" value:[NSTimeZone localTimeZone]];

    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setImage:[UIImage imageNamed:@"ok.png"] forState:UIControlStateNormal];
    [okButton setFrame:CGRectMake(0, 0, 32, 32)];
    [picker setDoneButton:[[UIBarButtonItem alloc] initWithCustomView:okButton]];
//    [picker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:@"My Text"  style:UIBarButtonItemStylePlain target:nil action:nil]];

    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
    [cancelButton setFrame:CGRectMake(0, 0, 32, 32)];
    [picker setCancelButton:[[UIBarButtonItem alloc] initWithCustomView:cancelButton]];


    NSString *string = @"Custom label:";
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];

    UIFont *randomFont = [self getRandomFont];
    NSRange range = [attString.string rangeOfString:string];
    [attString addAttribute:NSFontAttributeName value:randomFont range:range];
    [attString addAttribute:NSStrokeColorAttributeName value:[UIColor redColor] range:range];
    [attString addAttribute:NSStrokeWidthAttributeName value:@5.0f range:range];

    picker.attributedTitle = attString;
    [picker showActionSheetPicker];
}

- (UIFont *)getRandomFont {
    NSArray *familyNames = [UIFont familyNames];
    NSString *familyName = familyNames[arc4random() % [familyNames count]];
    NSArray *namesForFamilyName = [UIFont fontNamesForFamilyName:familyName];
    NSString *fontName = namesForFamilyName[arc4random() % [namesForFamilyName count]];
    UIFont *randomFont = [UIFont fontWithName:fontName size:[UIFont systemFontSize]];
    return randomFont;
}

#pragma mark - Implementation

- (void)animalWasSelected:(NSNumber *)selectedIndex element:(id)element {
    self.selectedIndex = [selectedIndex intValue];

    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    self.animalTextField.text = (self.animals)[(NSUInteger) self.selectedIndex];
}

- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element {
    self.selectedDate = selectedDate;

    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    self.dateTextField.text = [self.selectedDate description];
}

- (void)countDownWasSelected:(NSNumber *)selectedDate element:(id)element {
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    self.countDownTextField.text = selectedDate.stringValue;
}

- (void)timeWasSelected:(NSDate *)selectedTime element:(id)element {
    self.selectedTime = selectedTime;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm a"];
    self.timeTextField.text = [dateFormatter stringFromDate:selectedTime];
}

- (void)measurementWasSelectedWithBigUnit:(NSNumber *)bigUnit smallUnit:(NSNumber *)smallUnit element:(id)element {
    self.selectedBigUnit = [bigUnit intValue];
    self.selectedSmallUnit = [smallUnit intValue];
    [element setText:[NSString stringWithFormat:@"%i m and %i cm", [bigUnit intValue], [smallUnit intValue]]];
}

- (void)actionPickerCancelled:(id)sender {
    NSLog(@"Delegate has been informed that ActionSheetPicker was cancelled");
}


- (IBAction)popoverButtonPressed:(id)sender {


    UIViewController *x = [[UIViewController alloc] init];
    x.modalPresentationStyle = UIModalPresentationFormSheet;


    x.view.backgroundColor = [UIColor whiteColor];

    UIButton *b = [UIButton buttonWithType:UIButtonTypeSystem];
    b.frame = CGRectMake(0, 0, 100, 100);
    b.backgroundColor = [UIColor greenColor];
    [b setTitle:@"Picker" forState:UIControlStateNormal];
    [b addTarget:self action:@selector(pickerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [x.view addSubview:b];

    UIButton *b2 = [UIButton buttonWithType:UIButtonTypeSystem];
    b2.frame = CGRectMake(540 - 100, 0, 100, 100);
    b2.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
    b2.backgroundColor = [UIColor redColor];
    [b2 setTitle:@"Dismiss" forState:UIControlStateNormal];
    [b2 addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [x.view addSubview:b2];

    [self presentViewController:x animated:YES completion:^{
        b2.frame = CGRectMake(x.view.bounds.size.width - 100, 0, 100, 100);
    }];

}

- (void)pickerButtonPressed:(id)sender {
    NSLog(@"Picker");

    ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"Title" rows:@[@"Row1", @"Row2", @"Row3"] initialSelection:0 doneBlock:^(ActionSheetStringPicker *stringPicker, NSInteger selectedIndex, id selectedValue) {
        NSLog(@"selectedIndex = %li", (long) selectedIndex);
    }                                                                    cancelBlock:^(ActionSheetStringPicker *stringPicker) {
        NSLog(@"picker = %@", stringPicker);
    }                                                                         origin:(UIView *) sender];

    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setImage:[UIImage imageNamed:@"ok.png"] forState:UIControlStateNormal];
    [okButton setFrame:CGRectMake(0, 0, 32, 32)];

//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone  target:picker
//                                                                               action:@selector(actionPickerDone:)];
//
//    [picker setCancelButton:barButton];

    [picker showActionSheetPicker];

}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

@end
