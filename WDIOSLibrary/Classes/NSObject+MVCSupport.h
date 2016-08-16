//
//  NSObject+MVCSupport.h
//  Weinkeller
//
//  Created by Dhanu Saksrisathaporn on 6/10/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (MVCSupport)
+ (instancetype)newObjectFromDictionary:(NSDictionary *)info;
- (void)setValuesByDictionary:(NSDictionary *)info;
- (void)setId:(id)identifier;

- (NSString *)valueStringForKey:(NSString *)key;
- (NSString *)stringValue;
- (NSString *)priceValue;

#define returnObjectIfNil(o,r) ((o)?(o):(r))
#define emptyStringIfNil(o) returnObjectIfNil(o,@"")
#define nullObjectIfNil(o) returnObjectIfNil(o,[NSNull null])
@end
