//
//  SoldToController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 07-03-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeaderViewController;

@interface SoldToController : UITableViewController
@property HeaderViewController *hvc;
@property NSArray *customers;
@property NSArray *shipTos;
@end
