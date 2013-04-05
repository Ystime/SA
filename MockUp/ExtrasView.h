//
//  ExtrasView.h
//  Sales Around
//
//  Created by IJsbrand van Rijn on 05-04-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface ExtrasView : UIView <UITableViewDataSource,UITableViewDelegate,AFOpenFlowViewDelegate>
@property (strong,nonatomic) IBOutlet UIView *leftView;
@property (strong,nonatomic) IBOutlet UIView *rightView;
@property (strong,nonatomic) IBOutlet UIView *middleView;
@property (strong,nonatomic) IBOutlet UILabel *productTitle;

-(void)setupViews;
@end
