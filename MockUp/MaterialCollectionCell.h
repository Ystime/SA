//
//  MaterialCollectionCell.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 12-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductViewController.h"

@interface MaterialCollectionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *MaterialImage;
@property (strong, nonatomic) IBOutlet UILabel *MaterialName;

- (id)initWithMaterial:(Material*)material;
-(void)setMaterial:(Material*)material;

@end
