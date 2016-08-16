//
//  UIFont+WDMoreFonts.h
//  Pods
//
//  Created by Dhanu Saksrisathaporn on 8/16/2559 BE.
//
//

#import <UIKit/UIKit.h>

@interface UIFont (WDMoreFonts)
//return name of font return nil if not font file .ttf
+ (NSString *)addFontFromFile:(NSString *)fontPath;
@end
