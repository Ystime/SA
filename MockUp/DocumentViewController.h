//
//  NewDocumentViewController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 31-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalFunctions.h"
#import "SalesItemCell.h"
#import "AddPopover.h"
#import "ItemViewController.h"
@class HeaderViewController;
@class CustomerViewController;
@class RecentDocumentsViewController;
#import "ZBarSDK.h"
#import "MaterialInfoViewController.h"

@interface DocumentViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,ZBarReaderDelegate>
@property (strong, readonly ) CustomerViewController *cvc;
@property (strong, nonatomic) SalesDocument *tempSalesDocument;
@property (strong, nonatomic) UIPopoverController *pop;
@property (nonatomic) BOOL changeMode;

@property (strong, nonatomic) IBOutlet UITableView *ItemsTable;
@property (strong, nonatomic) IBOutlet UIButton *AddButton;
@property (strong, nonatomic) IBOutlet UIButton *SaveButton;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *ItemActionButtons;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *HeaderLabel;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *ViewCollection;
@property (strong, nonatomic) IBOutlet UILabel *ShipToLabel;

- (IBAction)saveDocs:(id)sender;
- (IBAction)changeItem:(id)sender;

-(void)setHeaderLabelView;
- (void)addItemWithQuantity:(int)quant andMaterial:(Material*)material andAction:(NSString*)docAction;
@end
