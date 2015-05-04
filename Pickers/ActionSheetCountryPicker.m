//
//Copyright (c) 2011, Tim Cinel
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
//åLOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "ActionSheetCountryPicker.h"

@interface ActionSheetCountryPicker()

+ (NSArray *)countryNames;
+ (NSArray *)countryCodes;
+ (NSDictionary *)countryNamesByCode;
+ (NSDictionary *)countryCodesByName;

@property (nonatomic, copy) NSString *selectedCountryName;
@property (nonatomic, copy) NSString *selectedCountryCode;
@property (nonatomic, copy) NSLocale *selectedLocale;

@property(nonatomic, strong) NSString *initialCountryCode;

@end

@implementation ActionSheetCountryPicker

+ (instancetype)showPickerWithTitle:(NSString *)title initialSelection:(NSString *)countryCode doneBlock:(ActionCountryDoneBlock)doneBlock cancelBlock:(ActionCountryCancelBlock)cancelBlockOrNil origin:(id)origin
{
    ActionSheetCountryPicker * picker = [[ActionSheetCountryPicker alloc] initWithTitle:title initialSelection:countryCode doneBlock:doneBlock cancelBlock:cancelBlockOrNil origin:origin];
    [picker showActionSheetPicker];
    return picker;
}

- (instancetype)initWithTitle:(NSString *)title initialSelection:(NSString *)countryCode doneBlock:(ActionCountryDoneBlock)doneBlock cancelBlock:(ActionCountryCancelBlock)cancelBlockOrNil origin:(id)origin
{
    self = [self initWithTitle:title initialSelection:countryCode target:nil successAction:nil cancelAction:nil origin:origin];
    if (self) {
        self.onActionSheetDone = doneBlock;
        self.onActionSheetCancel = cancelBlockOrNil;
    }
    return self;
}

+ (instancetype)showPickerWithTitle:(NSString *)title initialSelection:(NSString *)countryCode target:(id)target successAction:(SEL)successAction cancelAction:(SEL)cancelActionOrNil origin:(id)origin
{
    ActionSheetCountryPicker *picker = [[ActionSheetCountryPicker alloc] initWithTitle:title initialSelection:countryCode target:target successAction:successAction cancelAction:cancelActionOrNil origin:origin];
    [picker showActionSheetPicker];
    return picker;
}

- (instancetype)initWithTitle:(NSString *)title initialSelection:(NSString *)countryCode target:(id)target successAction:(SEL)successAction cancelAction:(SEL)cancelActionOrNil origin:(id)origin
{
    self = [self initWithTarget:target successAction:successAction cancelAction:cancelActionOrNil origin:origin];
    if (self) {
        self.initialCountryCode = countryCode;
        self.title = title;
    }
    return self;
}


- (UIView *)configuredPickerView {
    [self setSelectedRows];
    
    CGRect pickerFrame = CGRectMake(0, 40, self.viewSize.width, 216);
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    pickerView.showsSelectionIndicator = YES;
    
    [self selectCurrentLocale:pickerView];
    
    //need to keep a reference to the picker so we can clear the DataSource / Delegate when dismissing
    self.pickerView = pickerView;
    
    return pickerView;
}

- (void)selectCurrentLocale:(UIPickerView *)pickerView
{
    NSUInteger rowCountry = [[[self class] countryCodes] indexOfObject:_selectedCountryCode];
    
    if ((rowCountry != NSNotFound) ) // to fix some crashes from prev versions http://crashes.to/s/ecb0f15ce49
    {
        [pickerView selectRow:rowCountry inComponent:0 animated:YES];
    }
    else
    {
        [pickerView selectRow:0 inComponent:0 animated:YES];
    }
}

- (void)setSelectedRows
{
    NSString *countryCode;
    if (self.initialCountryCode)
        countryCode = self.initialCountryCode;
    else
    {
        NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
        countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    }
 
    self.selectedCountryCode = countryCode;
}


- (void)notifyTarget:(id)target didSucceedWithAction:(SEL)successAction origin:(id)origin {
    
    self.selectedCountryName = [[NSLocale systemLocale] displayNameForKey:NSLocaleCountryCode value:_selectedCountryCode];
    if (self.onActionSheetDone) {
        _onActionSheetDone(self, self.selectedCountryCode, self.selectedCountryName );
        return;
    }
    else if (target && [target respondsToSelector:successAction]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [target performSelector:successAction withObject:self.selectedCountryCode withObject:origin];
#pragma clang diagnostic pop
        return;
    }
    NSLog(@"Invalid target/action ( %s / %s ) combination used for ActionSheetPicker", object_getClassName(target), sel_getName(successAction));
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

/////////////////////////////////////////////////////////////////////////
#pragma mark - UIPickerViewDataSource Implementation
/////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //return 2;
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // Returns
    return (NSInteger)[[[self class] countryCodes] count];
}

/////////////////////////////////////////////////////////////////////////
#pragma mark UIPickerViewDelegate Implementation
/////////////////////////////////////////////////////////////////////////

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    if (!view)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, 245, 24)];
        label.backgroundColor = [UIColor clearColor];
        label.tag = 1;
        [view addSubview:label];
        
        UIImageView *flagView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 24, 24)];
        flagView.contentMode = UIViewContentModeScaleAspectFit;
        flagView.tag = 2;
        [view addSubview:flagView];
    }
    
    ((UILabel *)[view viewWithTag:1]).text = [[self class] countryNames][(NSUInteger)row];
    NSString *imagePath = [NSString stringWithFormat:@"CountryPicker.bundle/%@", [[self class] countryCodes][(NSUInteger) row]];
    ((UIImageView *)[view viewWithTag:2]).image = [UIImage imageNamed:imagePath];
    
    
    return view;
}

/////////////////////////////////////////////////////////////////////////

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedCountryCode = [[self class] countryCodes][(NSUInteger) row];
    return;
}

- (void)customButtonPressed:(id)sender {
    UIBarButtonItem *button = (UIBarButtonItem*)sender;
    NSInteger index = button.tag;
    NSAssert((index >= 0 && index < self.customButtons.count), @"Bad custom button tag: %ld, custom button count: %lu", (long)index, (unsigned long)self.customButtons.count);
    
    NSDictionary *buttonDetails = (self.customButtons)[(NSUInteger) index];
    NSAssert(buttonDetails != NULL, @"Custom button dictionary is invalid");
    
    ActionType actionType = (ActionType) [buttonDetails[kActionType] intValue];
    switch (actionType) {
        case ActionTypeValue: {
            id itemValue = buttonDetails[kButtonValue];
            if ( [itemValue isKindOfClass:[NSTimeZone class]] )
            {
                NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
                NSString *countryCode   = [currentLocale objectForKey:NSLocaleCountryCode];
                self.initialCountryCode = countryCode;
                [self setSelectedRows];
                [self selectCurrentLocale:(UIPickerView *) self.pickerView];
            }
            break;
        }
            
        case ActionTypeBlock:
        case ActionTypeSelector:
            [super customButtonPressed:sender];
            break;
        default:
            NSAssert(false, @"Unknown action type");
            break;
    }
}

/////////////////////////////////////////////////////////////////////

+ (NSArray *)countryNames
{
    static NSArray *_countryNames = nil;
    if (!_countryNames)
    {
        _countryNames = [[[[self countryNamesByCode] allValues] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] copy];
    }
    return _countryNames;
}

+ (NSArray *)countryCodes
{
    static NSArray *_countryCodes = nil;
    if (!_countryCodes)
    {
        _countryCodes = [[[self countryCodesByName] objectsForKeys:[self countryNames] notFoundMarker:@""] copy];
    }
    return _countryCodes;
}

+ (NSDictionary *)countryNamesByCode
{
    static NSDictionary *_countryNamesByCode = nil;
    if (!_countryNamesByCode)
    {
        NSMutableDictionary *namesByCode = [NSMutableDictionary dictionary];
        for (NSString *code in [NSLocale ISOCountryCodes])
        {
            NSString *countryName = [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:code];
            
            //workaround for simulator bug
            if (!countryName)
            {
               countryName = [[NSLocale localeWithLocaleIdentifier:@"en_US"] displayNameForKey:NSLocaleCountryCode value:code];
            }
            
            namesByCode[code] = countryName ?: code;
        }
        _countryNamesByCode = [namesByCode copy];
    }
    return _countryNamesByCode;
}

+ (NSDictionary *)countryCodesByName
{
    static NSDictionary *_countryCodesByName = nil;
    if (!_countryCodesByName)
    {
        NSDictionary *countryNamesByCode = [self countryNamesByCode];
        NSMutableDictionary *codesByName = [NSMutableDictionary dictionary];
        for (NSString *code in countryNamesByCode)
        {
            codesByName[countryNamesByCode[code]] = code;
        }
        _countryCodesByName = [codesByName copy];
    }
    return _countryCodesByName;
}
@end