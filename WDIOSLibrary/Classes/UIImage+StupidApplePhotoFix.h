//
//  UIImage+StupidApplePhotoFix.h
//  Weinkeller
//
//  Created by Dhanu Saksrisathaporn on 6/23/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import <UIKit/UIKit.h>

//It's true why we have to rotate it every time
@interface UIImage (StupidApplePhotoFix)
- (instancetype)scaleAndRotatePhoto;

//this is add-on nothing about StupidApplePhotoFix
+ (void)setMaxImageCache:(NSUInteger)maxImageCache;
+ (void)requestImageWithObject:(id)object completion:(void (^)(UIImage *image, id imageRef))completion;//imageRef maybe NSString or PHAsset
+ (void)setPhotoAssetRequestThumbSize;
+ (void)setPhotoAssetRequestSizeWithWidth:(CGFloat)width;
+ (void)setPhotoAssetRequestSizeWithHeight:(CGFloat)height;

+ (CGSize)imageSize:(NSString *)path;
@end
