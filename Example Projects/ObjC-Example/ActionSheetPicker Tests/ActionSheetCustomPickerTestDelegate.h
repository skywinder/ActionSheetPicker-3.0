//
// Created by Petr Korolev on 12/12/14.
//

#import <Foundation/Foundation.h>
#import <CoreActionSheetPicker/CoreActionSheetPicker.h>


@interface ActionSheetCustomPickerTestDelegate : NSObject <ActionSheetCustomPickerDelegate>
{
    NSArray *notesToDisplayForKey;
    NSArray *scaleNames;
}

@property (nonatomic, strong) NSString *selectedKey;
@property (nonatomic, strong) NSString *selectedScale;

@property(nonatomic, strong) XCTestExpectation *delegateReturnCorrectValueExpectation;
@end
