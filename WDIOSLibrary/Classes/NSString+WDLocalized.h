//
//  NSString+Localized.h
//  Pods
//
//  Created by Dhanu Saksrisathaporn on 7/29/2559 BE.
//
//

#import <Foundation/Foundation.h>

@interface NSString (WDLocalized)
- (void)setAsPreferLanguage;
- (void)setAsTableLanguage;
- (NSString *)localString;
- (NSString *)displayNameOfLocaleID;

+ (NSArray<NSString *> *)languages;
@end
