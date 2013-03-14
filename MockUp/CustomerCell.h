//
//  CustomerCell.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 08-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *CustomerIcon;
@property (strong, nonatomic) IBOutlet UILabel *CustomerName;
@property (strong, nonatomic) IBOutlet UILabel *CustomerPhone;
@property (strong, nonatomic) IBOutlet UILabel *CustomerCity;

@end
