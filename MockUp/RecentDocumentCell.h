//
//  RecentDocumentCell.h
//  Sales Around
//
//  Created by IJsbrand van Rijn on 16-04-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecentDocumentsViewController.h"

@interface RecentDocumentCell : UITableViewCell
@property IBOutlet UILabel *docID;
@property IBOutlet UILabel *docType;
@property IBOutlet UILabel *docDate;
@property IBOutlet UILabel *docPO;
@property IBOutlet UILabel *docValue;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andSalesDocument:(SalesDocument*)sd;
-(void)setDocument:(SalesDocument*)sd;
@end
