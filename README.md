# CatDetailViewController

[![Build Status](https://travis-ci.org/K-cat/CatDetailViewController.svg)](https://travis-ci.org/K-cat)
[![Version](https://img.shields.io/cocoapods/v/CatDetailViewController.svg)](https://cocoapods.org/?q=CatDetailViewController)
[![Platform](https://img.shields.io/cocoapods/p/CatDetailViewController.svg)]()
[![License](https://img.shields.io/cocoapods/l/CatDetailViewController.svg)]()

# Introduction

CatDetailViewController is a quicker way to create a viewcontroller for different type information enter,such as text,date or table!CatDetailViewController can make your code compectly,and replace delegate way!

# ScreenShots

![ScreenShots1](http://kcat.co/wp-content/uploads/2015/06/single-section.gif)
![ScreenShots2](http://kcat.co/wp-content/uploads/2015/06/textfield.gif)
![ScreenShots3](http://kcat.co/wp-content/uploads/2015/06/datepicker.gif)

# Installation

CatDetailViewController is available on [CocoaPods](http://cocoapods.org).Just add the following to your project Podfile:

```ruby
pod 'CatDetailViewController'
```

# New Properties
<!-- ## Method
```objective-c
//This method is only available on ios 8.0+
-(instancetype)initEnterAlertViewWithTitle:(NSString *)title
                                   message:(NSString *)message
                             textfieldText:(NSString *)textfieldText
                      textfieldPlaceholder:(NSString *)textfieldPlaceholder
                              cancelButtonTitle:(NSString *)cancelButtonTitle
                              saveButtonTitle:(NSString *)savelButtonTitle
                                saveHandle:(void(^)(NSString *saveResult))saveHandle
``` -->

<!-- ## Properties -->
* **allowResultEmpty**:A boolean value that the empty information alertview show(Default is NO)
* **emptyResultAlertViewMessage**:The text for empty alertview message
* **enableConfirmAlertView**:A boolean value that the confirm information alertview show(Default is NO)
* **saveConfirmAlertViewMessage**:The text for save alertview message
* **saveConfirmAlertViewTitle**:The text for save alertview title

# Usage

```objective-c
#import "CatDetailViewController"

CatDetailViewController *detailView=[[CatDetailViewController alloc] initSingleSectionViewWithTitle:@"Select Color"
					sections:@[@"Red",@"Blue"] 
				defaultSectionText:cell.detailTextLabel.text 
					saveHandle:^(NSString *saveResult) {
				//Do anything you want
}];
[detailView detaiViewShowOnViewController:self];
```

# Note

CatDetailViewController is depend on UINavigationController, so don't forget it!
