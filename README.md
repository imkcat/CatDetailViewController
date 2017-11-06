# CatDetailViewController

[![Build Status](https://travis-ci.org/K-cat/CatDetailViewController.svg)](https://travis-ci.org/K-cat)
[![Version](https://img.shields.io/cocoapods/v/CatDetailViewController.svg)](https://cocoapods.org/pods/CatDetailViewController)
[![Platform](https://img.shields.io/cocoapods/p/CatDetailViewController.svg)]()
[![License](https://img.shields.io/cocoapods/l/CatDetailViewController.svg)]()

# Introduction

CatDetailViewController is a simple way to create detail information style viewcontrollers, such as text, date or table! CatDetailViewController can make your code compectly, new way to replace delegate!

# ScreenShot

![ScreenShots1](https://raw.githubusercontent.com/K-cat/CatDetailViewController/master/ScreenShot.gif)

# Installation

CatDetailViewController is available on [CocoaPods](http://cocoapods.org). Just add the following to your project Podfile:

```ruby
pod 'CatDetailViewController'
```

# New Method and Properties
## Method
```objective-c
-(instancetype)initChinaCityPickerViewWithTitle:(NSString *)title
                                     saveHandle:(void(^)(NSString *saveResult))saveHandle;
```

## Properties
* **allowResultEmpty**: A boolean value that the empty information alertview show(Default is NO)
* **emptyResultAlertViewMessage**: The text for empty alertview message
* **enableConfirmAlertView**: A boolean value that the confirm information alertview show(Default is NO)
* **saveConfirmAlertViewMessage**: The text for save alertview message
* **saveConfirmAlertViewTitle**: The text for save alertview title

# Usage

```objective-c
#import "CatDetailViewController"

CatDetailViewController *detailView = [[CatDetailViewController alloc] initSingleSectionViewWithTitle:@"Select Color" sections:@[@"Red",@"Blue"] defaultSectionText:cell.detailTextLabel.text saveHandle:^(NSString *saveResult) {
	//Do anything you want
}];
[detailView detailViewShowOnViewController:self];
```

# Note

CatDetailViewController is depend on UINavigationController, so don't forget it!
