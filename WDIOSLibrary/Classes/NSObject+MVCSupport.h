//
//  NSObject+MVCSupport.h
//  Weinkeller
//
//  Created by Dhanu Saksrisathaporn on 6/10/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import <Foundation/Foundation.h>

void wdios_backgroundBlock(void(^block)(void));
void wdios_mainBlock(void(^block)(void));
void wdios_afterDelayBlock(NSTimeInterval delay,void(^block)(void));

@interface NSObject (MVCSupport)
+ (instancetype)newObjectFromDictionary:(NSDictionary *)info;
- (void)setValuesByDictionary:(NSDictionary *)info;
- (void)setId:(id)identifier;

- (NSString *)valueStringForKey:(NSString *)key;
- (NSString *)stringValue;
- (NSString *)priceValue;

//*SUPER SPECIAL WTF GOLDEN RATIO By Calculate is HERE!!
+ (double)goldenRatio;
//and with just define -.-?
#define GOLDEN_RATIO 1.61803398874989484820

#define returnObjectIfNil(o,r) ((o)?(o):(r))
#define emptyStringIfNil(o) returnObjectIfNil(o,@"")
#define nullObjectIfNil(o) returnObjectIfNil(o,[NSNull null])
@end
