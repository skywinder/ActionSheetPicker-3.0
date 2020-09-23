# ActionSheetPicker-3.0

[![Version](http://img.shields.io/cocoapods/v/ActionSheetPicker-3.0.svg)](http://cocoadocs.org/docsets/ActionSheetPicker-3.0)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/skywinder/ActionSheetPicker-3.0.svg?branch=master)](https://travis-ci.org/skywinder/ActionSheetPicker-3.0)
[![Issues](http://img.shields.io/github/issues/skywinder/ActionSheetPicker-3.0.svg)](https://github.com/skywinder/ActionSheetPicker-3.0/issues?state=open)
[![License](https://img.shields.io/cocoapods/l/ActionSheetPicker-3.0.svg)](http://cocoadocs.org/docsets/ActionSheetPicker-3.0)
[![Platform](https://img.shields.io/cocoapods/p/ActionSheetPicker-3.0.svg)](http://cocoadocs.org/docsets/ActionSheetPicker-3.0)<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->[![All Contributors](https://img.shields.io/badge/all_contributors-21-orange.svg?style=flat-square)](#contributors-)<!-- ALL-CONTRIBUTORS-BADGE:END -->

## Important update

Now I fixed most of the things and merge PR' (thanks to [![All Contributors](https://img.shields.io/badge/all_contributors-20-orange.svg?style=flat-square)](#contributors-)).

I did much work to support this library from iOS 5. (and till iOS 13 and we keep going) 🚀

### [I still need help with the future support of this repo](https://github.com/skywinder/ActionSheetPicker-3.0/issues/348). If you are interested  to help - please **drop a comment into  issue #348 🙏**

Regards, [Petr Korolev](https://github.com/skywinder)

---

- [Overview](#overview)
  - [Benefits](#benefits)
- [QuickStart](#quickstart)
  - [Basic Usage](#basic-usage)
- [Installation](#installation)
- [Example Projects](#example-projects)
- [Screenshots](#screenshots)
- [Apps using this library](#apps-using-this-library)
- [Maintainer and Contributor](#maintainer-and-contributor)
- [Contributing](#contributing)
- [Credits](#credits)
- [Contributors](#contributors)

Please welcome: **ActionSheetPicker-3.0**!

## ActionSheetPicker = UIPickerView + UIActionSheet

![Animation](Screenshots/example.gif)

Well, that's how it started. Now, the following is more accurate:

- _**iPhone/iPod** ActionSheetPicker = ActionSheetPicker = A Picker + UIActionSheet_
- _**iPad** ActionSheetPicker = A Picker + UIPopoverController_

## Overview

Easily present an ActionSheet with a PickerView, allowing the user to select from a number of immutable options.

### Benefits

- Spawn pickers with convenience function - delegate or reference
   not required. Just provide a target/action callback.
- Add buttons to UIToolbar for quick selection (see ActionSheetDatePicker below)
- Delegate protocol available for more control
- Universal (iPhone/iPod/iPad)

## QuickStart

There are 4 distinct picker view options:

- `ActionSheetStringPicker`
- `ActionSheetDistancePicker`
- `ActionSheetDatePicker`
- `ActionSheetCustomPicker`

We'll focus here on how to use the `ActionSheetStringPicker` since it's most likely the one you want to use.

### Basic Usage

**For detailed info about customizations, please look  [BASIC USAGE](https://github.com/skywinder/ActionSheetPicker-3.0/blob/master/BASIC-USAGE.md)**

- Custom buttons view
- Custom buttons callbacks
- Action by clicking outside of the picker
- Background color and blur effect
- Other customizations

**For detailed examples, please check [Example Projects](#example-projects) in this repo.**

#### `Swift`

```swift
 ActionSheetMultipleStringPicker.show(withTitle: "Multiple String Picker", rows: [
            ["One", "Two", "A lot"],
            ["Many", "Many more", "Infinite"]
            ], initialSelection: [2, 2], doneBlock: {
                picker, indexes, values in

                print("values = \(values)")
                print("indexes = \(indexes)")
                print("picker = \(picker)")
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
```

#### `Objective-C`

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

## Installation

### CocoaPods

```ruby
pod 'ActionSheetPicker-3.0'
```

(**iOS 5.1.1-13.x** compatible!)

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

You can install it with the following command:

```bash
gem install cocoapods
```

To integrate ActionSheetPicker-3.0 into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

pod 'ActionSheetPicker-3.0'
```

Then, run the following command:

```bash
pod install
```

### Import to project

To import pod you should add string:

- For `Obj-c` projects:

```obj-c
   #import "ActionSheetPicker.h"
```

- For `Swift` projects:

```swift
  import ActionSheetPicker_3_0
```

### Carthage

Carthage is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
brew update
brew install carthage
```

To integrate ActionSheetPicker-3.0 into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "skywinder/ActionSheetPicker-3.0"
```

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate ActionSheetPicker-3.0 into your project manually.

The "old school" way is manually added to your project all from [Pickers](/Pickers) folder.

### Embedded Framework

- Add ActionSheetPicker-3.0 as a [submodule](http://git-scm.com/docs/git-submodule) by opening the Terminal, `cd`-ing into your top-level project directory, and entering the following command:

```bash
git submodule add https://github.com/skywinder/ActionSheetPicker-3.0.git
```

- Open the `ActionSheetPicker-3.0` folder, and drag `CoreActionSheetPicker.xcodeproj` into the file navigator of your app project.
- In Xcode, navigate to the target configuration window by clicking on the blue project icon, and selecting the application target under the "Targets" heading in the sidebar.
- Ensure that the deployment target of CoreActionSheetPicker.framework matches that of the application target.
- In the tab bar at the top of that window, open the "Build Phases" panel.
- Expand the "Target Dependencies" group, and add `CoreActionSheetPicker.framework`.
- Click on the `+` button at the top left of the panel and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add `CoreActionSheetPicker.framework`.

## Example Projects

`open ActionSheetPicker-3.0.xcworkspace`

Here is 3 projects:

- **CoreActionSheetPicker** - all picker files combined in one Framework. (available since `iOS 8`)
- **ActionSheetPicker** - modern and descriptive Obj-C project with many examples.
- **Swift-Example** - example, written on Swift. (only with basic 3 Pickers examples, for all examples please run `ActionSheetPicker` project)

## Screenshots

![ActionSheetPicker](https://raw.githubusercontent.com/skywinder/ActionSheetPicker-3.0/master/Screenshots/string.png "ActionSheetPicker")
![ActionSheetDatePicker](https://raw.githubusercontent.com/skywinder/ActionSheetPicker-3.0/master/Screenshots/date.png "ActionSheetDatePicker")
![ActionSheetDatePicker](https://raw.githubusercontent.com/Jack-s/ActionSheetPicker-3.0/master/Screenshots/time.png "ActionSheetDatePicker")
![CustomButtons](https://raw.githubusercontent.com/skywinder/ActionSheetPicker-3.0/master/Screenshots/custom.png "CustomButtons")
![iPad Support](https://raw.githubusercontent.com/skywinder/ActionSheetPicker-3.0/master/Screenshots/ipad.png "iPad Support")

## [Apps using this library](https://github.com/skywinder/ActionSheetPicker-3.0/wiki/Apps-using-ActionSheetPicker-3.0)

If you've used this project in a live app, please let me know! Nothing makes me happier than seeing someone else take my work and go wild with it.

*If you are using `ActionSheetPicker-3.0` in your app or know of an app that uses it, please add it to [**this list**](https://github.com/skywinder/ActionSheetPicker-3.0/wiki/Apps-using-ActionSheetPicker-3.0).*

## Maintainer and Contributor

- [Petr Korolev](http://github.com/skywinder) (update to iOS 7 and iOS 8, implementing new pickers, community support). I did much work to support this library from iOS 5. (and till iOS 13 and we keep going 🚀).

Now I fixed most of the things and merge PR' (thanks to [![All Contributors](https://img.shields.io/badge/all_contributors-20-orange.svg?style=flat-square)](#contributors-)!).

### [I still need help with the future support of this repo](https://github.com/skywinder/ActionSheetPicker-3.0/issues/348). If you are interested to help - please **drop a comment into  issue #348 🙏**

## Contributing

1. Create an issue to discuss your idea
2. Fork it [https://github.com/skywinder/ActionSheetPicker-3.0/fork](https://github.com/skywinder/ActionSheetPicker-3.0/fork)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

**Bug reports, feature requests, patches, well-wishes, and rap demo tapes are always welcome.**

### Discord

We have a Discord channel where discuss about new ideas and implementation. Feel free to join and discuss with us!

You can join our Discord using [this link](https://discord.gg/68NeeUx).

## Credits

- ActionSheetPicker was originally created by [Tim Cinel](http://github.com/TimCinel) ([@TimCinel](http://twitter.com/TimCinel)) Since the [Tim's repo](https://github.com/TimCinel/ActionSheetPicker) is not support iOS 7+, I forked from his repo and implement iOS 7-8 support, and also a bunch of UI fixes, crash-fixes, and different customization abilities.

- And most of all, thanks to ActionSheetPicker-3.0's [growing list of contributors](https://github.com/skywinder/ActionSheetPicker-3.0/graphs/contributors).

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://www.linkedin.com/in/korolevpetr"><img src="https://avatars2.githubusercontent.com/u/3356474?v=4" width="100px;" alt=""/><br /><sub><b>Petr Korolev</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=skywinder" title="Code">💻</a> <a href="https://github.com/skywinder/ActionSheetPicker-3.0/pulls?q=is%3Apr+reviewed-by%3Askywinder" title="Reviewed Pull Requests">👀</a> <a href="#question-skywinder" title="Answering Questions">💬</a> <a href="#example-skywinder" title="Examples">💡</a></td>
    <td align="center"><a href="http://www.timcinel.com/"><img src="https://avatars1.githubusercontent.com/u/177173?v=4" width="100px;" alt=""/><br /><sub><b>Tim Cinel</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=TimCinel" title="Code">💻</a> <a href="https://github.com/skywinder/ActionSheetPicker-3.0/pulls?q=is%3Apr+reviewed-by%3ATimCinel" title="Reviewed Pull Requests">👀</a> <a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=TimCinel" title="Documentation">📖</a></td>
    <td align="center"><a href="https://twitter.com/xjki"><img src="https://avatars0.githubusercontent.com/u/747340?v=4" width="100px;" alt=""/><br /><sub><b>Jurģis Ķiršakmens</b></sub></a><br /><a href="#question-xjki" title="Answering Questions">💬</a> <a href="#example-xjki" title="Examples">💡</a></td>
    <td align="center"><a href="https://github.com/NikDude"><img src="https://avatars1.githubusercontent.com/u/1115699?v=4" width="100px;" alt=""/><br /><sub><b>Nikos</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=NikDude" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/vinhtnk"><img src="https://avatars3.githubusercontent.com/u/10373392?v=4" width="100px;" alt=""/><br /><sub><b>Vinh Tran</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=vinhtnk" title="Code">💻</a> <a href="#security-vinhtnk" title="Security">🛡️</a></td>
    <td align="center"><a href="http://www.linkedin.com/in/kashifhisam"><img src="https://avatars1.githubusercontent.com/u/618660?v=4" width="100px;" alt=""/><br /><sub><b>Kashif Hisam</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=kashifhisam" title="Code">💻</a></td>
    <td align="center"><a href="http://user.qzone.qq.com/627426568?ptlang=2052"><img src="https://avatars1.githubusercontent.com/u/7375120?v=4" width="100px;" alt=""/><br /><sub><b>DYY_Xiaoer</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=xiaoer371" title="Code">💻</a> <a href="#security-xiaoer371" title="Security">🛡️</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/delackner"><img src="https://avatars2.githubusercontent.com/u/478341?v=4" width="100px;" alt=""/><br /><sub><b>Seth Delackner</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=delackner" title="Code">💻</a></td>
    <td align="center"><a href="https://blog.ainopara.com"><img src="https://avatars0.githubusercontent.com/u/1849450?v=4" width="100px;" alt=""/><br /><sub><b>Zheng Li</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=ainopara" title="Code">💻</a></td>
    <td align="center"><a href="https://www.bubidevs.net"><img src="https://avatars0.githubusercontent.com/u/847860?v=4" width="100px;" alt=""/><br /><sub><b>Andrea</b></sub></a><br /><a href="#question-BubiDevs" title="Answering Questions">💬</a> <a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=BubiDevs" title="Code">💻</a> <a href="#content-BubiDevs" title="Content">🖋</a> <a href="#maintenance-BubiDevs" title="Maintenance">🚧</a></td>
    <td align="center"><a href="https://github.com/Bino90"><img src="https://avatars0.githubusercontent.com/u/20422095?v=4" width="100px;" alt=""/><br /><sub><b>Bino90</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=Bino90" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/arnoldxt"><img src="https://avatars3.githubusercontent.com/u/4433222?v=4" width="100px;" alt=""/><br /><sub><b>arnoldxt</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=arnoldxt" title="Code">💻</a></td>
    <td align="center"><a href="https://www.nowsprinting.com/"><img src="https://avatars0.githubusercontent.com/u/117617?v=4" width="100px;" alt=""/><br /><sub><b>Koji Hasegawa</b></sub></a><br /><a href="#infra-nowsprinting" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a></td>
    <td align="center"><a href="https://github.com/yapiskan"><img src="https://avatars3.githubusercontent.com/u/529739?v=4" width="100px;" alt=""/><br /><sub><b>Ali Ersoz</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=yapiskan" title="Code">💻</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://twitter.com/ykws__"><img src="https://avatars3.githubusercontent.com/u/5770480?v=4" width="100px;" alt=""/><br /><sub><b>KAWASHIMA Yoshiyuki</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=ykws" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/ricardohg"><img src="https://avatars1.githubusercontent.com/u/5543569?v=4" width="100px;" alt=""/><br /><sub><b>Ricardo Hernandez</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=ricardohg" title="Code">💻</a></td>
    <td align="center"><a href="http://vincent.narbot.com"><img src="https://avatars3.githubusercontent.com/u/8729167?v=4" width="100px;" alt=""/><br /><sub><b>Vincent Narbot</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=VincentNarbot" title="Documentation">📖</a></td>
    <td align="center"><a href="http://ezefranca.dev"><img src="https://avatars3.githubusercontent.com/u/3648336?v=4" width="100px;" alt=""/><br /><sub><b>Ezequiel França</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=ezefranca" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/nikola-mladenovic"><img src="https://avatars3.githubusercontent.com/u/14024032?v=4" width="100px;" alt=""/><br /><sub><b>Nikola Mladenovic</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=nikola-mladenovic" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/umerasif"><img src="https://avatars0.githubusercontent.com/u/4849696?v=4" width="100px;" alt=""/><br /><sub><b>Umer Asif</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/issues?q=author%3Aumerasif" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/longjun-9"><img src="https://avatars2.githubusercontent.com/u/4412991?v=4" width="100px;" alt=""/><br /><sub><b>longjun</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=longjun-9" title="Code">💻</a></td>
</tr>
<tr>
    <td align="center"><a href="https://github.com/KunzManuel/"><img src="https://avatars2.githubusercontent.com/u/33420796?v=4" width="100px;" alt=""/><br /><sub><b>Manuel Kunz</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=KunzManuel" title="Code">💻</a> <a href="https://github.com/skywinder/ActionSheetPicker-3.0/pulls?q=is%3Apr+reviewed-by%3AKunzManuel" title="Reviewed Pull Requests">👀</a> <a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=KunzManuel" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/noorulain17/"><img src="https://avatars2.githubusercontent.com/u/6180345?v=4" width="100px;" alt=""/><br /><sub><b>Noor ul Ain Ali</b></sub></a><br /><a href="https://github.com/skywinder/ActionSheetPicker-3.0/commits?author=noorulain17" title="Code">💻</a> <a href="https://github.com/skywinder/ActionSheetPicker-3.0/pulls?q=is%3Apr+reviewed-by%3Anoorulain17" title="Reviewed Pull Requests">👀</a> <a href="#maintenance-noorulain17" title="Maintenance">🚧</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
