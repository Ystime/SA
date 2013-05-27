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
const NSString *kPieTitlesID = @"kPieTitlesID";
const NSString *kPieColors = @"kPieColors";
const NSString *kPieDescriptions = @"kPieDescriptions";
const NSString *kPieIcons = @"kPieIcons";
const NSString *kChartValuesX = @"kChartValuesX";
const NSString *kChartTitlesX = @"kChartTitlesX";
const NSString *kChartValuesY = @"kChartValuesY";
const float barWidth = 0.25f;
const float barInitialX = 0.25f;


NSMutableArray *selects;
NSMutableArray *filters;
float totalSumPieChart;
int tappedSlice = -1;
typedef enum {
    kCustomer,KDocumentType
}EQSelect;
EQSelect EQSel;
UIActivityIndicatorView *loadingCharts;


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
    loadingCharts = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loadingCharts.color = [UIColor darkGrayColor];
    loadingCharts.hidesWhenStopped = YES;
    loadingCharts.center = self.center;
    [loadingCharts startAnimating];
    [self insertSubview:loadingCharts atIndex:0];
    pieValues = [[NSMutableDictionary alloc]init];
    chartValues = [[NSMutableDictionary alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(processErrorNotification:) name:kLoadQueryErrorNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(processResultsQuery:) name:kLoadQueryCompletedNotification object:nil];
    [self performSelectorInBackground:@selector(initiateFirstDiagrams) withObject:nil];
//    [self initiateFirstDiagrams];
    
}

-(void)initiateFirstDiagrams
{
    EQSel = kCustomer;
    [self initPlot];
    [[BWRequests uniqueInstance]loadQuery4ForBusinessPartner:bupa andDebit:bupa.BusinessPartnerID andKeyDate:[NSDate date]];
    [self loadPieChartDataFor:EQSel withIndexOfSelectedPieSlice:0];
}

-(void)requestEQ
{
    [[BWRequests uniqueInstance]loadEQForBusinessPartner:bupa withFilters:filters andSelectFields:selects];
}



-(void)processErrorNotification:(NSNotification*)notification
{
        if([[notification.userInfo objectForKey:@"Number of the Query"]isEqualToString:@"99"])
        {
            [self.PieChartView setHidden:YES];
            [loadingCharts stopAnimating];
        }
}
-(void)processResultsQuery:(NSNotification*)notification
{
    [loadingCharts stopAnimating];
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
            case 99:
                [self processEQ:result];
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
}


-(void)processQuery2:(NSMutableArray*)results
{
    
}
-(void)processQuery3:(NSMutableArray*)results
{
    
}
-(void)processQuery4:(NSMutableArray*)results
{
    
    NSMutableArray *XTitles = [NSMutableArray arrayWithObjects:@"0 Days",@"1-30 Days",@"31-60 Days",@"61-180 Days",@"181-365 Days",@">365 Days",nil];
    AZAPP_AR01Result *result = results[0];
    NSMutableArray *tempXValues = [NSMutableArray arrayWithObjects:result.A006EI3ULWC7I23F67E6D3SD18_F,result.A006EI3ULWC7I23F67E6D3SVZW_F,result.A006EI3ULWC7I23F67E6D3TEYK_F,result.A006EI3ULWC7I23F67E6D3TXX8_F,result.A006EI3ULWC7I23F67E6D3UGVW_F,result.A006EI3ULWC7I23F67E6D3UZUK_F,nil];
    int i = 0;
    NSMutableArray *XValues = [NSMutableArray array];
    while(i<tempXValues.count)
    {
        
        NSString *tempString  = tempXValues[i];
        tempString = [tempString stringByReplacingOccurrencesOfString:@"NOT_EXIST" withString:@"0"];
        tempString = [tempString stringByReplacingOccurrencesOfString:@"." withString:@""];
        tempString = [tempString stringByReplacingOccurrencesOfString:@"," withString:@"."];
        [XValues insertObject:tempString atIndex:i];
        i++;
    }
    [chartValues removeAllObjects];
    [chartValues setObject:XTitles forKey:kChartValuesX];
    [chartValues setObject:XValues forKey:kChartValuesY];
    [chartValues setObject:XTitles forKey:kChartTitlesX];
    [self setupBarGraph];
    //    [self.BarGraphView.hostedGraph reloadData];
}

-(void)processEQ:(NSMutableArray*)results
{
    [pieValues removeAllObjects];
    NSMutableArray *values = [NSMutableArray array];
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *titlesID = [NSMutableArray array];
    totalSumPieChart = 0;
    NSMutableArray *colors = [NSMutableArray array];
    NSMutableArray *icons = [NSMutableArray array];
    NSMutableArray *descriptions = [NSMutableArray array];
    [self.PieChartView.hostedGraph performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    for(ZAPP_ORDER03Result *result in results)
    {
        switch (EQSel) {
            case kCustomer:
            {
                totalSumPieChart += result.NetValue.floatValue;
                [values addObject:result.NetValue];
                [titles addObject:[NSString stringWithFormat:@"%@",result.DocumentCategory]];
                [titlesID addObject:result.DocumentCategoryId];
                if(self.PieChartView.gestureRecognizers.count >0)
                    [self.PieChartView removeGestureRecognizer:self.PieChartView.gestureRecognizers[0]];
                break;
            }
            case KDocumentType:
            {
                totalSumPieChart +=result.NetValue.floatValue;
                [values addObject:result.NetValue];
                [titles addObject:result.MaterialGroup];
                UIPinchGestureRecognizer *recog = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pieChartPinched)];
                [self.PieChartView addGestureRecognizer:recog];
                break;
            }
            default:
                break;
        }
        if(result.DocumentCategory)
            [colors addObject:[self getColorForDocumentType:result.DocumentCategory]];
        else
            [colors addObject:[self getColorForDocumentType:@""]];
    }
    [pieValues setObject:values forKey:kPieValues];
    [pieValues setObject:colors forKey:kPieColors];
    [pieValues setObject:titlesID forKey:kPieTitlesID];
    [pieValues setObject:titles forKey:kPieTitles];
    [pieValues setObject:descriptions forKey:kPieDescriptions];
    [pieValues setObject:icons forKey:kPieIcons];
    self.PieChartView.hidden = NO;
    [self.PieChartView.hostedGraph performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
}

-(void)setupBarGraph
{
    
    MIMBarGraph *barGraph = [[MIMBarGraph alloc]initWithFrame:CGRectMake(20, 29, 339, 272)];
    CGPoint temp = self.center;
    temp.x = 0.5*temp.x;
    barGraph.center = temp;
    
    
    barGraph.titleLabel.text = @"Values of open sales documents categorized by age (in days)";
    barGraph.delegate = self;
    //    barGraph.isGradient = YES;
    barGraph.barLabelStyle = BAR_LABEL_STYLE2;
    barGraph.barcolorArray=[NSArray arrayWithObjects:[MIMColorClass colorWithComponent:@"0,255,0,1"], nil];
    barGraph.mbackgroundcolor=[MIMColorClass colorWithComponent:@"0,0,0,0"];
    barGraph.xTitleStyle = XTitleStyle2;
    barGraph.gradientStyle = VERTICAL_GRADIENT_STYLE;
    barGraph.glossStyle = GLOSS_STYLE_2;
    barGraph.layer.masksToBounds = NO;
    self.BarGraphView.hidden = YES;
    [barGraph drawBarChart];
    [self addSubview:barGraph];
}


#pragma mark - BarGraph Delegate

-(NSArray*)valuesForGraph:(id)graph
{
    return [chartValues objectForKey:kChartValuesY];
}

-(NSArray *)valuesForXAxis:(id)graph
{
    return [chartValues objectForKey:kChartValuesX];
}

-(NSArray *)titlesForXAxis:(id)graph
{
    //    NSArray *xTitles = [[NSArray alloc]initWithObjects:@"Pepsi",@"Cola",@"Fanta",@"Dr. Pepper",@"Mezzo-Mix", nil];
    //    return xTitles;
    return [chartValues objectForKey:kChartTitlesX];
    
}

-(NSArray *)titlesForYAxis:(id)graph
{
    return [chartValues objectForKey:kChartValuesY];
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


#pragma mark - CPTPlotDataSource methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    if([plot isKindOfClass:[CPTPieChart class]])
    {
        return [(NSArray*)[pieValues objectForKey:kPieValues]count];
    }
    else if([plot isKindOfClass:[CPTBarPlot class]])
    {
        NSArray *results = [chartValues objectForKey:kChartValuesY];
        if(results.count >= 1)
        {
            return results.count;
        }
        else
            return 0;
    }
    else
        return 0;
}


-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
    if(CPTPieChartFieldSliceWidth == fieldEnum)
    {
        NSArray *temp = [pieValues objectForKey:kPieValues];
        if(temp.count == 0)
            return 0;
        return [(NSArray*)[pieValues objectForKey:kPieValues]objectAtIndex:index];
    }
    
    else if(CPTBarPlotFieldBarTip == fieldEnum)
        return [(NSArray*)[chartValues objectForKey:kChartValuesY]objectAtIndex:index];
    
    return 0;
}

-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index {
    
    if([plot isKindOfClass:[CPTPieChart class]])
    {
        static CPTMutableTextStyle *labelText = nil;
        if (!labelText) {
            labelText= [[CPTMutableTextStyle alloc] init];
            labelText.color = [CPTColor darkGrayColor];
        }
        NSArray *temp = [pieValues objectForKey:kPieValues];
        NSDecimalNumber *tempValue = [temp objectAtIndex:index];
        float percent = tempValue.floatValue / totalSumPieChart;
        NSString *label = [NSString stringWithFormat:@"€ %.2f (%.1f %%)",tempValue.floatValue,percent*100.0f];
        return [[CPTTextLayer alloc]initWithText:label style:labelText];
    }
    else if([plot isKindOfClass:[CPTBarPlot  class]])
    {
    }
    
    return nil;
}

-(NSString *)legendTitleForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index {
    return [(NSArray*)[pieValues objectForKey:kPieTitles]objectAtIndex:index];
    return @"N/A";
}

-(CPTFill*)getColorForDocumentType:(NSString*)type
{
    CPTFill *result;
    if([type isEqualToString:@"Quotation"])
    {
        result = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:1.0 green:0.5492 blue:0 alpha:1]];
    }
    else if([type isEqualToString:@"Inquiry"])
    {
        result = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:1 green:0.84 blue:0 alpha:1]];
    }
    else if([type isEqualToString:@"Invoice"])
    {
        result =[CPTFill fillWithColor:[CPTColor colorWithComponentRed:65 green:105 blue:225 alpha:1]];
    }
    else if([type isEqualToString:@"Order"])
    {
        result = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:0.13333 green:0.545098 blue:0.133333 alpha:1]];
    }
    else if([type isEqualToString:@"Returns"])
    {
        result = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:1 green:0 blue:0 alpha:1]];
    }
    else
    {
        result =[CPTFill fillWithColor:[CPTColor colorWithComponentRed:((float)(((arc4random()%100)+1)/100.0)) green:((float)(((arc4random()%100)+1)/100.0))  blue:((float)(((arc4random()%100)+1)/100.0))  alpha:1]];
    }
    return result;
}

-(CPTFill*)sliceFillForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)idx
{
    return [self getColorForDocumentType:[(NSArray*)[pieValues objectForKey:kPieTitles]objectAtIndex:idx]];
}

#pragma mark - Configure PieChart
-(void)initPlot {
    [self configureHosts];
    [self configureGraphs];
    [self configurePlots];
    [self configureLegend];
    [self configureAxes];
}

-(void)configureHosts {
    CGRect frame = CGRectMake(315, 10, 400, 300);
    self.PieChartView = [(CPTGraphHostingView*)[CPTGraphHostingView alloc]initWithFrame:frame];
    [self addSubview:self.PieChartView];
//    
//    self.BarGraphView = [(CPTGraphHostingView*)[CPTGraphHostingView alloc]initWithFrame:CGRectMake(10, 10, 350, 300)];
//    [self addSubview:self.BarGraphView];
}

-(void)configureGraphs {
    // 1 - Create and initialize graph
    CPTGraph *pieChart = [[CPTXYGraph alloc] initWithFrame:self.PieChartView.bounds];
    self.PieChartView.hostedGraph = pieChart;
    pieChart.paddingLeft = 0.0f;
    pieChart.paddingTop = 0.0f;
    pieChart.paddingRight = 0.0f;
    pieChart.paddingBottom = 0.0f;
    pieChart.axisSet = nil;
    
    CPTGraph *barGraph = [[CPTXYGraph alloc] initWithFrame:self.BarGraphView.bounds];
    barGraph.plotAreaFrame.masksToBorder = NO;
    self.BarGraphView.hostedGraph = barGraph;
    barGraph.paddingBottom = 30.0f;
    barGraph.paddingLeft  = 30.0f;
    barGraph.paddingTop    = -1.0f;
    barGraph.paddingRight  = -5.0f;
    
    
    // 2 - Set up text style
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color = [CPTColor grayColor];
    textStyle.fontName = @"Helvetica-Bold";
    textStyle.fontSize = 15.0f;
    
    
    // 3 - Configure title
    pieChart.title = @"Sales per Document type";
    pieChart.titleTextStyle = textStyle;
    pieChart.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    pieChart.titleDisplacement = CGPointMake(0.0f, -12.0f);
    
    barGraph.title = @"Values  open sales documents (periods)";
    barGraph.titleTextStyle = textStyle;
    barGraph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    barGraph.titleDisplacement = CGPointMake(0.0f,-12.0f);
    
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) barGraph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(6.0f)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(800.0f)];
    
}

-(void)configurePlots {
    // 1 - Get reference to graph
    CPTGraph *pie = self.PieChartView.hostedGraph;
    CPTPieChart *pieChart = [[CPTPieChart alloc] init];
    pieChart.dataSource = self;
    pieChart.delegate = self;
    pieChart.pieRadius = 75.0;
    pieChart.identifier = pie.title;
    pieChart.startAngle = M_PI_4;
    pieChart.sliceDirection = CPTPieDirectionClockwise;
    pieChart.backgroundColor = [[UIColor clearColor]CGColor];
    // 3 - Create gradient
    CPTGradient *overlayGradient = [[CPTGradient alloc] init];
    overlayGradient.gradientType = CPTGradientTypeRadial;
    overlayGradient = [overlayGradient addColorStop:[[CPTColor blackColor] colorWithAlphaComponent:0.0] atPosition:0.9];
    overlayGradient = [overlayGradient addColorStop:[[CPTColor blackColor] colorWithAlphaComponent:0.4] atPosition:1.0];
    pieChart.overlayFill = [CPTFill fillWithGradient:overlayGradient];
    // 4 - Add chart to graph
    [pie addPlot:pieChart];
    
    CPTBarPlot *barChart = [CPTBarPlot tubularBarPlotWithColor:[CPTColor greenColor] horizontalBars:NO];
    barChart.identifier = self.BarGraphView.hostedGraph.title;
    CPTMutableLineStyle *barlineStyle = [[CPTMutableLineStyle alloc]init];
    barlineStyle.lineColor = [CPTColor lightGrayColor];
    barlineStyle.lineWidth = 0.2;
    
    barChart.dataSource = self;
    barChart.delegate = self;
    barChart.barWidth = CPTDecimalFromFloat(barWidth);
    barChart.barOffset = CPTDecimalFromFloat(barInitialX);
    barChart.lineStyle = barlineStyle;
    [self.BarGraphView.hostedGraph addPlot:barChart toPlotSpace:self.BarGraphView.hostedGraph.defaultPlotSpace];
    
    
}

-(void)configureLegend
{
    CPTGraph *graph = self.PieChartView.hostedGraph;
    CPTLegend *theLegend = [CPTLegend legendWithGraph:graph];
    theLegend.numberOfColumns = 1;
    theLegend.fill = [CPTFill fillWithColor:[CPTColor whiteColor]];
    theLegend.borderLineStyle = [CPTLineStyle lineStyle];
    theLegend.cornerRadius = 5.0;
    graph.legend = theLegend;
    graph.legendAnchor = CPTRectAnchorBottomRight;
    graph.legendDisplacement = CGPointMake(0.0, 0.0);
}

-(void)configureAxes
{
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor darkGrayColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 12.0f;
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 2.0f;
    axisLineStyle.lineColor = [[CPTColor darkGrayColor] colorWithAlphaComponent:1];
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.BarGraphView.hostedGraph.axisSet;
    axisSet.xAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    //    axisSet.xAxis.title = @"Value of open orders by period";
    //    axisSet.xAxis.titleTextStyle = axisTitleStyle;
    //    axisSet.xAxis.titleOffset = 10.0f;
    //    axisSet.xAxis.axisLineStyle = axisLineStyle;
    
    axisSet.yAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    //    axisSet.yAxis.title = @"Value";
    //    axisSet.yAxis.titleTextStyle = axisTitleStyle;
    //    axisSet.yAxis.titleOffset = 5.0f;
    //    axisSet.yAxis.axisLineStyle = axisLineStyle;
}


#pragma mark - CPTPieChart Delegate methods
-(void)pieChart:(CPTPieChart *)plot sliceWasSelectedAtRecordIndex:(NSUInteger)idx
{
    if(![SettingsUtilities getDemoStatus])
    {
        if(idx !=tappedSlice)
        {
            tappedSlice = idx;
        }
        else{
            switch (EQSel){
                case kCustomer:
                    EQSel = KDocumentType;
                    [self loadPieChartDataFor:EQSel withIndexOfSelectedPieSlice:tappedSlice];
                    break;
                case KDocumentType:
                    break;
                default:
                    break;
            }
        }
    }
}

-(void)loadPieChartDataFor:(EQSelect)type withIndexOfSelectedPieSlice:(int)index
{
    switch (type) {
        case kCustomer:
            self.PieChartView.hostedGraph.title = @"Value per Document Category";
            selects = [[NSMutableArray alloc]initWithObjects:@"DocumentCategory",@"NetValue",@"DocumentCategoryId",@"NetValueStringFormat",nil];
            filters = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"CustomerId eq '%@'",bupa.BusinessPartnerID], nil];
            break;
        case KDocumentType:
            self.PieChartView.hostedGraph.title = [NSString stringWithFormat:@"Value material groups for %@",[(NSArray*)[pieValues objectForKey:kPieTitles]objectAtIndex:index]];;
            
            [filters addObject:[NSString stringWithFormat:@"DocumentCategoryId eq '%@'",[(NSArray*)[pieValues objectForKey:kPieTitlesID]objectAtIndex:index]]];
            selects = [NSMutableArray arrayWithObjects:@"MaterialGroup",@"NetValue",nil];
            break;
        default:
            break;
    }
    [self.PieChartView setHidden:YES];
    loadingCharts.center = self.PieChartView.center;
    [loadingCharts startAnimating];
    [self performSelectorInBackground:@selector(requestEQ) withObject:nil];
    
}

-(void)pieChartPinched
{
    if(![SettingsUtilities getDemoStatus])
    {
        switch (EQSel) {
            case KDocumentType:
                EQSel = kCustomer;
                [self loadPieChartDataFor:EQSel withIndexOfSelectedPieSlice:0];
                break;
            default:
                break;
        }
    }
}
@end
