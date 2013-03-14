//
//  BWView.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 05-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "BWView.h"

@implementation BWView
BusinessPartner *bupa;
NSMutableDictionary *pieValues;
NSMutableDictionary *chartValues;

const NSString *kColors = @"kColors";
const NSString *kPieValues = @"kPieValues";
const NSString *kPieTitles = @"kPieTitles";
const NSString *kPieColors = @"kPieColors";
const NSString *kPieDescriptions = @"kPieDescriptions";
const NSString *kPieIcons = @"kPieIcons";
const NSString *kChartValuesX = @"kChartValuesX";
const NSString *kChartTitlesX = @"kChartTitlesX";
const NSString *kChartValuesY = @"kChartValuesY";




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(void)setupChartsForBusinessPartner:(BusinessPartner*)bupa
{
    pieValues = [[NSMutableDictionary alloc]init];
    chartValues = [[NSMutableDictionary alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(processErrorNotification:) name:kLoadQueryErrorNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(processResultsQuery:) name:kLoadQueryCompletedNotification object:nil];
    [[BWRequests uniqueInstance]loadQuery1ForBusinessPartner:bupa];
    [[BWRequests uniqueInstance]loadQuery4ForBusinessPartner:bupa andDebit:bupa.BusinessPartnerID andKeyDate:[NSDate date]];
}



-(void)processErrorNotification:(NSNotification*)notification
{
    NSString *text = self.TitleLabel.text;
    if(![text hasSuffix:@"!)"])
        self.TitleLabel.text = [text stringByAppendingString:@" (One or more could not be loaded!)"];
}
-(void)processResultsQuery:(NSNotification*)notification
{
    NSDictionary *dict = notification.userInfo;
    NSError *error = [dict objectForKey:kResponseError];
    if(!error)
    {
        NSString *query_number = [dict objectForKey:kQueryNumber];
        int number = query_number.intValue;
        NSMutableArray *result = [dict objectForKey:kResponseItems];
        switch (number) {
            case 1:
                [self processQuery1:result];
                break;
            case 2:
                [self processQuery2:result];
                
                break;
            case 3:
                [self processQuery3:result];
                
                break;
            case 4:
                [self processQuery4:result];
                break;
            default:
                break;
        }
    }
}

-(void)processQuery1:(NSMutableArray*)results
{
    NSMutableArray *values = [NSMutableArray array];
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *colors = [NSMutableArray array];
    NSMutableArray *icons = [NSMutableArray array];
    NSMutableArray *descriptions = [NSMutableArray array];
    for(AZAPP_ORDER01Result *result in results)
    {
        NSArray *temp = [result.A006EI3ULWC7I23DQTK2PB6GHO_F componentsSeparatedByString:@" "];
        
        NSString *tempString = temp[0];
        tempString = [tempString stringByReplacingOccurrencesOfString:@"." withString:@""];
        tempString = [tempString stringByReplacingOccurrencesOfString:@"," withString:@"."];
        tempString = [tempString stringByReplacingOccurrencesOfString:@"-" withString:@""];

        [values addObject:tempString];
        [titles addObject:result.A0DOC_CATEG_T];
        NSString *description = [NSString stringWithFormat:@"The value of %@s requested by this customer is: %@ ",result.A0DOC_CATEG_T,result.A006EI3ULWC7I23DQTK2PB6GHO_F];
        [colors addObject:[self getColorForDocumentType:result.A0DOC_CATEG_T]];
        [descriptions addObject:description];
        [icons addObject:[UIImage imageWithImage:[UIImage imageNamed:@"searchglass_icon.png"] scaledToSize:CGSizeMake(100, 100)]];
    }
    [pieValues setObject:values forKey:kPieValues];
    [pieValues setObject:colors forKey:kPieColors];

    [pieValues setObject:titles forKey:kPieTitles];
    [pieValues setObject:descriptions forKey:kPieDescriptions];
    [pieValues setObject:icons forKey:kPieIcons];
    [self setupPieChart];
}

-(MIMColorClass*)getColorForDocumentType:(NSString*)type
{
    MIMColorClass *result;
    if([type isEqualToString:@"Quotation"])
    {
        result = [MIMColorClass colorWithRed:251 Green:175 Blue:63 Alpha:1];
    }
    else if([type isEqualToString:@"Inquiry"])
    {
        result = [MIMColorClass colorWithRed:128 Green:128 Blue:128 Alpha:1];
    }
    else if([type isEqualToString:@"Invoice"])
    {
        result = [MIMColorClass colorWithRed:65 Green:105 Blue:225 Alpha:1];
    }
    else if([type isEqualToString:@"Order"])
    {
        result = [MIMColorClass colorWithRed:0 Green:165 Blue:80 Alpha:1];
    }
    else if([type isEqualToString:@"Returns"])
    {
        result = [MIMColorClass colorWithRed:255 Green:0 Blue:0 Alpha:1];
    }
    else
    {
        result = [MIMColorClass colorWithRed:255 Green:255 Blue:255 Alpha:1];
    }
    return result;
    
    
}
-(void)processQuery2:(NSMutableArray*)results
{
    
}
-(void)processQuery3:(NSMutableArray*)results
{
    
}
-(void)processQuery4:(NSMutableArray*)results
{
    NSMutableArray *XTitles = [NSMutableArray arrayWithObjects:@"0 Days",@"1-30",@"31-60",@"61-180",@"181-365",@">365",nil];
    AZAPP_AR01Result *result = results[0];
    NSMutableArray *XValues = [NSMutableArray arrayWithObjects:result.A006EI3ULWC7I23F67E6D3SD18_F,result.A006EI3ULWC7I23F67E6D3SVZW_F,result.A006EI3ULWC7I23F67E6D3TEYK_F,result.A006EI3ULWC7I23F67E6D3TXX8_F,result.A006EI3ULWC7I23F67E6D3UGVW_F,result.A006EI3ULWC7I23F67E6D3UZUK_F,nil];
    int i = 0;
    while(i<XValues.count)
    {
        
        NSString *tempString  = XValues[i];
        tempString = [tempString stringByReplacingOccurrencesOfString:@"NOT_EXIST" withString:@"0"];
        tempString = [tempString stringByReplacingOccurrencesOfString:@"." withString:@""];
        tempString = [tempString stringByReplacingOccurrencesOfString:@"," withString:@"."];
        i++;
    }
    [chartValues setObject:XValues forKey:kChartValuesX];
    [chartValues setObject:XValues forKey:kChartValuesY];
    [chartValues setObject:XTitles forKey:kChartTitlesX];
    [self setupBarGraph];
    
    
}
-(void)setupPieChart
{
    BasicPieChart *piechart = [[BasicPieChart alloc]initWithFrame:CGRectMake(369,29,200,272)];
    //    CGPoint temp = self.center;
    //    temp.x = 1.5*temp.x;
    //    piechart.center = temp;
    piechart.delegate = self;
    piechart.showInfoBox = YES;
    piechart.infoBoxSmoothenCorners = YES;
    piechart.fontName=[UIFont fontWithName:@"TrebuchetMS" size:13];
    piechart.fontColor=[MIMColorClass colorWithComponent:@"0.8,0.2,0.2"];
    piechart.infoBoxStyle=INFOBOX_STYLE1;
    piechart.userTouchAllowed = YES;
    piechart.detailPopUpType = mPIE_DETAIL_POPUP_TYPE1;
    piechart.arrowDirection = DIRECTION_BOTTOM;
    piechart.layer.masksToBounds = NO;
    piechart.glossEffect = YES;
    [piechart drawPieChart];
    
    [self addSubview:piechart];
}

-(void)setupBarGraph
{
    
    MIMBarGraph *barGraph = [[MIMBarGraph alloc]initWithFrame:CGRectMake(20, 29, 339, 272)];
    CGPoint temp = self.center;
    temp.x = 0.5*temp.x;
    barGraph.center = temp;
    
    
    barGraph.titleLabel.text = @"Values of open sales documents categorized by age (in days)";
    barGraph.delegate = self;
    barGraph.isGradient = YES;
    barGraph.barLabelStyle = BAR_LABEL_STYLE1;
    barGraph.barcolorArray=[NSArray arrayWithObjects:[MIMColorClass colorWithComponent:@"0,255,0,1"], nil];
    barGraph.mbackgroundcolor=[MIMColorClass colorWithComponent:@"0,0,0,0"];
    barGraph.xTitleStyle = X_TITLES_STYLE2;
    barGraph.gradientStyle = VERTICAL_GRADIENT_STYLE;
    barGraph.glossStyle = GLOSS_STYLE_2;
    barGraph.layer.masksToBounds = NO;
    [barGraph drawBarChart];
    [self addSubview:barGraph];
}

#pragma mark - Pie Chart Delegate
-(float)radiusForPie:(id)pieChart
{
    return 100.0;
}

-(NSArray *)valuesForPie:(id)pieChart
{
    return [pieValues objectForKey:kPieValues];
    
}

-(NSArray *)titlesForPie:(id)pieChart
{
    return [pieValues objectForKey:kPieTitles];
}

-(NSArray *)colorsForPie:(id)pieChart
{
    return [pieValues objectForKey:kPieColors];
}

-(MIMColorClass *)colorForBackground:(id)pieChart
{
    MIMColorClass *bgColor;
    
    
    bgColor=[MIMColorClass colorWithComponent:@"1.0,1.0,1.0,0.0"];
    bgColor.alpha = 0.0;
    
    return bgColor;
}

//-(NSArray *)IconForPie:(id)pieChart
//{
//    return [pieValues objectForKey:kPieIcons];
//}

-(NSArray*)DescriptionForPie:(id)pieChart
{
    return [pieValues objectForKey:kPieDescriptions];
}

-(UIView *)detailedViewForPieSectionAtIndex:(int)index
{
    NSLog(@"Its Working Sofar!");
    return nil;
}

#pragma mark - BarGraph Delegate

-(NSArray*)valuesForGraph:(id)graph
{
    return [chartValues objectForKey:kChartValuesY];
}

-(NSArray *)valuesForXAxis:(id)graph
{
    //    NSArray *xValues = [[NSArray alloc]initWithObjects:@"Pepsi",@"Cola",@"Fanta",@"Dr. Pepper",@"Mezzo-Mix", nil];
    //    return xValues;
    return [chartValues objectForKey:kChartValuesX];
    
}

-(NSArray *)titlesForXAxis:(id)graph
{
    //    NSArray *xTitles = [[NSArray alloc]initWithObjects:@"Pepsi",@"Cola",@"Fanta",@"Dr. Pepper",@"Mezzo-Mix", nil];
    //    return xTitles;
    return [chartValues objectForKey:kChartTitlesX];
    
}

-(NSDictionary *)animationOnBars:(id)graph
{
    return [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:BAR_ANIMATION_VGROW_STYLE],[NSNumber numberWithFloat:1.0], nil] forKeys:[NSArray arrayWithObjects:@"type",@"animationDuration" ,nil] ];
}

-(NSDictionary *)xAxisProperties:(id)graph
{
    return [NSDictionary dictionaryWithObjectsAndKeys:@"0,0,0,1",@"color", nil];
}
-(NSDictionary *)yAxisProperties:(id)graph
{
    return [NSDictionary dictionaryWithObjectsAndKeys:@"0,0,0,1",@"color", nil];
}

-(UILabel *)createLabelWithText:(NSString *)text
{
    UILabel *a=[[UILabel alloc]initWithFrame:CGRectMake(5, self.frame.size.width * 0.5 + 20, 310, 20)];
    [a setBackgroundColor:[UIColor clearColor]];
    [a setText:text];
    a.numberOfLines=5;
    [a setTextColor:[UIColor blackColor]];
    [a setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    return a;
    
}


@end
