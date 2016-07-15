//
//  AbstractActionSheetPickerTestCase.m
//  Example
//
//  Created by Petr Korolev on 07/10/14.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <CoreActionSheetPicker/ActionSheetStringPicker.h>
#import "AbstractActionSheetPicker+CustomButton.h"
static UIView *origin;

@interface AbstractActionSheetPickerTestCase : XCTestCase
@property(nonatomic, strong) ActionSheetStringPicker *sheetStringPicker;
@property(nonatomic, strong) UIView *origin;
@end

@implementation AbstractActionSheetPickerTestCase
{
    NSString *_title;
}

+(void)setUp{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *topView = window.rootViewController.view;
    origin = topView;
}

- (void)setUp
{
    [super setUp];
    _title             = @"Title";
    _sheetStringPicker = [[ActionSheetStringPicker alloc] initWithTitle:_title rows:@[@"1", @"2", @"3"] initialSelection:0 doneBlock:nil cancelBlock:nil origin:origin];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _sheetStringPicker = nil;
    [super tearDown];
}

- (void)testCustomFontNameWithTextAttributes
{
    _sheetStringPicker.titleTextAttributes = @{NSFontAttributeName : [UIFont fontWithName:@"Palatino-BoldItalic" size:16.f]};
    [_sheetStringPicker showActionSheetPicker];
    XCTAssertNotNil(_sheetStringPicker);
}


- (void)testCustomFontNameWithAttributedText
{
    NSString *string = @"Custom label:";
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [attString.string rangeOfString:string];
    [attString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Palatino-BoldItalic" size:16.f] range:range];

    _sheetStringPicker.attributedTitle = attString;
    [_sheetStringPicker showActionSheetPicker];
    XCTAssertNotNil(_sheetStringPicker);
}

- (void)testCustomFontNameWithAttributedTextAndTextAttributes
{
    NSString *string = @"Custom label:";
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [attString.string rangeOfString:string];
    [attString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Palatino-BoldItalic" size:16.f] range:range];

    _sheetStringPicker.attributedTitle = attString;
    _sheetStringPicker.titleTextAttributes = @{NSFontAttributeName : [UIFont fontWithName:@"Palatino-BoldItalic" size:16.f]};
    
    [_sheetStringPicker showActionSheetPicker];
    XCTAssertNotNil(_sheetStringPicker);
}

- (void)testPickerWithCustomActionBlockOnButton
{
    NSString *custom_title = @"Custom label:";

    [_sheetStringPicker addCustomButtonWithTitle:custom_title actionBlock:^{
        NSLog(@"Test block invoked");
    }];
    [_sheetStringPicker showActionSheetPicker];
    
    [_sheetStringPicker pressFirstCustomButton];
    
    XCTAssertNotNil(_sheetStringPicker);
}

- (void)testPickerWithCustomActionBlockOnButtonAndNilString
{
    [_sheetStringPicker addCustomButtonWithTitle:nil actionBlock:^{
        NSLog(@"Test block invoked");
    }];
    [_sheetStringPicker showActionSheetPicker];
    
    [_sheetStringPicker pressFirstCustomButton];
    
    XCTAssertNotNil(_sheetStringPicker);
}

- (void)testPickerWithNilCustomActionBlockOnButton
{
    [_sheetStringPicker addCustomButtonWithTitle:_title actionBlock:nil];
    [_sheetStringPicker showActionSheetPicker];
    
    [_sheetStringPicker pressFirstCustomButton];
    
    XCTAssertNotNil(_sheetStringPicker);
}

- (void)testPickerWithNilCustomActionBlockOnButtonAndNilString
{
    [_sheetStringPicker addCustomButtonWithTitle:nil actionBlock:nil];
    [_sheetStringPicker showActionSheetPicker];
    
    [_sheetStringPicker pressFirstCustomButton];
    
    XCTAssertNotNil(_sheetStringPicker);
}

- (void)testPickerWithCustomActionSelectorOnButton
{
    [_sheetStringPicker addCustomButtonWithTitle:_title target:self selector:@selector(exampleSelector)];
    [_sheetStringPicker showActionSheetPicker];
    
    [_sheetStringPicker pressFirstCustomButton];
    
    XCTAssertNotNil(_sheetStringPicker);
}

- (void)testPickerWithCustomActionSelectorOnButtonAndNilString
{
    [_sheetStringPicker addCustomButtonWithTitle:nil target:self selector:@selector(exampleSelector)];
    [_sheetStringPicker showActionSheetPicker];
    
    [_sheetStringPicker pressFirstCustomButton];
    
    XCTAssertNotNil(_sheetStringPicker);
}

- (void)testPickerWithNilCustomActionSelectorOnButton
{
    [_sheetStringPicker addCustomButtonWithTitle:_title target:self selector:nil];
    [_sheetStringPicker showActionSheetPicker];
    
    [_sheetStringPicker pressFirstCustomButton];
    
    XCTAssertNotNil(_sheetStringPicker);
}

- (void)testPickerWithCustomActionSelectorOnButtonAndNilTarget
{
    [_sheetStringPicker addCustomButtonWithTitle:_title target:nil selector:@selector(exampleSelector)];
    [_sheetStringPicker showActionSheetPicker];
    
    [_sheetStringPicker pressFirstCustomButton];
    
    XCTAssertNotNil(_sheetStringPicker);
}

- (void)testPickerWithNilCustomActionSelectorOnButtonNilTargetAndNilString
{
    [_sheetStringPicker addCustomButtonWithTitle:nil target:nil selector:nil];
    [_sheetStringPicker showActionSheetPicker];
    
    [_sheetStringPicker pressFirstCustomButton];
    
    XCTAssertNotNil(_sheetStringPicker);
}

- (void)exampleSelector
{
    NSLog(@"Test selector invoked");
}

@end
