//
//  WDRequestMaker.m
//  AECApp
//
//  Created by Dhanu S on 24/3/57.
//  Copyright (c) พ.ศ. 2557 Dhanu S. All rights reserved.
//

#import "WDRequestMaker.h"
#import <Photos/Photos.h>
#import "UIImage+StupidApplePhotoFix.h"
#import "NSString+MVCSupport.h"
@implementation WDRequestMaker
{
}
//custom more
static NSString *(^wdRequestAuthenKeyCallBack)(NSString *subject) = nil;
static NSString *wdRequestSubject = nil;
static NSString *wdRequestMainURL = nil;
static NSString *wdRequestMainURLImage = nil;
static NSString *boundary = @"MayuyuIsNumber1inAKB48SasshiiIsJustGoodOldBoringPolitician";
+ (void)setAuthenKeyCallBack:(NSString *(^)(NSString *subject))handler
{
    wdRequestAuthenKeyCallBack = handler;
}
+ (void)setCurrentRequestSubject:(NSString *)subject
{
    wdRequestSubject = subject;
}
+ (void)setMainURL:(NSString *)mainURL
{
    wdRequestMainURL = mainURL;
}
+ (void)setMainURLImage:(NSString *)mainURLImage
{
    wdRequestMainURLImage = mainURLImage;
}
+ (NSString *)authenKey
{
    if (wdRequestAuthenKeyCallBack) {
        return wdRequestAuthenKeyCallBack(wdRequestSubject);
    }
    return nil;
}
+ (NSString *)defaultURL:(NSString *)component
{
    return [wdRequestMainURL stringByAppendingPathComponent:component];
}
+ (NSString *)defaultURLImage:(NSString *)component
{
    return [wdRequestMainURLImage stringByAppendingPathComponent:component];
}
//
+ (NSURL *)URLWithString:(NSString *)string
{
    NSURL *URL = [NSURL URLWithString:string];
    if (!URL) {
//        string = [string stringByAddingPercentEncodingWithAllowedCharacters:nil];
        URL = [NSURL URLWithString:string];
    }
    return URL;
}

+ (NSURLRequest *)makeDownloadHeaderRequest:(NSString *)url
{
    NSURL *URL= [self URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
    [request setHTTPMethod:@"HEAD"];
    [request setAllHTTPHeaderFields:[self getHeaderFields]];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];
    return request;
}
+ (NSURLRequest *)makeDownloadRequest:(NSString *)url
{
    return [self makeDownloadRequest:url eTag:nil size:0];
}
+ (NSURLRequest *)makeDownloadRequest:(NSString *)url eTag:(NSString *)_eTag size:(long long)_bytes 
{
    NSLog(@"makeDownloadRequest with URL : %@",url);
    NSLog(@"eTag : %@",_eTag);
    NSLog(@"size : %lld",_bytes);
    
    NSURL *URL= [self URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:[self getHeaderFields]];
    if (_eTag) {
        [request setValue:_eTag forHTTPHeaderField:@"If-Range"];
        NSString *range = [NSString stringWithFormat:@"bytes=%lld-", _bytes];
        [request setValue:range forHTTPHeaderField:@"Range"];
    }
    
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];
    return request;
}
+ (NSDictionary *)infoByExtractArray:(NSDictionary *)info
{
    NSMutableDictionary *mInfo = [NSMutableDictionary dictionaryWithCapacity:100];
    for (NSString *key in info.allKeys) {
        id value = info[key];
        if([value isKindOfClass:[NSArray class]]) {
            NSUInteger i = 0;
            for (id v in value) {
                mInfo[[key stringByAppendingFormat:@"[%d]", (int)i]] = v;
                i++;
            }
        }
        else {
            mInfo[key] = value;
        }
    }
    return mInfo;
}
//dont run on main please async this
+ (NSURLRequest *)uploadDataRequest:(NSString *)urlString method:(NSString *)method info:(NSDictionary *)info
{
    NSLog(@"uploadDataRequest with URL : %@",urlString);
    NSLog(@"method : %@",method);
    NSLog(@"info : %@",info);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
    
    //request header
    [request setAllHTTPHeaderFields:[self getHeaderFields]];
    [request setHTTPMethod:method];
    //body
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSDictionary *dataTempFiles = [self infoByExtractArray:info[@"files"]];
    NSDictionary *dataTempParameters = [self infoByExtractArray:info[@"params"]];
    
    NSMutableData *httpBody = [NSMutableData data];
    
    NSLog(@"%@",dataTempParameters);
    for (NSString *name in dataTempParameters.allKeys) {
        id value = dataTempParameters[name];
        if ([value isKindOfClass:[NSDate class]]) {
            NSDateFormatter *dateFormatter =  [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM-dd";
            dateFormatter.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
            dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"de_De"];
            value = [dateFormatter stringFromDate:value];
        }
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", name] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", value] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    PHImageRequestOptions *option = [PHImageRequestOptions new];
    option.synchronous = YES;
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    NSLog(@"%@",dataTempFiles);
    for (NSString *name in dataTempFiles.allKeys) {
        id value = dataTempFiles[name];
        NSString *filename = nil;
        static NSData *data = nil;
        @synchronized (@"syncimagedata") {
            if ([value isKindOfClass:[PHAsset class]]) {
                [[PHImageManager defaultManager] requestImageForAsset:value targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    UIImage *image = [result scaleAndRotatePhoto];
                    data = UIImageJPEGRepresentation(image, 0.8);
                }];
            }
            else  if ([value isKindOfClass:[UIImage class]]) {
                data = UIImageJPEGRepresentation(value, 0.8);
            }
            else  if ([value isKindOfClass:[NSString class]]) {
                filename  = [value lastPathComponent];
                data = [NSData dataWithContentsOfFile:value];
            }
            else  if ([value isKindOfClass:[NSURL class]]) {
                filename  = [value lastPathComponent];
                data = [NSData dataWithContentsOfURL:value];
            }
        }
        if (data) {
            if (!filename) {
                static NSInteger indexSeed = 0;
                indexSeed++;
                filename = [NSString stringWithFormat:@"tempImage_%@.jpg",@(indexSeed)];
            }
            [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, filename] dataUsingEncoding:NSUTF8StringEncoding]];
            [httpBody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [httpBody appendData:data];
            [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [httpBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    [request setHTTPBody:httpBody];
    NSString *bodyLength = [NSString stringWithFormat:@"%lu",(unsigned long)[httpBody length]];
    
    NSLog(@"%@",bodyLength);
    //content length
    [request addValue:bodyLength forHTTPHeaderField:@"Content-Length"];
    
    return request;
}

+ (NSURLRequest *)makeGetRequest:(NSString *)url info:(NSDictionary *)info
{
    
    NSString *bodyString = @"?";
    NSString *format = @"%@=%@";
    NSString *formatAfter = @"&%@=%@";
    for (NSString *key in [info allKeys]) {
        bodyString = [bodyString stringByAppendingFormat:format,
                      [key urlencode],
                      [[info[key] stringValue] urlencode]
                      ];
        format = formatAfter;
    }
    
    url = [url stringByAppendingString:bodyString];
    NSURLRequest *request = [self makeRequest:url method:@"GET" info:nil];
    return request;
}

+ (NSURLRequest *)makePostRequest:(NSString *)url info:(NSDictionary *)info
{
    return [self makeRequest:url method:@"POST" info:info];
}
+ (NSURLRequest *)makeRequest:(NSString *)url method:(NSString *)method info:(NSDictionary *)info
{
    NSLog(@"makeRequest with URL : %@",url);
    NSLog(@"method : %@",method);
    NSLog(@"Info : %@",info);
    
    NSURL *URL= [self URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    //[request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    
    if (info) {
        NSString *bodyString = @"";
        NSString *format = @"%@=%@";
        NSString *formatAfter = @"&%@=%@";
        info = [self infoByExtractArray:info];
        
        for (NSString *key in [info allKeys]) {
            bodyString = [bodyString stringByAppendingFormat:format,
                          [key urlencode],
                          [[info[key] stringValue] urlencode]
                          ];
            format = formatAfter;
        }
        
        NSData *httpBody = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
        
        [request setHTTPBody:httpBody];
        
    }
    
    [request setHTTPMethod:method];
    
    [request setAllHTTPHeaderFields:[self getHeaderFields]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    return request;
}

+(NSDictionary *)getHeaderFields
{
    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString * appBuildString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    NSString *authenKey = [self authenKey];
    
    NSDictionary *headerFields = [NSDictionary dictionary];
    
    // check if have authenKey
    if (authenKey.length > 0) {
        headerFields = @{@"Authorization":authenKey,
                         @"device":@"ios",
                         @"lang":@"de",
                         @"appversion":[NSString stringWithFormat:@"%@(%@)",appVersionString,appBuildString]};
    }else{
        headerFields = @{@"device":@"ios",
                         @"lang":@"de",
                         @"appversion":[NSString stringWithFormat:@"%@(%@)",appVersionString,appBuildString]};
    }
    
    NSLog(@"headerFields : %@",headerFields);
    
    return headerFields;
}


@end
