# WDIOSLibrary

[![CI Status](http://img.shields.io/travis/Dhanu Saksrisathaporn/WDIOSLibrary.svg?style=flat)](https://travis-ci.org/Dhanu Saksrisathaporn/WDIOSLibrary)
[![Version](https://img.shields.io/cocoapods/v/WDIOSLibrary.svg?style=flat)](http://cocoapods.org/pods/WDIOSLibrary)
[![License](https://img.shields.io/cocoapods/l/WDIOSLibrary.svg?style=flat)](http://cocoapods.org/pods/WDIOSLibrary)
[![Platform](https://img.shields.io/cocoapods/p/WDIOSLibrary.svg?style=flat)](http://cocoapods.org/pods/WDIOSLibrary)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Desciption

language change:

add font:

fix photo orientation from camera

## Requirements

## Installation

WDIOSLibrary is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "WDIOSLibrary"
```

## Usage

### WDEmptyStateView
![WDEmptyStateView](http://i68.tinypic.com/15fzb4.png)

```objective-c
WDEmptyStateView *view = [[WDEmptyStateView alloc]initWithTitle:@"NO INTERNET" description:@"Your internet connention was lost,\nPlease check." imageName:@""];
[view setBackgroundColor:[UIColor colorWithRed:0.96 green:0.98 blue:1.00 alpha:1.0]];
[view setTextColor:[UIColor darkGrayColor]];
[view setActionButtonTextColor:[UIColor whiteColor] AndBackgroundColor:[UIColor CustomCrimsonColor]];
[view addActionButton:@"Retry" WithHandler:^(WDEmptyStateView *view) {
        NSLog(@"User Tapped Button");
}];
[self.view addSubview:view];
```

## Author

Dhanu Saksrisathaporn, dharxx@gmail.com

## License

WDIOSLibrary is available under the MIT license. See the LICENSE file for more info.
