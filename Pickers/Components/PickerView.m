//
//  PickerView.m
//  CoreActionSheetPicker
//
//  Created by Olivier Demolliens on 04/04/16.
//  Copyright © 2016 Petr Korolev. All rights reserved.
//

#import "PickerView.h"

@interface PickerView()<UIGestureRecognizerDelegate>
@end

@implementation PickerView


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return true;
}

- (void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    gestureRecognizer.delegate = self;
    [super addGestureRecognizer:gestureRecognizer];
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.hidden) {
        return nil;
    }
    else {
        if (event.type == UIEventTypeTouches) {
            for (int component = 0; component < self.numberOfComponents; component++) {
                for (int row = 0; row < [self numberOfRowsInComponent:component]; row++) {
                    UIView *view = [self viewForRow:row forComponent:0];
                    if (view) {
                        view = [view hitTest:[self convertPoint:point toView:view] withEvent:event];
                        if (view) {
                            return view;
                        }
                    }
                }
            }
        }
        return [super hitTest:point withEvent:event];
    }
}

@end
