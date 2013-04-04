//
//  AlertTable.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 07-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertCell.h"
#import "SalesOverViewController.h"

@interface AlertTable : UITableView <UITableViewDataSource,UITableViewDelegate>
-(void)loadAlertsForBusinessPartner:(BusinessPartner*)bupa;
@end
