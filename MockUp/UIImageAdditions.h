//
//  UIImage_UIImageAdditions.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 09-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface UIImage (UIImageAdditions)
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+(UIImage *)makeRoundedImage:(UIImage *) image
                      radius: (float) radius;
@end

#import <UIKit/UIImage.h>

@implementation UIImage (UIImageAdditions)

//+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
//    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
//        if ([[UIScreen mainScreen] scale] == 2.0) {
//            UIGraphicsBeginImageContextWithOptions(newSize, YES, 2.0);
//        } else {
//            UIGraphicsBeginImageContext(newSize);
//        }
//    } else {
//        UIGraphicsBeginImageContext(newSize);
//    }
//    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
//}


+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
+(UIImage *)makeRoundedImage:(UIImage *) image
                      radius: (float) radius
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}
@end

#import <UIKit/UIView.h>
@interface UIView (UIViewAdditions)

+ (void) changeLayoutToDefaultProjectSettings:(UIView*)view;
@end

@implementation UIView (UIViewAdditions)
+ (void) changeLayoutToDefaultProjectSettings:(UIView*)view
{
    view.layer.cornerRadius = 8.0;
    view.layer.masksToBounds = YES;
}



@end