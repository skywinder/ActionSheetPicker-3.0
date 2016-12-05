//
// Created by Vladislava Kirichenko on 10/29/14.
//

#import "AbstractActionSheetPicker+CustomButton.h"


@implementation AbstractActionSheetPicker (CustomButton)

- (void)pressFirstCustomButton
{
    //6 items in _actionSheetDatePicker.toolbar.items : [ cancel - custom - separator - title - separator - done ]
    //So, check custom button:
    UIBarButtonItem *customBarButton = self.toolbar.items[1];

    SuppressPerformSelectorLeakWarning (
            [customBarButton.target performSelector:customBarButton.action withObject:customBarButton];
    );
}

- (void)pressDoneButton
{
    //6 items in _actionSheetDatePicker.toolbar.items : [ cancel - separator - title - separator - done ]
    //So, check custom button:
    UIBarButtonItem *customBarButton = self.toolbar.items.lastObject;
    SuppressPerformSelectorLeakWarning (
            [customBarButton.target performSelector:customBarButton.action withObject:customBarButton];
    );
}

@end
