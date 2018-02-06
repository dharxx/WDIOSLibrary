//
//  WDRequestMaker.h
//  AECApp
//
//  Created by Dhanu S on 24/3/57.
//  Copyright (c) พ.ศ. 2557 Dhanu S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDRequestMaker : NSObject

//custom more
+ (NSString *)defaultURL:(NSString *)component;
+ (NSString *)defaultURLImage:(NSString *)component;
//info = @{@"files":@{key:path},@"params":@{key:value}}
+ (NSURLRequest *)uploadDataRequest:(NSString *)urlString method:(NSString *)method info:(NSDictionary *)info;

+ (NSURLRequest *)makeRequest:(NSString *)url method:(NSString *)method info:(NSDictionary *)info;
+ (NSURLRequest *)makePostRequest:(NSString *)url info:(NSDictionary *)info;
+ (NSURLRequest *)makeGetRequest:(NSString *)url info:(NSDictionary *)info;

+ (NSURLRequest *)makeDownloadHeaderRequest:(NSString *)url;
+ (NSURLRequest *)makeDownloadRequest:(NSString *)url;//if first eTag = nil bytes = 0
+ (NSURLRequest *)makeDownloadRequest:(NSString *)url eTag:(NSString *)_eTag size:(long long)_bytes;//if first time eTag = nil

//please set these thing when call make request
//recommend call in Appdelegate first
//except Current Request Subject  that change everytime up to name of request
+ (void)setCurrentRequestSubject:(NSString *)subject;
+ (void)setAuthenKeyCallBack:(NSString *(^)(NSString *subject))handler;
+ (void)setMainURL:(NSString *)mainURL;
+ (void)setMainURLImage:(NSString *)mainURLImage;

@end
