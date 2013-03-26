//
//  GlobalFunctions.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 06-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "ECCSALESDATA_SRVService.h"
#import "NSStringAdditions.h"
#import "UIImageAdditions.h"
#import "RequestHandler.h"
#import "SettingsUtilities.h"
#import "DemoData.h"
#import "LGViewHUD.h"
#import "StyledPullableView.h"

#define kPicturesProcesssed @"Pictures have been processed"
#define kNotesProcesssed @"Notes have been processed"
#define kMaterialPicuresProcesssed @"Material pictures have been processed"
#define kMaterialsProcesssed @"Materials have been processed"
#define kBackToHome @"App is returning to startscreen"




@interface GlobalFunctions : NSObject
+ (void)saveImage:(UIImage *)image withName:(NSString *)name;
+ (UIImage *)loadImage:(NSString *)name;
+(NSString*)getStringFormat:(NSString*)format FromDate:(NSDate *)date;
+(void)shiftView:(UIView*)temp horizontal:(float)pixels;
+(void)shiftView:(UIView*)temp vertical:(float)pixels;

@end
