//
//  WDJWTString.m
//  Pods
//
//  Created by Dhanu Saksrisathaporn on 8/10/2559 BE.
//
//

#import "WDJWTString.h"
#import <JWT/JWT.h>
#import <JWT/JWTAlgorithmFactory.h>

@implementation WDJWTString
+ (NSString *)jwtsrc
{
    return [[NSBundle mainBundle] bundleIdentifier];
}
+ (NSArray<NSString *> *)jwtAlgorithms {
    static NSString *algorithms = nil;
    if (!algorithms) {
        algorithms =  @[
                        @"HS256",
                        @"HS384",
                        @"HS512",
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
                        @"RS256"
#endif
                        ];
        srand(time(NULL));
    }
    return algorithms;
}
+(instancetype)jwtString:(NSDictionary *)payload subject:(NSString *)subject secret:(NSString *)secret
{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSInteger timeIntervalInteger = (NSInteger)timeInterval;
    NSMutableDictionary* allPayload = [@{
                                      @"iat" : @(timeIntervalInteger),//since 1970
                                      @"src" : self.jwtsrc,
                                      @"sub" : subject
                                      } mutableCopy];
    if (payload) {
        [allPayload addEntriesFromDictionary:payload];
    }
    
    JWTBuilder *jwt = [[JWTBuilder alloc] init];
    NSString *usedSecret = [subject stringByAppendingString:secret];
    usedSecret = [[usedSecret dataUsingEncoding:NSASCIIStringEncoding] base64EncodedStringWithOptions:0];
    NSArray *algs = [self jwtAlgorithms];
    int randomAlgorithms = rand() % algs.count;
    
    jwt.secret(usedSecret).payload(payload).algorithm([JWTAlgorithmFactory algorithmByName:algs[randomAlgorithms]]);
    
    return [jwt encode];
}
@end
