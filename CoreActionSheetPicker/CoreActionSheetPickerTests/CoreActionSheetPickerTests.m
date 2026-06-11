//
//  CoreActionSheetPickerTests.m
//  CoreActionSheetPickerTests
//
//  Created by Petr Korolev on 17/04/15.
//  Copyright (c) 2015 Petr Korolev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ActionSheetStringPicker.h"

// Expose the private toolbar factory for geometry assertions.
@interface AbstractActionSheetPicker (TestingHooks)
- (UIToolbar *)createPickerToolbarWithTitle:(NSString *)aTitle;
@end

// Subclass that presents with a hidden toolbar, to cover the
// toolbar.hidden layout branch in showActionSheetPicker.
@interface HiddenToolbarStringPicker : ActionSheetStringPicker
@end

@implementation HiddenToolbarStringPicker
- (UIToolbar *)createPickerToolbarWithTitle:(NSString *)aTitle {
    UIToolbar *toolbar = [super createPickerToolbarWithTitle:aTitle];
    toolbar.hidden = YES;
    return toolbar;
}
@end

@interface CoreActionSheetPickerTests : XCTestCase
@property (nonatomic, strong) UIView *origin;
@end

@implementation CoreActionSheetPickerTests

- (void)setUp {
    [super setUp];
    self.origin = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
}

- (CGFloat)expectedToolbarTopInset {
    if (@available(iOS 26.0, *)) {
        return 16.0;
    }
    return 0.0;
}

- (ActionSheetStringPicker *)makePicker {
    return [[ActionSheetStringPicker alloc] initWithTitle:@"Title"
                                                     rows:@[@"a", @"b", @"c"]
                                         initialSelection:0
                                                doneBlock:nil
                                              cancelBlock:nil
                                                   origin:self.origin];
}

#pragma mark - Toolbar inset (#590)

- (void)testToolbarTopInsetMatchesOSVersion {
    ActionSheetStringPicker *picker = [self makePicker];
    UIToolbar *toolbar = [picker createPickerToolbarWithTitle:@"Title"];
    XCTAssertEqualWithAccuracy(toolbar.frame.origin.y, [self expectedToolbarTopInset], 0.01);
    XCTAssertEqualWithAccuracy(toolbar.frame.size.height, 44.0, 0.01);
}

#pragma mark - Presented sheet geometry (#590)

- (void)testPresentedPickerGeometry {
    ActionSheetStringPicker *picker = [self makePicker];
    [picker showActionSheetPicker];

    CGFloat inset = [self expectedToolbarTopInset];

    XCTAssertNotNil(picker.toolbar);
    XCTAssertEqualWithAccuracy(picker.toolbar.frame.origin.y, inset, 0.01);

    // ActionSheetStringPicker frames its UIPickerView at y=40; on iOS 26 the
    // base class shifts it 8pt down to clear the inset toolbar.
    CGFloat expectedPickerY = 40.0 + (inset > 0 ? 8.0 : 0.0);
    XCTAssertEqualWithAccuracy(picker.pickerView.frame.origin.y, expectedPickerY, 0.01);

    // The sheet container grows by the toolbar inset (safe-area bottom is 0
    // in a hostless test bundle, keyWindow being nil).
    UIView *masterView = picker.toolbar.superview;
    XCTAssertNotNil(masterView);
    XCTAssertEqualWithAccuracy(masterView.frame.size.height, 216.0 + inset, 0.01);

    [picker hidePickerWithCancelAction];
}

- (void)testHiddenToolbarSkipsPickerShift {
    HiddenToolbarStringPicker *picker =
        [[HiddenToolbarStringPicker alloc] initWithTitle:@"Title"
                                                    rows:@[@"a", @"b", @"c"]
                                        initialSelection:0
                                               doneBlock:nil
                                             cancelBlock:nil
                                                  origin:self.origin];
    [picker showActionSheetPicker];

    // The hidden-toolbar branch repositions the picker to y=halfBorderWidth
    // (0 by default) inside a fixed 220pt container; the iOS 26 toolbar
    // shift must not apply because there is no toolbar to keep clear of.
    XCTAssertEqualWithAccuracy(picker.pickerView.frame.origin.y, 0.0, 0.01);

    UIView *masterView = picker.toolbar.superview;
    XCTAssertNotNil(masterView);
    XCTAssertEqualWithAccuracy(masterView.frame.size.height, 220.0, 0.01);

    [picker hidePickerWithCancelAction];
}

#pragma mark - Tap-dismiss retry budget (#579)

- (void)testRetryCountResetsOnEachShow {
    ActionSheetStringPicker *picker = [self makePicker];
    [picker setValue:@99 forKey:@"windowTapActionRetryCount"];

    [picker showActionSheetPicker];

    // showActionSheetPicker resets the budget; addTapDismissAction may have
    // consumed at most one retry before the window attaches.
    NSInteger count = [[picker valueForKey:@"windowTapActionRetryCount"] integerValue];
    XCTAssertLessThanOrEqual(count, 1);

    [picker hidePickerWithCancelAction];
}

@end
