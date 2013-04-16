//
//  RecentDocumentsViewController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 07-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocumentViewController.h"
@class RecentDocumentCell;
@class RDItemCell;
@interface RecentDocumentsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)goBack:(id)sender;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *ViewCollection;
@property DocumentViewController *dvc;
@property NSArray *documents;
@property (strong, nonatomic) IBOutlet UITableView *DocumentTable;
@property (strong, nonatomic) IBOutlet UITableView *ItemTable;
@property (strong, nonatomic) IBOutlet UIButton *OrderCopyBtn;
@property (strong, nonatomic) IBOutlet UIButton *ItemCopyBtn;
- (IBAction)copyOrder:(id)sender;
- (IBAction)copyItems:(id)sender;
@end
