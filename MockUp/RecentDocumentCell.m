//
//  RecentDocumentCell.m
//  Sales Around
//
//  Created by IJsbrand van Rijn on 16-04-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "RecentDocumentCell.h"
@implementation RecentDocumentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andSalesDocument:(SalesDocument*)sd
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setDocument:sd];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setDocument:(SalesDocument*)sd
{
    self.docID.text= sd.OrderID;
    self.docType.text= sd.OrderType;
    self.docDate.text= [GlobalFunctions getStringFormat:@"dd-MM-yyyy" FromDate:sd.DocumentDate];
    self.docPO.text= sd.CustomerPurchaseOrderNumber;
    self.docValue.text= [NSString stringWithFormat:@"%.2f",sd.NetValue.floatValue];
}
@end
