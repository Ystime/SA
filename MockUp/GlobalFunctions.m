//
//  GlobalFunctions.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 06-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "GlobalFunctions.h"

@implementation GlobalFunctions
+ (void)saveImage:(UIImage *)image withName:(NSString *)name {
    NSData *pngData = UIImagePNGRepresentation(image);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:name]; //Add the file name
    [pngData writeToFile:filePath atomically:YES];
}

+ (UIImage *)loadImage:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:name]; //Add the file name
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    return image;
}

+(NSString*)getStringFormat:(NSString*)format FromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

+(void)shiftView:(UIView*)temp horizontal:(float)pixels
{
    CGRect oldFrame = temp.frame;
    oldFrame.origin.x += pixels;
    temp.frame = oldFrame;
}

+(void)shiftView:(UIView*)temp vertical:(float)pixels
{
    CGRect oldFrame = temp.frame;
    oldFrame.origin.y += pixels;
    temp.frame = oldFrame;
}
@end
