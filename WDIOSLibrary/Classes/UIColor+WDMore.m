//
//  UIColor+WDMore.m
//  Pods
//
//  Created by Dhanu Saksrisathaporn on 10/26/2559 BE.
//
//

#import "UIColor+WDMore.h"

@implementation UIColor (WDMore)
+ (UIColor *)colorFromHex:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    //    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
@end
