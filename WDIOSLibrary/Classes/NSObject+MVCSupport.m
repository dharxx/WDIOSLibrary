//
//  NSObject+MVCSupport.m
//  Weinkeller
//
//  Created by Dhanu Saksrisathaporn on 6/10/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import "NSObject+MVCSupport.h"

@implementation NSObject (MVCSupport)
-(void)setId:(id)identifier
{
    //set id
}
+ (instancetype)newObjectFromDictionary:(NSDictionary *)info
{
    id object = [[self class] new];
    [object setValuesByDictionary:info];
    return object;
}
- (void)setValuesByDictionary:(NSDictionary *)info
{
    static NSString *setStrForm = @"set%@:";
    for (NSString *k in info.allKeys) {
        NSString *cappedString = [[k substringToIndex:1] capitalizedString];
        cappedString = [k stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:cappedString];
        NSString *selStr = [NSString stringWithFormat:setStrForm,cappedString];
        SEL sel = NSSelectorFromString(selStr);
        if ([self respondsToSelector:sel]) {
            IMP imp = [self methodForSelector:sel];
            void (*func)(id, SEL,id) = (void *)imp;
            id v = info[k];
            func(self,sel,v);
//            [self setValue:v forKey:k];
        }
        else {
            NSLog(@"'%@' is not respond",selStr);
        }
    }
}
- (NSString *)valueStringForKey:(NSString *)key
{
    id value = [self valueForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    if( [value respondsToSelector:@selector(stringValue)]) {
        return [value stringValue];
    }
    return nil;
}

- (NSString *)stringValue
{
    return [self description];
}
- (NSString *)priceValue
{
    if ([self respondsToSelector:@selector(doubleValue)]) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        numberFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"de-De"];
        return [numberFormatter stringFromNumber:@([(id)self doubleValue])];
    }
    return @"";
}
@end