//
//  SalesDocumentItem_SDAction.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 26-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "ECCSALESDATA_SRVService.h"

@interface SalesDocumentItem (Actions)
@property (nonatomic,copy) NSString *action;
@end

NSString * const kActionKey = @"kActionKey";

@implementation SalesDocumentItem (Actions)

-(void)setAction:(NSString *)action
{
}

@end
