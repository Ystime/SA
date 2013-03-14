//
//  GooglePlacesDetail.h
//  SalesRepApp
//
//  Created by Ystime on 20-06-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuspectAnnotation.h"

@interface GooglePlacesDetail : NSObject <NSXMLParserDelegate>
@property SuspectAnnotation* prospect;

-(SuspectAnnotation*)findDetails:(NSString*)reference;

@end
