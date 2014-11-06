//
//  ViewController.m
//  TestDateMonthPicker
//
//  Created by Raptor on 6/11/14.
//  Copyright (c) 2014 YourAppApp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSArray *dateArray;
    NSArray *date29Array;
    NSArray *date30Array;
    NSArray *monthArray;
    
    NSArray *theDateArray;
    
    NSInteger selectedDate;
    NSInteger selectedMonth;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dateArray = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10",
                 @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20",
                 @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", nil];
    date29Array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10",
                   @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20",
                   @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", nil];
    date30Array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10",
                 @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20",
                 @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", nil];
    monthArray = [NSArray arrayWithObjects:@"January", @"Febuary", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December", nil];
    
    theDateArray = dateArray;
}

- (IBAction)launchDatePicker:(id)sender {
    ActionSheetCustomPicker *picker = [[ActionSheetCustomPicker alloc] initWithTitle:@"Test DatePicker"
                                                                            delegate:self
                                                                    showCancelButton:YES
                                                                              origin:sender];
    [picker showActionSheetPicker];
}

#pragma mark - ActionSheetCustomPicker Delegate
- (void)actionSheetPicker:(AbstractActionSheetPicker *)actionSheetPicker configurePickerView:(UIPickerView *)pickerView {
    NSLog(@"Delegate called, not used in this example.");
}

- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin {
    NSLog(@"Done button called. Date Selected: %@ %@", [theDateArray objectAtIndex:selectedDate], [monthArray objectAtIndex:selectedMonth]);
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    selectedDate = [pickerView selectedRowInComponent:0];
    selectedMonth = [pickerView selectedRowInComponent:1];
    if(component == 1) { // month
        if(selectedMonth == 1) { // Feb
            theDateArray = date29Array;
        } else if(selectedMonth == 3 || selectedMonth == 5 || selectedMonth == 7 || selectedMonth == 8 || selectedMonth == 10) {
            theDateArray = date30Array;
        } else {
            theDateArray = dateArray;
        }
        [pickerView reloadAllComponents];
    }
}

#pragma mark - UIPickerViewDataSource Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component == 0) {
        return [theDateArray objectAtIndex:row];
    } else {
        return [monthArray objectAtIndex:row];
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == 0) {
        return theDateArray.count;
    } else {
        return monthArray.count;
    }
}

@end
