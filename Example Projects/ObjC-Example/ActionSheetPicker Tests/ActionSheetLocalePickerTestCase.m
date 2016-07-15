//
//  ActionSheetLocalePickerTestCase.m
//  ActionSheetPicker
//
//  Created by Petr Korolev on 13/08/14.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <CoreActionSheetPicker/CoreActionSheetPicker.h>
#import "AbstractActionSheetPicker+CustomButton.h"
UIView *origin;

@interface ActionSheetLocalePickerTestCase : XCTestCase
@property(nonatomic, strong) ActionSheetLocalePicker *actionSheetLocalePicker;

@end

@implementation ActionSheetLocalePickerTestCase
{
    NSString *_title;
}

+(void)setUp{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *topView = window.rootViewController.view;
    origin = topView;

}

- (void)setUp {
    [super setUp];
    _title                   = @"Title";
    _actionSheetLocalePicker = [[ActionSheetLocalePicker alloc] initWithTitle:@"Test title" initialSelection:nil doneBlock:nil cancelBlock:nil origin:origin];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPickerWithInitWithDefaultLocale
{
    _actionSheetLocalePicker = [[ActionSheetLocalePicker alloc] initWithTitle:@"Test title" initialSelection:nil doneBlock:nil cancelBlock:nil origin:origin];
    XCTAssertNotNil(_actionSheetLocalePicker);
}

- (void)testPickerWithInitWithLocale
{
    _actionSheetLocalePicker = [[ActionSheetLocalePicker alloc] initWithTitle:@"Test title" initialSelection:[NSTimeZone localTimeZone] doneBlock:nil cancelBlock:nil origin:origin];
    XCTAssertNotNil(_actionSheetLocalePicker);
}

- (void)testPickerWithCustomActionBlockOnButton
{
    NSString *custom_title = @"Custom label:";
    
    [_actionSheetLocalePicker addCustomButtonWithTitle:custom_title actionBlock:^{
        NSLog(@"Test block invoked");
    }];
    [_actionSheetLocalePicker showActionSheetPicker];
    
    [_actionSheetLocalePicker pressFirstCustomButton];
    
    XCTAssertNotNil(_actionSheetLocalePicker);
}

- (void)testPickerWithCustomActionBlockOnButtonAndNilString
{
    [_actionSheetLocalePicker addCustomButtonWithTitle:nil actionBlock:^{
        NSLog(@"Test block invoked");
    }];
    [_actionSheetLocalePicker showActionSheetPicker];
    
    [_actionSheetLocalePicker pressFirstCustomButton];
    
    XCTAssertNotNil(_actionSheetLocalePicker);
}

- (void)testPickerWithNilCustomActionBlockOnButton
{
    [_actionSheetLocalePicker addCustomButtonWithTitle:_title actionBlock:nil];
    [_actionSheetLocalePicker showActionSheetPicker];
    
    [_actionSheetLocalePicker pressFirstCustomButton];
    
    XCTAssertNotNil(_actionSheetLocalePicker);
}

- (void)testPickerWithNilCustomActionBlockOnButtonAndNilString
{
    [_actionSheetLocalePicker addCustomButtonWithTitle:nil actionBlock:nil];
    [_actionSheetLocalePicker showActionSheetPicker];
    
    [_actionSheetLocalePicker pressFirstCustomButton];
    
    XCTAssertNotNil(_actionSheetLocalePicker);
}

- (void)testPickerWithCustomActionSelectorOnButton
{
    [_actionSheetLocalePicker addCustomButtonWithTitle:_title target:self selector:@selector(exampleSelector)];
    [_actionSheetLocalePicker showActionSheetPicker];
    
    [_actionSheetLocalePicker pressFirstCustomButton];
    
    XCTAssertNotNil(_actionSheetLocalePicker);
}

- (void)testPickerWithCustomActionSelectorOnButtonAndNilString
{
    [_actionSheetLocalePicker addCustomButtonWithTitle:nil target:self selector:@selector(exampleSelector)];
    [_actionSheetLocalePicker showActionSheetPicker];
    
    [_actionSheetLocalePicker pressFirstCustomButton];
    
    XCTAssertNotNil(_actionSheetLocalePicker);
}

- (void)testPickerWithNilCustomActionSelectorOnButton
{
    [_actionSheetLocalePicker addCustomButtonWithTitle:_title target:self selector:nil];
    [_actionSheetLocalePicker showActionSheetPicker];
    
    [_actionSheetLocalePicker pressFirstCustomButton];
    
    XCTAssertNotNil(_actionSheetLocalePicker);
}

- (void)testPickerWithCustomActionSelectorOnButtonAndNilTarget
{
    [_actionSheetLocalePicker addCustomButtonWithTitle:_title target:nil selector:@selector(exampleSelector)];
    [_actionSheetLocalePicker showActionSheetPicker];
    
    [_actionSheetLocalePicker pressFirstCustomButton];
    
    XCTAssertNotNil(_actionSheetLocalePicker);
}

- (void)testPickerWithNilCustomActionSelectorOnButtonNilTargetAndNilString
{
    [_actionSheetLocalePicker addCustomButtonWithTitle:nil target:nil selector:nil];
    [_actionSheetLocalePicker showActionSheetPicker];
    
    [_actionSheetLocalePicker pressFirstCustomButton];
    
    XCTAssertNotNil(_actionSheetLocalePicker);
}

- (void)exampleSelector
{
    NSLog(@"Test selector invoked");
}

@end
