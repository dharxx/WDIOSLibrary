//
//  UIImage+StupidApplePhotoFix.m
//  Weinkeller
//
//  Created by Dhanu Saksrisathaporn on 6/23/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import "UIImage+StupidApplePhotoFix.h"
#import <Photos/Photos.h>

@implementation UIImage (StupidApplePhotoFix)
static CGSize PhotoAssetRequestSize = {320,480};
static BOOL RequestThumb = NO;
static NSUInteger MaxImageCache = 20;
+ (void)setMaxImageCache:(NSUInteger)maxImageCache
{
    MaxImageCache = maxImageCache;
}
+ (void)setPhotoAssetRequestSize:(CGSize)photoAssetRequestSize
{
    PhotoAssetRequestSize = photoAssetRequestSize;
    RequestThumb = NO;
}
+ (void)setPhotoAssetRequestThumbSize
{
    PhotoAssetRequestSize = CGSizeMake(128,128);
    RequestThumb = YES;
}
+ (void)setPhotoAssetRequestSizeWithWidth:(CGFloat)width
{
    PhotoAssetRequestSize = CGSizeMake(width,CGFLOAT_MAX);
    RequestThumb = NO;
}
+ (void)setPhotoAssetRequestSizeWithHeight:(CGFloat)height
{
    PhotoAssetRequestSize = CGSizeMake(CGFLOAT_MAX,height);
    RequestThumb = NO;
}

+ (void)requestImageWithObject:(id)object completion:(void (^)(UIImage *image, NSString *imagePath))completion
{
    if ([object isKindOfClass:[UIImage class]])  {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        static NSUInteger c = 0;
        c+=1;
        if (c >= MaxImageCache) {
            c -= MaxImageCache;
        }
        NSString *name = [@"imgCache" stringByAppendingString:@(c).stringValue];
        NSString *path = [paths[0] stringByAppendingPathComponent:name];
        NSData *data = UIImageJPEGRepresentation(object, 0.8);
        [data writeToFile:path atomically:YES];
        completion(object,path);
    }
    
    NSString *path = nil;
    if ([object isKindOfClass:[NSString class]])  {
        path = object;
    }
    if ([object isKindOfClass:[NSURL class]])  {
        path = [object absoluteString];
    }
    if (path) {
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        if (img) {
            completion(img,path);
            return;
        }
    }
    if ([object isKindOfClass:[PHAsset class]])  {
        
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.synchronous = YES;
        [[PHImageManager defaultManager] requestImageForAsset:object
                                                   targetSize:PhotoAssetRequestSize
                                                  contentMode:PHImageContentModeAspectFit
                                                      options:option
                                                resultHandler:^(UIImage *result, NSDictionary *info) {
                                                    NSURL *pathURL = info[@"PHImageFileURLKey"];
                                                    completion(result,[pathURL absoluteString]);
                                                }];
    }
}

- (instancetype)scaleAndRotatePhoto
{
    int kMaxResolution = 640;
    
    CGImageRef imgRef = self.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = self.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

+ (CGSize)imageSize:(NSString *)path
{
    NSURL *imageFileURL = [NSURL fileURLWithPath:path];
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((CFURLRef)imageFileURL, NULL);
    NSValue *value = nil;
    
    if (imageSource != NULL) {
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:NO], (NSString *)kCGImageSourceShouldCache,
                                 nil];
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, (CFDictionaryRef)options);
        if (imageProperties) {
            NSNumber *width = (NSNumber *)CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            NSNumber *height = (NSNumber *)CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            CGSize size = CGSizeMake(width.floatValue,height.floatValue);
            value = [NSValue valueWithCGSize:size];
            CFRelease(imageProperties);
        }
        CFRelease(imageSource);
    }
    
    return value.CGSizeValue;
}
@end
