//
//  NSString+Localized.m
//  Pods
//
//  Created by Dhanu Saksrisathaporn on 7/29/2559 BE.
//
//

#import "NSString+WDLocalized.h"

@implementation NSString (WDLocalized)
- (void)setAsPreferLanguage
{
    [[NSUserDefaults standardUserDefaults] setObject:@[self,[NSLocale currentLocale].localeIdentifier,] forKey:@"AppleLanguages"];
}
- (void)setAsTableLanguage
{
    [[NSUserDefaults standardUserDefaults] setObject:self forKey:@"AppleTableLanguages"];
}
- (NSString *)localString
{

    NSString *table = [[NSUserDefaults standardUserDefaults] stringForKey:@"AppleTableLanguages"];
    //getDefault
    NSString *lString = [self stringFrom:table ByLocale:[NSString baseLanguage] defaultString:self];
    return [self stringFrom:table ByLocale:[NSString currentLanguage] defaultString:lString];
}
- (NSString *)stringFrom:(NSString *)table ByLocale:(NSString *)locale defaultString:(NSString *)defaultString
{
    NSString *bundlePath = [[ NSBundle mainBundle ] pathForResource:locale ofType:@"lproj" ];
    NSBundle *bundle =  [NSBundle bundleWithPath:bundlePath];
    return NSLocalizedStringWithDefaultValue(self, table, bundle, defaultString,);
}
-(NSString *)displayNameOfLocaleID
{
    return [[NSLocale localeWithLocaleIdentifier:[NSString currentLanguage]] displayNameForKey:NSLocaleIdentifier value:self];
}
////
+ (NSString *)currentLanguage
{
    NSArray *a = [[NSLocale preferredLanguages].firstObject componentsSeparatedByString:@"-"];
    NSString *s = a[0];
    if (a.count > 2) {
        s = [[s stringByAppendingString:@"-"] stringByAppendingString:a[1]];
    }
    return s;
}
+ (NSString *)baseLanguage
{
    return @"Base";//[NSLocale preferredLanguages].lastObject;
}
+ (NSArray<NSString *> *)languages
{
    return [[NSBundle mainBundle] localizations];
}
@end
