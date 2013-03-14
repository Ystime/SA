//
//  SalesHeaderCell.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 23-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECCSALESDATA_SRVService.h"

@interface SalesHeaderCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *LabelCollection;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andSalesDocument:(SalesDocument *)sd;
-(void)changeSalesDocument:(SalesDocument*)sd;


@end
