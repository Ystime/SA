//
//  SalesItemCell.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 23-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECCSALESDATA_SRVService.h"

@interface SalesItemCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *Labels;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andSalesItem:(SalesDocItem*)item;
-(void)changeItem:(SalesDocItem*)item;
@property (strong, nonatomic) IBOutlet UIImageView *ActionImage;
@property (strong, nonatomic) IBOutlet UIImageView *MaterialImage;

@end
