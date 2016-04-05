//
//  ActionSheetPickerCustomPickerDelegate.h
//  ActionSheetPicker
//
//  Created by  on 13/03/2012.
//  Copyright (c) 2012 Club 15CC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreActionSheetPicker/CoreActionSheetPicker.h>



@interface ActionSheetPickerCustomPickerDelegate : NSObject <ActionSheetCustomPickerDelegate>
{
    NSArray *notesToDisplayForKey;
    NSArray *scaleNames;
}

@property (nonatomic, strong) NSString *selectedKey;
@property (nonatomic, strong) NSString *selectedScale;

@end
