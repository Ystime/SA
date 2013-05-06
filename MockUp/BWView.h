//
//  BWView.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 05-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicPieChart.h"
#import "MIMBarGraph.h"
#import "BWRequests.h"
#import "XYPieChart.h"
#import "CustomerOverViewController.h"
@interface BWView : UIScrollView <BarGraphDelegate,XYPieChartDataSource,XYPieChartDelegate>
-(void)setupChartsForBusinessPartner:(BusinessPartner*)bupa;
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingCharts;
@property (strong, nonatomic) IBOutlet UILabel *valueSelectedPie;
@property CustomerOverViewController *covc;
@end
