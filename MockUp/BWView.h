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
#import "CorePlot-CocoaTouch.h"
@interface BWView : UIScrollView <BarGraphDelegate,CPTPlotDataSource,UIActionSheetDelegate,CPTPieChartDelegate,CPTPieChartDataSource,CPTBarPlotDelegate>
-(void)setupChartsForBusinessPartner:(BusinessPartner*)bupa;
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property CustomerOverViewController *covc;
@property (strong, nonatomic) CPTGraphHostingView *PieChartView;
@property (strong, nonatomic) CPTGraphHostingView *BarGraphView;
@end
