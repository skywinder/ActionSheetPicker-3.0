//
//Copyright (c) 2016, Olivier Demolliens
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

#import "ActionSheetStringMultipleSelectionPicker.h"
#import "PickerView.h""


@interface ActionSheetStringMultipleSelectionPicker()
@property (nonatomic,strong) NSArray *data;
@property (nonatomic,strong) NSMutableArray *selectedIndex;
@property (nonatomic,strong) NSNumber* currentIndex;
@end

@implementation ActionSheetStringMultipleSelectionPicker

+ (instancetype)showPickerWithTitle:(NSString *)title rows:(NSArray *)strings initialSelection:(NSArray *)selectedIndexes doneBlock:(ActionStringMultipleSelectionDoneBlock)doneBlock cancelBlock:(ActionStringMultipleSelectionCancelBlock)cancelBlockOrNil origin:(id)origin {
    ActionSheetStringMultipleSelectionPicker * picker = [[ActionSheetStringMultipleSelectionPicker alloc] initWithTitle:title rows:strings initialSelection:selectedIndexes doneBlock:doneBlock cancelBlock:cancelBlockOrNil origin:origin];
    [picker showActionSheetPicker];
    return picker;
}

- (instancetype)initWithTitle:(NSString *)title rows:(NSArray *)strings initialSelection:(NSArray *)selectedIndexes doneBlock:(ActionStringMultipleSelectionDoneBlock)doneBlock cancelBlock:(ActionStringMultipleSelectionCancelBlock)cancelBlockOrNil origin:(id)origin {
    self = [self initWithTitle:title rows:strings initialSelection:selectedIndexes target:nil successAction:nil cancelAction:nil origin:origin];
    if (self) {
        self.onActionSheetDone = doneBlock;
        self.onActionSheetCancel = cancelBlockOrNil;
    }
    return self;
}

+ (instancetype)showPickerWithTitle:(NSString *)title rows:(NSArray *)data initialSelection:(NSArray *)selectedIndexes target:(id)target successAction:(SEL)successAction cancelAction:(SEL)cancelActionOrNil origin:(id)origin {
    ActionSheetStringMultipleSelectionPicker *picker = [[ActionSheetStringMultipleSelectionPicker alloc] initWithTitle:title rows:data initialSelection:selectedIndexes target:target successAction:successAction cancelAction:cancelActionOrNil origin:origin];
    [picker showActionSheetPicker];
    return picker;
}

- (instancetype)initWithTitle:(NSString *)title rows:(NSArray *)data initialSelection:(NSArray *)selectedIndexes target:(id)target successAction:(SEL)successAction cancelAction:(SEL)cancelActionOrNil origin:(id)origin {
    self = [self initWithTarget:target successAction:successAction cancelAction:cancelActionOrNil origin:origin];
    if (self) {
        self.data = data;
        self.selectedIndex = [[NSMutableArray alloc]initWithArray:selectedIndexes];
        self.currentIndex = 0;
        self.title = title;
    }
    return self;
}


- (UIView *)configuredPickerView {
    if (!self.data)
        return nil;
    CGRect pickerFrame = CGRectMake(0, 40, self.viewSize.width, 216);
    PickerView *stringPicker = [[PickerView alloc] initWithFrame:pickerFrame];
    stringPicker.delegate = self;
    stringPicker.dataSource = self;
    
    if (self.data.count == 0) {
        stringPicker.showsSelectionIndicator = NO;
        stringPicker.userInteractionEnabled = NO;
    } else {
        stringPicker.showsSelectionIndicator = YES;
        stringPicker.userInteractionEnabled = YES;
    }
    
    //need to keep a reference to the picker so we can clear the DataSource / Delegate when dismissing
    self.pickerView = stringPicker;
    
    UITapGestureRecognizer * singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleSelection:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    [self.pickerView addGestureRecognizer:singleTapGestureRecognizer];
    
    return stringPicker;
}

- (void)notifyTarget:(id)target didSucceedWithAction:(SEL)successAction origin:(id)origin {
    if (self.onActionSheetDone) {
        _onActionSheetDone(self, [self selectedIndex], [self selection]);
        return;
    }
    else if (target && [target respondsToSelector:successAction]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [target performSelector:successAction withObject:self.selectedIndex withObject:origin];
#pragma clang diagnostic pop
        return;
    }
    NSLog(@"Invalid target/action ( %s / %s ) combination used for ActionSheetPicker and done block is nil.", object_getClassName(target), sel_getName(successAction));
}

- (void)notifyTarget:(id)target didCancelWithAction:(SEL)cancelAction origin:(id)origin {
    if (self.onActionSheetCancel) {
        _onActionSheetCancel(self);
        return;
    }
    else if (target && cancelAction && [target respondsToSelector:cancelAction]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [target performSelector:cancelAction withObject:origin];
#pragma clang diagnostic pop
    }
}

#pragma mark - UIPickerViewDelegate / DataSource

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.currentIndex = [[NSNumber alloc]initWithInt:row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.data.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    id obj = (self.data)[(NSUInteger) row];
    
    // return the object if it is already a NSString,
    // otherwise, return the description, just like the toString() method in Java
    // else, return nil to prevent exception
    
    if ([obj isKindOfClass:[NSString class]])
        return obj;
    
    if ([obj respondsToSelector:@selector(description)])
        return [obj performSelector:@selector(description)];
    
    return nil;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    id obj = (self.data)[(NSUInteger) row];
    
    // return the object if it is already a NSString,
    // otherwise, return the description, just like the toString() method in Java
    // else, return nil to prevent exception
    
    if ([obj isKindOfClass:[NSString class]])
        return [[NSAttributedString alloc] initWithString:obj attributes:self.pickerTextAttributes];
    
    if ([obj respondsToSelector:@selector(description)])
        return [[NSAttributedString alloc] initWithString:[obj performSelector:@selector(description)] attributes:self.pickerTextAttributes];
    
    return nil;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    
    UITableViewCell *cell = (UITableViewCell *)view;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setBounds:CGRectMake(0, 0, cell.frame.size.width - 20, 44)];
        cell.tag = row;
        cell.userInteractionEnabled = true;
    }
    
    id obj = (self.data)[(NSUInteger) row];
    
    if ([self.selectedIndex indexOfObject:[NSNumber numberWithInt:row]] != NSNotFound) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    cell.textLabel.text = obj;
    
    return cell;
}

- (NSArray *)selection {
    NSMutableArray * indexes = [NSMutableArray array];
    
    for (int j = 0; j < self.selectedIndex.count; j++) {
        
        id object = [self.data objectAtIndex:j];
        
        [indexes addObject: object];
    }
    return [indexes copy];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return pickerView.frame.size.width - 30;
}

- (void)toggleSelection:(UITapGestureRecognizer *)recognizer {
    
    if(self.currentIndex!=nil){
        
        PickerView *picker =  self.pickerView;
        
        
        UIView* cellView = [picker viewForRow:self.currentIndex.intValue forComponent:0];
        
        NSPredicate *valuePredicate=[NSPredicate predicateWithFormat:@"self.intValue == %d",self.currentIndex];
        
        if ([self.selectedIndex indexOfObject:self.currentIndex] != NSNotFound) {

            [self.selectedIndex removeObject:self.currentIndex];
            [(UITableViewCell *)cellView setAccessoryType:UITableViewCellAccessoryNone];
        }else  {
            [self.selectedIndex addObject:self.currentIndex];
            [(UITableViewCell *)cellView setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        
        
    }
    
    /* NSNumber *row = [NSNumber numberWithInt:recognizer.view.tag];
     NSUInteger ind ex = [self.selectedIndex indexOfObject:row];
     if (index != NSNotFound) {
     [self.selectedIndex removeObjectAtIndex:index];
     [(UITableViewCell *)(recognizer.view) setAccessoryType:UITableViewCellAccessoryNone];
     } else { [self.selectedIndex addObject:row];
     [(UITableViewCell *)(recognizer.view) setAccessoryType:UITableViewCellAccessoryCheckmark];
     }*/
}

@end
