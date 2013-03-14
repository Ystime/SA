//
//  GooglePlacesParser.h
//  SalesRepApp
//
//  Created by Ystime on 18-06-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuspectAnnotation.h"

@interface GooglePlacesSearchParser : NSObject <NSXMLParserDelegate>
@property NSMutableArray *prospects;

-(NSMutableArray*)findPlaces:(NSString*)searchURL;
@end
