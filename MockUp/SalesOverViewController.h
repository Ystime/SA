//
//  SalesOverViewController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 22-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalesHeaderCell.h"
#import "SalesItemCell.h"
#import "ItemViewController.h"
#import "GlobalFunctions.h"
#import "LGViewHUD.h"
#import "CustomerViewController.h"
#import "UIScrollView+SVPullToRefresh.h"

@interface SalesOverViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,PullableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *DocumentTable;
@property (strong, nonatomic) IBOutlet UITableView *ItemTable;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *ViewCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *DocumentButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *ItemButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *StatusButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *TypeButtons;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *PullableSubViews;
@property (strong, nonatomic) IBOutlet StyledPullableView *FilterPullView;
@property (strong, nonatomic) IBOutlet UITextView *FilterHandle;

@property (strong, nonatomic) IBOutlet UIView *DocumentView;
@property (strong, nonatomic) IBOutlet UIView *ItemView;
@property (strong, nonatomic) IBOutlet UILabel *NothingLabel;
@property (strong, nonatomic) UIPopoverController *pop;
@property (strong, nonatomic) CustomerViewController *cvc;
- (IBAction)orderDocuments:(id)sender;
- (IBAction)orderItems:(id)sender;
- (IBAction)changeStatus:(id)sender;
- (IBAction)filterOnType:(id)sender;
@end
