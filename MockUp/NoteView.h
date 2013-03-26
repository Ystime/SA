//
//  NoteView.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 28-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerViewController.h"

@interface NoteView : UIView <UITableViewDataSource,UITableViewDelegate>
@property IBOutlet UITableView *noteTable;
@property (strong,nonatomic)NSMutableDictionary *notes;
@property CustomerViewController *cvc;

@end
