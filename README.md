# CatDetailViewController

[![Build Status](https://travis-ci.org/K-cat/CatDetailViewController.svg)](https://travis-ci.org/K-cat)

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
