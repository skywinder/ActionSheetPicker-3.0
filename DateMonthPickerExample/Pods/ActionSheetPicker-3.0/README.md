[![Version](http://img.shields.io/cocoapods/v/ActionSheetPicker-3.0.svg)](http://cocoadocs.org/docsets/ActionSheetPicker-3.0)
[![Build Status](https://travis-ci.org/skywinder/ActionSheetPicker-3.0.svg?branch=master)](https://travis-ci.org/skywinder/ActionSheetPicker-3.0)
[![License](https://img.shields.io/cocoapods/l/ActionSheetPicker-3.0.svg)](http://cocoadocs.org/docsets/ActionSheetPicker-3.0)
[![Platform](https://img.shields.io/cocoapods/p/ActionSheetPicker-3.0.svg)](http://cocoadocs.org/docsets/ActionSheetPicker-3.0)
[![Issues](http://img.shields.io/github/issues/skywinder/ActionSheetPicker-3.0.svg)](https://github.com/skywinder/ActionSheetPicker-3.0/issues?state=open)

ActionSheetPicker-3.0
==================
- [Overview](#overview)
	- [Benefits](#benefits)
- [QuickStart](#quickstart)
	- [Basic Usage](#basic-usage)
	- [ActionSheetCustomPicker Customisation](#actionsheetcustompicker-customisation)
- [Installation](#installation)
- [Example Projects](#example-projects)
- [Screen Shots](#screen-shots)
- [Apps using this library](#apps-using-this-library)
- [Maintainer and Contributor](#maintainer-and-contributor)
- [Credits](#credits)

Since the [Tim's repo](https://github.com/TimCinel/ActionSheetPicker) is not support iOS 7+, I forked from his repo and implement iOS 7-8 support, and also bunch of UI fixes, crush-fixes and different customisation abilities.

New updates will be added only in this repo.

Please welcome: **ActionSheetPicker-3.0**!

`pod 'ActionSheetPicker-3.0', '~> 1.3.1'` (**iOS 6-7-8** compatible!)

Improvements more than welcome - they are kindly requested :)

_Regards, Petr Korolev_

##ActionSheetPicker = UIPickerView + UIActionSheet ##

![ActionSheetLocalePicker](https://raw.githubusercontent.com/skywinder/ActionSheetPicker-3.0/master/Screenshots/locale.png "ActionSheetLocalePicker")

Well, that's how it started. Now, the following is more accurate:

 * _**iPhone/iPod** ActionSheetPicker = ActionSheetPicker = A Picker + UIActionSheet_
 * _**iPad** ActionSheetPicker = A Picker + UIPopoverController_


## Overview ##
Easily present an ActionSheet with a PickerView, allowing user to select from a number of immutable options. 

### Benefits ##

 * Spawn pickers with convenience function - delegate or reference
   not required. Just provide a target/action callback.
 * Add buttons to UIToolbar for quick selection (see ActionSheetDatePicker below)
 * Delegate protocol available for more control
 * Universal (iPhone/iPod/iPad)

## QuickStart

There are 4 distinct picker view options: `ActionSheetStringPicker`, `ActionSheetDistancePicker`, `ActionSheetDatePicker`, and `ActionSheetCustomPicker`. We'll focus here on how to use the `ActionSheetStringPicker` since it's most likely the one you want to use.

### Basic Usage ##

```objective-c
// Inside a IBAction method:

// Create an array of strings you want to show in the picker:
NSArray *colors = [NSArray arrayWithObjects:@"Red", @"Green", @"Blue", @"Orange", nil];

[ActionSheetStringPicker showPickerWithTitle:@"Select a Color"
                                        rows:colors
                            initialSelection:0
                                   doneBlock:nil
                                 cancelBlock:nil
                                      origin:sender];
```

#### But you probably want to know when something happens, huh?

```obj-c
// Inside a IBAction method:

// Create an array of strings you want to show in the picker:
NSArray *colors = [NSArray arrayWithObjects:@"Red", @"Green", @"Blue", @"Orange", nil];

[ActionSheetStringPicker showPickerWithTitle:@"Select a Color"
                                        rows:colors
                            initialSelection:0
                                   doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                      NSLog(@"Picker: %@", picker);
                                      NSLog(@"Selected Index: %@", selectedIndex);
                                      NSLog(@"Selected Value: %@", selectedValue);
                                    }
                                 cancelBlock:^(ActionSheetStringPicker *picker) {
                                      NSLog(@"Block Picker Canceled");
                                    }
                                      origin:sender];
// You can also use self.view if you don't have a sender
```

### ActionSheetCustomPicker Customisation

ActionSheetCustomPicker provides the following delegate function that can be used for customisation:

```obj-c
- (void)actionSheetPicker:(AbstractActionSheetPicker *)actionSheetPicker configurePickerView:(UIPickerView *)pickerView;
```
This method is called right before `actionSheetPicker` is presented and it can be used to customize the appearance and properties of the `actionSheetPicker` and the `pickerView` associated with it.


#### Want custom buttons view? Ok!

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

#### What about custom buttons callbacks? Let's check it out:
 
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
 
##Installation##

-  The most easiest way is through [Cocoapods](http://cocoapods.org/).
Just add to your Podfile string: `pod 'ActionSheetPicker-3.0'`

-  The "old school" way is manually add to your project all from [Pickers](/Pickers) folder and import necessary headers.

## Example Projects##
#### For iOS 8 (Objective-C + Swift):
`open Example.xcworkspace`

Here is 4 projects:

- **CoreActionSheetPicker** - all picker files combined in one Framework. (available since `iOS 8`)
- **ActionSheetPicker** - modern and descriptive Obj-C project with many examples.
- **Swift-Example** - example, written on Swift. (only with basic 3 Pickers examples, for all examples please run `ActionSheetPicker` project)
- **ActionSheetPicker-iOS6-7** -  iOS 6 and 7 comparable project. or to run only this project `open Example-for-and-6/ActionSheetPicker.xcodeproj`

## Screen Shots

![ActionSheetPicker](https://raw.githubusercontent.com/skywinder/ActionSheetPicker-3.0/master/Screenshots/string.png "ActionSheetPicker")
![ActionSheetDatePicker](https://raw.githubusercontent.com/skywinder/ActionSheetPicker-3.0/master/Screenshots/date.png "ActionSheetDatePicker")
![ActionSheetDatePicker](https://raw.githubusercontent.com/Jack-s/ActionSheetPicker-3.0/master/Screenshots/time.png "ActionSheetDatePicker")
![CustomButtons](https://raw.githubusercontent.com/skywinder/ActionSheetPicker-3.0/master/Screenshots/custom.png "CustomButtons")
![iPad Support](https://raw.githubusercontent.com/skywinder/ActionSheetPicker-3.0/master/Screenshots/ipad.png "iPad Support")


## [Apps using this library](https://github.com/skywinder/ActionSheetPicker-3.0/wiki/Apps-using-ActionSheetPicker-3.0) 
*If you are using `ActionSheetPicker-3.0` in your app or know of an app that uses it, please add it to [this] (https://github.com/skywinder/ActionSheetPicker-3.0/wiki/Apps-using-ActionSheetPicker-3.0) list.*

## Maintainer and Contributor

- [Petr Korolev](http://github.com/skywinder) (update to iOS 7 and iOS 8, implementing new pickers, community support)

## Credits

- ActionSheetPicker was originally created by [Tim Cinel](http://github.com/TimCinel) ([@TimCinel](http://twitter.com/TimCinel))

- And most of all, thanks to ActionSheetPicker-3.0's [growing list of contributors](https://github.com/skywinder/ActionSheetPicker-3.0/graphs/contributors).

***Bug reports, feature requests, patches, well-wishes, and rap demo tapes are always welcome.**
