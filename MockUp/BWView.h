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

@interface BWView : UIScrollView<MIMPieChartDelegate,BarGraphDelegate>
-(void)setupChartsForBusinessPartner:(BusinessPartner*)bupa;
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@end
