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
                        ];
        srand(time(NULL));
    }
    return algorithms;
}
+(NSString *)jwtString:(NSDictionary *)payload subject:(NSString *)subject secret:(NSString *)secret
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
    usedSecret = [[usedSecret dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    
    NSArray *algs = [self jwtAlgorithms];
    int randomAlgorithms = rand() % algs.count;
    NSLog(@"\nalgorithm : %@",algs[randomAlgorithms]);
    NSLog(@"\npayload : %@",allPayload);
    NSLog(@"\ngenerated secret : %@",usedSecret);
    
    jwt.secret(usedSecret).payload(allPayload).algorithm([JWTAlgorithmFactory algorithmByName:algs[randomAlgorithms]]);
    
    return [jwt encode];
}
@end
