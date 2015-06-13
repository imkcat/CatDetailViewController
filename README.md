# CatDetailViewController

[![Build Status](https://travis-ci.org/K-cat/CatDetailViewController.svg)](https://travis-ci.org/K-cat)
[![Version](https://img.shields.io/cocoapods/v/CatDetailViewController.svg)](https://cocoapods.org/?q=Catdetail)
[![Platform](https://img.shields.io/cocoapods/p/CatDetailViewController.svg)]()
[![License](https://img.shields.io/cocoapods/l/CatDetailViewController.svg)]()

# Introduction

CatDetailViewController is a quicker way to create a viewcontroller for information enter,CatDetailViewController can make your code compectly

# ScreenShots

![ScreenShots1](http://kcat.co/wp-content/uploads/2015/06/single-section.gif)
![ScreenShots2](http://kcat.co/wp-content/uploads/2015/06/textfield.gif)
![ScreenShots3](http://kcat.co/wp-content/uploads/2015/06/datepicker.gif)

# Installation

CatDetailViewController is available on [CocoaPods](http://cocoapods.org).Just add the following to your project Podfile:

```ruby
pod 'CatDetailViewController'
```

# Usage

```objective-c
#import "CatDetailViewController"

CatDetailViewController *detailView=[[CatDetailViewController alloc] initSingleSectionViewWithTitle:@"Select Color" sections:@[@"Red",@"Blue"] defaultSectionText:cell.detailTextLabel.text saveHandle:^(NSString *saveResult) {
	//Do anything you want
}];
[self.navigationController pushViewController:detailView animated:YES];
```

# Note

CatDetailViewController is depend on UINavigationController, so don't forget it!
