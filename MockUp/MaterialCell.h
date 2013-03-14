//
//  MaterialCell.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 12-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductViewController.h"

@interface MaterialCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *Labels;
@property (strong, nonatomic) IBOutlet UIImageView *MaterialImage;
@property (strong, nonatomic) IBOutlet UITextView *DescriptionView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withMaterial:(Material*)material;
-(void)setMaterial:(Material*)material;
@end
