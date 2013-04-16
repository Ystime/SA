//
//  TwitterSearcher.h
//  Sales Around
//
//  Created by IJsbrand van Rijn on 12-04-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalFunctions.h"

@interface TwitterSearcher : NSObject
{
    NSMutableData *tweetBlob;

}
- (void)grabData:(BusinessPartner *)selectedBupa;
@end
