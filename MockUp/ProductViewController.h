//
//  ProductViewController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 07-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocumentViewController.h"
#import "MaterialCollectionCell.h"
#import "MaterialCell.h"
#import "MaterialInfoViewController.h"
@class CustomerViewController;



@interface ProductViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>
- (IBAction)goBack:(id)sender;
- (IBAction)switchView:(id)sender;
- (void)addItemWithQuantity:(int)quant andMaterial:(Material*)material andAction:(NSString*)docAction;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *ViewCollection;
@property (strong, nonatomic) IBOutlet UITableView *MaterialTable;
@property (strong, nonatomic) IBOutlet UICollectionView *MaterialCollection;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *TableLabels;
@property (strong, nonatomic) IBOutlet UIButton *ViewButton;
@property (strong, nonatomic) UIPopoverController *pop;
@property (strong, nonatomic) NSIndexPath *tappedIndexPath;
@property NSMutableArray *materials;



@end
