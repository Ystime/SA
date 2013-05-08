//
//  ExtrasView.h
//  Sales Around
//
//  Created by IJsbrand van Rijn on 05-04-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import <EventKit/EventKit.h>

@interface ExtrasView : UIView <UITableViewDataSource,UITableViewDelegate,AFOpenFlowViewDelegate,UIAlertViewDelegate>
@property (strong,nonatomic) IBOutlet UIView *leftView;
@property (strong,nonatomic) IBOutlet UIView *rightView;
@property (strong,nonatomic) IBOutlet UIView *middleView;
@property (strong,nonatomic) IBOutlet UILabel *productTitle;
@property (strong,nonatomic) IBOutlet UITableView *calendarTable;
@property (strong,nonatomic) IBOutlet UITableView *taskTable;

-(void)setupNewProductViewWithProducts:(NSDictionary*)products;
-(void)getCalenderEvents;
-(void)getCalendarTasks;
@end
