//
//  ActionSheetDatePickerTestCase.m
//  ActionSheetPicker
//
//  Created by Vladislava Kirichenko on 10/22/14.
//
//

#import <XCTest/XCTest.h>
#import <CoreActionSheetPicker/CoreActionSheetPicker.h>
#import <CoreActionSheetPicker/ActionSheetDatePicker.h>
#import "AbstractActionSheetPicker+CustomButton.h"

static const int countdownTestInt = 360;
UIView           *origin;

@interface ActionSheetDatePickerTestCase : XCTestCase
@property(nonatomic, strong) ActionSheetDatePicker *actionSheetDatePicker;
@end

@implementation ActionSheetDatePickerTestCase
{
    NSString *_title;
}

+ (void)setUp
{
    UIWindow *window  = [[UIApplication sharedApplication] keyWindow];
    UIView   *topView = window.rootViewController.view;
    origin = topView;
}

- (void)setUp
{
    [super setUp];
    _title                 = @"Title";
    _actionSheetDatePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Test title" datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date] target:nil action:nil origin:origin cancelAction:nil];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitPicker
{
    _actionSheetDatePicker = [[ActionSheetDatePicker alloc] initWithTarget:self successAction:@selector(exampleSelector) cancelAction:@selector(exampleSelector) origin:origin];
    XCTAssertNotNil(_actionSheetDatePicker);
}

- (void)testInitPicker2
{
    _actionSheetDatePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"" datePickerMode:UIDatePickerModeCountDownTimer selectedDate:[NSDate date] doneBlock:nil cancelBlock:nil origin:origin];
    XCTAssertNotNil(_actionSheetDatePicker);
}

- (void)testInitPicker3
{
    _actionSheetDatePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"" datePickerMode:UIDatePickerModeCountDownTimer selectedDate:[NSDate date] target:self action:@selector(exampleSelector) origin:origin];
    XCTAssertNotNil(_actionSheetDatePicker);
}

- (void)testInitPicker4
{
    _actionSheetDatePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"" datePickerMode:UIDatePickerModeCountDownTimer selectedDate:NSDate.date target:self action:@selector(exampleSelector) origin:origin cancelAction:@selector(exampleSelector)];
    XCTAssertNotNil(_actionSheetDatePicker);
}

- (void)testInitPicker5
{
    _actionSheetDatePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"" datePickerMode:UIDatePickerModeCountDownTimer selectedDate:[NSDate date] minimumDate:[NSDate date] maximumDate:[NSDate date] target:self action:@selector(exampleSelector) origin:origin];
    XCTAssertNotNil(_actionSheetDatePicker);
}

- (void)testInitPicker6
{
    _actionSheetDatePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"" datePickerMode:UIDatePickerModeCountDownTimer selectedDate:NSDate.date minimumDate:NSDate.date maximumDate:NSDate.date target:self action:@selector(exampleSelector) cancelAction:@selector(exampleSelector) origin:origin];
    XCTAssertNotNil(_actionSheetDatePicker);
}

- (void)testPickerWithCustomActionBlockOnButton
{
    NSString *custom_title = @"Custom label:";

    [_actionSheetDatePicker addCustomButtonWithTitle:custom_title actionBlock:^{
        NSLog(@"Test block invoked");
    }];
    [_actionSheetDatePicker showActionSheetPicker];

    [_actionSheetDatePicker pressFirstCustomButton];

    XCTAssertNotNil(_actionSheetDatePicker);
}

- (void)testPickerWithCustomActionBlockOnButtonAndNilString
{
    [_actionSheetDatePicker addCustomButtonWithTitle:nil actionBlock:^{
        NSLog(@"Test block invoked");
    }];
    [_actionSheetDatePicker showActionSheetPicker];

    [_actionSheetDatePicker pressFirstCustomButton];

    XCTAssertNotNil(_actionSheetDatePicker);
}

- (void)testPickerWithNilCustomActionBlockOnButton
{
    [_actionSheetDatePicker addCustomButtonWithTitle:_title actionBlock:nil];
    [_actionSheetDatePicker showActionSheetPicker];

    [_actionSheetDatePicker pressFirstCustomButton];

    XCTAssertNotNil(_actionSheetDatePicker);
}

- (void)testPickerWithNilCustomActionBlockOnButtonAndNilString
{
    [_actionSheetDatePicker addCustomButtonWithTitle:nil actionBlock:nil];
    [_actionSheetDatePicker showActionSheetPicker];

    [_actionSheetDatePicker pressFirstCustomButton];

    XCTAssertNotNil(_actionSheetDatePicker);
}

- (void)testPickerWithCustomActionSelectorOnButton
{
    [_actionSheetDatePicker addCustomButtonWithTitle:_title target:self selector:@selector(exampleSelector)];
    [_actionSheetDatePicker showActionSheetPicker];

    [_actionSheetDatePicker pressFirstCustomButton];

    XCTAssertNotNil(_actionSheetDatePicker);
}

- (void)testPickerWithCustomActionSelectorOnButtonAndNilString
{
    [_actionSheetDatePicker addCustomButtonWithTitle:nil target:self selector:@selector(exampleSelector)];
    [_actionSheetDatePicker showActionSheetPicker];

    [_actionSheetDatePicker pressFirstCustomButton];

    XCTAssertNotNil(_actionSheetDatePicker);
}

- (void)testPickerWithNilCustomActionSelectorOnButton
{
    [_actionSheetDatePicker addCustomButtonWithTitle:_title target:self selector:nil];
    [_actionSheetDatePicker showActionSheetPicker];

    [_actionSheetDatePicker pressFirstCustomButton];

    XCTAssertNotNil(_actionSheetDatePicker);
}

- (void)testPickerWithCustomActionSelectorOnButtonAndNilTarget
{
    [_actionSheetDatePicker addCustomButtonWithTitle:_title target:nil selector:@selector(exampleSelector)];
    [_actionSheetDatePicker showActionSheetPicker];

    [_actionSheetDatePicker pressFirstCustomButton];

    XCTAssertNotNil(_actionSheetDatePicker);
}

- (void)testPickerWithNilCustomActionSelectorOnButtonNilTargetAndNilString
{
    [_actionSheetDatePicker addCustomButtonWithTitle:nil target:nil selector:nil];
    [_actionSheetDatePicker showActionSheetPicker];

    [_actionSheetDatePicker pressFirstCustomButton];

    XCTAssertNotNil(_actionSheetDatePicker);
}

- (void)testPickerCountDownTimerModeValueWithSelector
{
    _actionSheetDatePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Test title" datePickerMode:UIDatePickerModeCountDownTimer selectedDate:nil target:self action:@selector(countDownTest:) origin:origin cancelAction:nil];
    _actionSheetDatePicker.countDownDuration = countdownTestInt;
    [_actionSheetDatePicker showActionSheetPicker];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:0.5f];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_actionSheetDatePicker pressDoneButton];
        });
    });

    XCTAssertNotNil(_actionSheetDatePicker);
}

- (void)testPickerCountDownTimerModeValueWithBlock
{
    _actionSheetDatePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Test" datePickerMode:UIDatePickerModeCountDownTimer selectedDate:nil doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        XCTAssertEqualObjects(selectedDate, @(countdownTestInt));
        XCTAssertEqualObjects(@(picker.countDownDuration), @(countdownTestInt));
    }                                                         cancelBlock:nil origin:origin];

    _actionSheetDatePicker.countDownDuration = countdownTestInt;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:0.5f];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_actionSheetDatePicker pressDoneButton];
        });
    });
    [_actionSheetDatePicker showActionSheetPicker];

    XCTAssertNotNil(_actionSheetDatePicker);
}

- (void)countDownTest:(NSNumber *)number
{
    XCTAssertEqualObjects(number, @(countdownTestInt));
}

- (void)exampleSelector
{
    NSLog(@"Test selector invoked");
}

@end
