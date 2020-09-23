# Basic Usage

## By using blocks:

```obj-c
// Inside a IBAction method:

// Create an array of strings you want to show in the picker:
    NSArray *colors = @[@"Red", @"Green", @"Blue", @"Orange"];

// Done block:
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        NSLog(@"Picker: %@", picker);
        NSLog(@"Selected Index: %@", selectedIndex);
        NSLog(@"Selected Value: %@", selectedValue);
    };


// cancel block:
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
    };

// Run!
    [ActionSheetStringPicker showPickerWithTitle:@"Select a Color" rows:colors initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
```

## ActionSheetMultipleStringPicker

```obj-c

 NSArray *rows = @[@[@"C", @"Db", @"D", @"Eb", @"E", @"F", @"Gb", @"G", @"Ab", @"A", @"Bb", @"B"], @[@"Major", @"Minor", @"Dorian", @"Spanish Gypsy"]];
NSArray *initialSelection = @[@2, @4];
[ActionSheetMultipleStringPicker showPickerWithTitle:@"Select scale"
                                                rows:rows
                                    initialSelection:initialSelection
                                           doneBlock:^(ActionSheetMultipleStringPicker *picker,
                                            NSArray *selectedIndexes,
                                            NSArray *selectedValues) {
                                                NSLog(@"%@", selectedIndexes);
                                                NSLog(@"%@", [selectedValues componentsJoinedByString:@", "]);
                                            }
                                        cancelBlock:^(ActionSheetMultipleStringPicker *picker) {
                                            NSLog(@"picker = %@", picker);
                                        } origin:(UIView *)sender];

```

### ActionSheetCustomPicker Customisation

ActionSheetCustomPicker provides the following delegate function that can be used for customisation:

```obj-c
- (void)actionSheetPicker:(AbstractActionSheetPicker *)actionSheetPicker configurePickerView:(UIPickerView *)pickerView;
```

This method is called right before `actionSheetPicker` is presented and it can be used to customize the appearance and properties of the `actionSheetPicker` and the `pickerView` associated with it.

### Want custom buttons view? Ok!

Example with custom text in Done button:

```obj-c
ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"Select a Block" rows:colors initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
[picker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:@"My Text"  style:UIBarButtonItemStylePlain target:nil action:nil]];
[picker showActionSheetPicker];
```

Example with custom button for cancel button:

```obj-c
ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"Select a Block" rows:colors initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
UIButton *cancelButton =  [UIButton buttonWithType:UIButtonTypeCustom];
[cancelButton setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
[cancelButton setFrame:CGRectMake(0, 0, 32, 32)];
[picker setCancelButton:[[UIBarButtonItem alloc] initWithCustomView:cancelButton]];
[picker showActionSheetPicker];
```

### What about custom buttons callbacks? Let's check it out

```obj-c
// Inside a IBAction method:

// Create an array of strings you want to show in the picker:
NSArray *colors = [NSArray arrayWithObjects:@"Red", @"Green", @"Blue", @"Orange", nil];

//Create your picker:
ActionSheetStringPicker *colorPicker = [[ActionSheetStringPicker alloc] initWithTitle:@"Select a color"
                                                                                 rows:colors
                                                                     initialSelection:0
                                                                               target:nil
                                                                        successAction:nil
                                                                         cancelAction:nil
                                                                               origin:sender];

//You can pass your picker a value on custom button being pressed:
[colorPicker addCustomButtonWithTitle:@"Value" value:@([colors indexOfObject:colors.lastObject])];

//Or you can pass it custom block:
[colorPicker addCustomButtonWithTitle:@"Block" actionBlock:^{
    NSLog(@"Custom block invoked");
}];

//If you prefer to send selectors rather than blocks you can use this method:
[colorPicker addCustomButtonWithTitle:@"Selector" target:self selector:@selector(awesomeSelector)];
```

### Action by clicking outside of the picker

Use property `tapDismissAction` to specify action, by clicking outside area of the picker:

- `TapActionNone` (default)
- `TapActionSuccess`
- `TapActionCancel`

### Customize picker by setting background color or apply blur effect to the picker background

- In order to set picker background color, use `pickerBackgroundColor` property:

```obj-c
ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"" rows:@[@"choiceA", @"choiceB", @"choiceC"] initialSelection:1 doneBlock:nil cancelBlock:nil origin:sender];
picker.pickerBackgroundColor = [UIColor blackColor];
```

- For applying blur effect to the picker's background , use `pickerBlurRadius` property. You can define custom blur radius, depending on your needs:

```obj-c
picker.pickerBlurRadius = @(10);
```

### Other customisations

look at `AbstractActionSheetPicker` properties:

- `toolbar`
- `title`
- `pickerView`
- `viewSize`
- `customButtons`
- `hideCancel`: show or hide cancel button
- `titleTextAttributes`: default is nil. Used to specify Title Label attributes
- `attributedTitle`: default is nil. If titleTextAttributes not nil this value ignored
- `popoverBackgroundViewClass`: allow popover customization on iPad
- `supportedInterfaceOrientations`: You can set your own supportedInterfaceOrientations value to prevent dismissing picker in some special cases
- `tapDismissAction`: to specify action, by clicking outside area of the picker
  - `TapActionNone`
  - `TapActionSuccess`
  - `TapActionCancel`
