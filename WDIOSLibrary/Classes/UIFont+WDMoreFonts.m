//
//  UIFont+WDMoreFonts.m
//  Pods
//
//  Created by Dhanu Saksrisathaporn on 8/16/2559 BE.
//
//

#import "UIFont+WDMoreFonts.h"
#import <CoreText/CoreText.h>
@implementation UIFont (WDMoreFonts)

-(NSString *)addFontFromFile:(NSString *)fontPath
{
    
    NSData *inData = [NSData dataWithContentsOfFile:fontPath]/* your font-file data */;
    CFErrorRef error;
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)inData);
    CGFontRef font = CGFontCreateWithDataProvider(provider);
    if (!CTFontManagerRegisterGraphicsFont(font, &error)) {
        CFStringRef errorDescription = CFErrorCopyDescription(error);
        NSLog(@"Failed to load font: %@", errorDescription);
        CFRelease(errorDescription);
    }
    
    NSString *fontName = [(NSString *)CFBridgingRelease(CGFontCopyPostScriptName(font)) copy];
    
    CFRelease(font);
    CFRelease(provider);
    
    return fontName;
}
@end
