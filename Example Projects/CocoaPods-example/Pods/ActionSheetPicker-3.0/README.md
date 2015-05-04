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
- [Installation](#installation)
- [Example Projects](#example-projects)
- [Screenshots](#screenshots)
- [Apps using this library](#apps-using-this-library)
- [Maintainer and Contributor](#maintainer-and-contributor)
- [Credits](#credits)
- [Contributing](#contributing)

Please welcome: **ActionSheetPicker-3.0**!

`pod 'ActionSheetPicker-3.0', '~> 1.5.1'` (**iOS 6-7-8** compatible!)

Improvements more than welcome - they are kindly requested :)

_Regards, Petr Korolev_

##ActionSheetPicker = UIPickerView + UIActionSheet ##

![Animation](Screenshots/example.gif)

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

For detailed examples, please look [Wiki-page](https://github.com/skywinder/ActionSheetPicker-3.0/wiki/Basic-Usage) and check [Example Projects](#example-projects) in this repo.

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

 
##Installation##

-  The most easiest way is through [Cocoapods](http://cocoapods.org/).
Just add to your Podfile string: `pod 'ActionSheetPicker-3.0'`

-  The "old school" way is manually add to your project all from [Pickers](/Pickers) folder and import necessary headers.

## Example Projects##

`open Example.xcworkspace`

Here is 4 projects:

- **CoreActionSheetPicker** - all picker files combined in one Framework. (available since `iOS 8`)
- **ActionSheetPicker** - modern and descriptive Obj-C project with many examples.
- **Swift-Example** - example, written on Swift. (only with basic 3 Pickers examples, for all examples please run `ActionSheetPicker` project)
- **ActionSheetPicker-iOS6-7** -  iOS 6 and 7 comparable project. or to run only this project `open Example-for-and-6/ActionSheetPicker.xcodeproj`

## Screenshots

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

- ActionSheetPicker was originally created by [Tim Cinel](http://github.com/TimCinel) ([@TimCinel](http://twitter.com/TimCinel)) Since the [Tim's repo](https://github.com/TimCinel/ActionSheetPicker) is not support iOS 7+, I forked from his repo and implement iOS 7-8 support, and also bunch of UI fixes, crash-fixes and different customisation abilities.

- And most of all, thanks to ActionSheetPicker-3.0's [growing list of contributors](https://github.com/skywinder/ActionSheetPicker-3.0/graphs/contributors).

## Contributing

1. Create an issue to discuss about your idea
2. Fork it (https://github.com/skywinder/ActionSheetPicker-3.0/fork)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

**Bug reports, feature requests, patches, well-wishes, and rap demo tapes are always welcome.**

[![Analytics](https://ga-beacon.appspot.com/UA-52127948-3/ActionSheetPicker-3.0/readme)](https://ga-beacon.appspot.com/UA-52127948-3/ActionSheetPicker-3.0/readme)


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/skywinder/actionsheetpicker-3.0/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

