//
//  DemoAttachments.m
//  Sales Around
//
//  Created by IJsbrand van Rijn on 22-04-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "DemoAttachments.h"

@implementation DemoAttachments
+(NSMutableDictionary*)loadNotes
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSMutableDictionary *dicBupa1 = [NSMutableDictionary dictionary];
    [dicBupa1 setObject:@"Customer is an excellent, rewarded SAP Consultancy Firm " forKey:@"Rewarded"];
    [dicBupa1 setObject:@"Customer is very focussed on mobile application development for SAP" forKey:@"Mobility"];
    [result setObject:dicBupa1 forKey:@"1"];
    
    NSMutableDictionary *dicBupa2 = [NSMutableDictionary dictionary];
    [dicBupa2 setObject:@"Customer is a partner of Scheer Management B.V." forKey:@"ALERT_%_Partnership_%_today"];
    [result setObject:dicBupa2 forKey:@"2"];
    return result;
}
+(NSMutableDictionary*)loadPics
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSMutableDictionary *dicBupa1 = [NSMutableDictionary dictionary];
    [dicBupa1 setObject:[UIImage imageNamed:@"Scheer Front.jpg"] forKey:@"Scheer Front"];
    [dicBupa1 setObject:[UIImage imageNamed:@"Scheer Inside.jpg"] forKey:@"Scheer Inside"];
    [dicBupa1 setObject:[UIImage imageNamed:@"Scheer Tower.jpg"] forKey:@"Scheer Tower"];
    [result setObject:dicBupa1 forKey:@"1"];
    return result;
}
@end
