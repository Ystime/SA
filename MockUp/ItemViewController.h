//
//  ItemViewController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 28-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECCSALESDATA_SRVService.h"
#import "RequestHandler.h"

@interface ItemViewController : UITableViewController
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *CellLabels;
@property (strong, nonatomic) SalesDocItem *item;
@property (strong, nonatomic) IBOutlet UIImageView *MaterialImage;
-(void)setItem:(SalesDocItem *)Selecteditem andImage:(UIImage*)image;
@end
