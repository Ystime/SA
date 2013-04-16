//
//  RDItemCell.h
//  Sales Around
//
//  Created by IJsbrand van Rijn on 16-04-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecentDocumentsViewController.h"

@interface RDItemCell : UITableViewCell
@property IBOutlet UILabel *itemMaterial;
@property IBOutlet UILabel *itemDescription;
@property IBOutlet UILabel *itemQuantity;
@property IBOutlet UILabel *itemUOM;
@property IBOutlet UILabel *itemNetPrice;
@property IBOutlet UILabel *itemTotalPrice;
-(void)setDocItem:(SalesDocItem *)item;
@end
