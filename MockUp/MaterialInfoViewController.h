//
//  MaterialInfoViewController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 14-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductViewController.h"
#import "GlobalFunctions.h"
#import "AFOpenFlowView.h"
@interface MaterialInfoViewController : UITableViewController <AFOpenFlowViewDelegate>
@property (strong, nonatomic) Material *material;
@property (strong, nonatomic) NSArray *materials;
@property (strong, nonatomic) NSDictionary *matPics;
@property (strong, nonatomic) SalesDocItem *editItem;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *MaterialLabels;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *SliderButtons;
@property (strong, nonatomic) IBOutlet UIButton *AddButton;
@property (strong, nonatomic) IBOutlet UIImageView *MaterialImage;
@property (strong, nonatomic) IBOutlet UILabel *QuantityLabel;
@property (strong, nonatomic) IBOutlet UISlider *QuantitySlider;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *ViewCollection;
@property (strong, nonatomic) IBOutlet UITableViewCell *TopCell;
@property (strong, nonatomic) UIViewController *parent;


- (IBAction)QuantityChanged:(id)sender;
- (IBAction)changeValue:(id)sender;
- (IBAction)addItem:(id)sender;
@end
