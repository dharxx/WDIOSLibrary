# WDIOSLibrary

[![CI Status](http://img.shields.io/travis/Dhanu Saksrisathaporn/WDIOSLibrary.svg?style=flat)](https://travis-ci.org/Dhanu Saksrisathaporn/WDIOSLibrary)
[![Version](https://img.shields.io/cocoapods/v/WDIOSLibrary.svg?style=flat)](http://cocoapods.org/pods/WDIOSLibrary)
[![License](https://img.shields.io/cocoapods/l/WDIOSLibrary.svg?style=flat)](http://cocoapods.org/pods/WDIOSLibrary)
[![Platform](https://img.shields.io/cocoapods/p/WDIOSLibrary.svg?style=flat)](http://cocoapods.org/pods/WDIOSLibrary)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Desciption

Add Custom Color <- Ben

Add Custom View <- Ben

language change:

add font:

fix photo orientation from camera

## Requirements

## Installation

WDIOSLibrary is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WDIOSLibrary', :git => 'https://github.com/dharxx/WDIOSLibrary.git', :branch => ‘develop-ben'
```

## Usage

### WDButtonIndicator
![WDButtonIndicator](http://i67.tinypic.com/htcqpe.png) ![WDButtonIndicator](http://i65.tinypic.com/16lejht.png)


### WDToastView
![WDToastView](http://i67.tinypic.com/wj80lt.png)
```objective-c
WDToastView *toast = [[WDToastView alloc]initWithMessage:@"Logged in as.. Benmore99"
                                                iconName:@"sample"
                                                    time:ToastShowingTimeNormal
                             usingBlockWhenFinishShowing:nil];
[toast show];
```


### WDAlertView
![WDEmptyAlertView](http://i64.tinypic.com/hsmi42.png)
```objective-c
WDAlertView *alert = [[WDAlertView alloc]initWithTitle:@"Confirm Delete" 
                                               message:@"Do you want to delete this item." 
                                    confirmButtonTitle:@"Delete" cancelButtonTitle:@"No"
                               usingBlockWhenTapButton:^(WDAlertView *alertView, NSInteger buttonIndex) {
                                                        if (buttonIndex == 0) {
                                                                NSLog(@"Canceled");
                                                        }else if(buttonIndex == 1){
                                                                NSLog(@"Deleted");
                                                        }}];
[alert show];
```


### WDFullScreenLoading
![WDFullScreenLoading](http://i68.tinypic.com/2a80w8k.png)
```objective-c
WDFullScreenLoading *loading = [[WDFullScreenLoading alloc]init];
[loading setMessage:@"Processing Transection.."];
[loading show];

//to hide
[loading hide];
```


### WDCustomColor
See Custom Color Name at [HTML Color Names](http://www.w3schools.com/colors/colors_names.asp) (w3schools)
```objective-c
[self.view setBackgroundColor:[UIColor CustomSteelBlueColor]];
```


### WDNotificationView
![WDNotificationView](http://i64.tinypic.com/2njh8is.png) ![WDNotificationView](http://i67.tinypic.com/dftyja.png)
```objective-c
WDNotificationView *view = 
[[WDNotificationView alloc]initWithAppName:@"WDIOSLibrary" 
                                  TimeDesc:@"now" 
                                     Title:@"Download Complete" 
                                  Subtitle:@"Your file has been downloaded." 
                                  iconName:@"sample" 
                                 timeDelay:5 
                                parentView:self.view 
                                     style:WDNotificationViewStyleDark 
                      usingBlockWhenTapped:^(WDNotificationView *notificationView) {
                                             NSLog(@"block entered !!");
                                          }];
[view show];
```


### WDEmptyStateView
![WDEmptyStateView](http://i68.tinypic.com/15fzb4.png) ![WDEmptyStateView](http://i63.tinypic.com/fw83rb.png)
```objective-c
WDEmptyStateView *view = [[WDEmptyStateView alloc]initWithTitle:@"NO INTERNET" 
                                                    description:@"Your internet connention was lost,\n
                                                    Please check." 
                                                      imageName:@"nointernet"];
[view setBackgroundColor:[UIColor colorWithRed:0.96 green:0.98 blue:1.00 alpha:1.0]];
[view setTextColor:[UIColor darkGrayColor]];
[view setActionButtonTextColor:[UIColor whiteColor] AndBackgroundColor:[UIColor CustomCrimsonColor]];
[view addActionButton:@"Retry" WithHandler:^(WDEmptyStateView *view) {
        NSLog(@"User Tapped Button");
}];
[self.view addSubview:view];
```


### WDLightAlertView
![WDEmptyStateView](http://i63.tinypic.com/5jxsh1.png)
```objective-c
WDLightAlertView *alert = [[WDLightAlertView alloc]initWithTitle:@"Warning" 
                                                     Description:@"Diary for Sep 8, 2016 already exist! 
                                                     Do you realy want to overwrite it?" 
                                              PrimaryButtonTitle:@"Cancel" 
                                                      Completion:^(WDLightAlertView *alert){
                                                                  NSLog(@"primary button tapped");
                                                                  }];
[alert addSecondaryButtonWithTitle:@"Overwrite" Completion:^(WDLightAlertView *alert) {
        NSLog(@"secondary button tapped");
}];
[alert show];
```

## Author

Dhanu Saksrisathaporn, dharxx@gmail.com
Burin Techama

## License

WDIOSLibrary is available under the MIT license. See the LICENSE file for more info.
