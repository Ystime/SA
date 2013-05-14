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
NSString *selectedDocCat;
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
    self.backgroundColor = [UIColor clearColor];
    pieValues = [[NSMutableDictionary alloc]init];
    chartValues = [[NSMutableDictionary alloc]init];
    selects = [[NSMutableArray alloc]initWithObjects:@"DocumentCategory",@"NetValue",@"DocumentCategoryId",@"NetValueStringFormat",nil];
    filters = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"CustomerId eq '%@'",bupa.BusinessPartnerID], nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(processErrorNotification:) name:kLoadQueryErrorNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(processResultsQuery:) name:kLoadQueryCompletedNotification object:nil];
    [self performSelectorInBackground:@selector(initiateFirstDiagrams) withObject:nil];

}

-(void)initiateFirstDiagrams
{
    [[BWRequests uniqueInstance]loadQuery4ForBusinessPartner:bupa andDebit:bupa.BusinessPartnerID andKeyDate:[NSDate date]];
    EQSel = kCustomer;
    [[BWRequests uniqueInstance]loadEQForBusinessPartner:bupa withFilters:filters andSelectFields:selects];
}

-(void)requestEQ
{
    [[BWRequests uniqueInstance]loadEQForBusinessPartner:bupa withFilters:filters andSelectFields:selects];
}



-(void)processErrorNotification:(NSNotification*)notification
{
//    NSString *text = self.TitleLabel.text;
//    if(![text hasSuffix:@"!)"])
//        self.TitleLabel.text = [text stringByAppendingString:@" (One or more could not be loaded!)"];
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
        result =[CPTFill fillWithColor:[CPTColor colorWithComponentRed:255 green:255 blue:255 alpha:1]];
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
    for(ZAPP_ORDER03Result *result in results)
    {
        switch (EQSel) {
            case kCustomer:
            {
                totalSumPieChart += result.NetValue.floatValue;
                [values addObject:result.NetValue];
                [titles addObject:[NSString stringWithFormat:@"%@",result.DocumentCategory]];
                [titlesID addObject:result.DocumentCategoryId];
                break;
            }
            case KDocumentType:
            {
                totalSumPieChart +=result.NetValue.floatValue;
                [values addObject:result.NetValue];
                [titles addObject:result.MaterialGroup];
                self.PieChartView.hostedGraph.title =[NSString stringWithFormat:@"Value material groups for %@",selectedDocCat];
                break;
            }
            default:
                break;
        }
    }
    [pieValues setObject:values forKey:kPieValues];
    [pieValues setObject:colors forKey:kPieColors];
    [pieValues setObject:titlesID forKey:kPieTitlesID];
    [pieValues setObject:titles forKey:kPieTitles];
    [pieValues setObject:descriptions forKey:kPieDescriptions];
    [pieValues setObject:icons forKey:kPieIcons];
    if(EQSel == kCustomer)
        [self initPlot];
    else
    {
        self.PieChartView.hidden = NO;
        [self.PieChartView.hostedGraph performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }
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
    
    return [(NSArray*)[pieValues objectForKey:kPieValues]count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
    if(CPTPieChartFieldSliceWidth == fieldEnum)
        return [(NSArray*)[pieValues objectForKey:kPieValues]objectAtIndex:index];
    return 0;
}

-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index {
    
    static CPTMutableTextStyle *labelText = nil;
    if (!labelText) {
        labelText= [[CPTMutableTextStyle alloc] init];
        labelText.color = [CPTColor darkGrayColor];
    }
    
    NSDecimalNumber *tempValue = [(NSArray*)[pieValues objectForKey:kPieValues]objectAtIndex:index];
    float percent = tempValue.floatValue / totalSumPieChart;
    NSString *label = [NSString stringWithFormat:@"€ %.2f (%.1f %%)",tempValue.floatValue,percent*100.0f];
    return [[CPTTextLayer alloc]initWithText:label style:labelText];
//    
//    
//    return nil;
}

-(NSString *)legendTitleForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index {
    return [(NSArray*)[pieValues objectForKey:kPieTitles]objectAtIndex:index];
    return @"N/A";
}

//-(CPTFill*)sliceFillForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)idx
//{
//    return [self getColorForDocumentType:[(NSArray*)[pieValues objectForKey:kPieTitles]objectAtIndex:idx]];
//}

#pragma mark - Configure PieChart
-(void)initPlot {
    [self configureHost];
    [self configureGraph];
    [self configureChart];
    [self configureLegend];
}

-(void)configureHost {
    CGRect frame = CGRectMake(315, 10, 400, 300);
    self.PieChartView = [(CPTGraphHostingView*)[CPTGraphHostingView alloc]initWithFrame:frame];
//    self.PieChartView.allowPinchScaling = NO;

    [self addSubview:self.PieChartView];
}

-(void)configureGraph {
    // 1 - Create and initialize graph
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.PieChartView.bounds];
    self.PieChartView.hostedGraph = graph;
    graph.paddingLeft = 0.0f;
    graph.paddingTop = 0.0f;
    graph.paddingRight = 0.0f;
    graph.paddingBottom = 0.0f;
    graph.axisSet = nil;

    // 2 - Set up text style
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color = [CPTColor grayColor];
    textStyle.fontName = @"Helvetica-Bold";
    textStyle.fontSize = 15.0f;
    // 3 - Configure title
    NSString *title = @"Sales per Document type";
    graph.title = title;
    graph.titleTextStyle = textStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, -12.0f);
    // 4 - Set theme
//    [graph applyTheme:[CPTTheme themeNamed:kCPTPlainWhiteTheme]];
}

-(void)configureChart {
    // 1 - Get reference to graph
    CPTGraph *graph = self.PieChartView.hostedGraph;
    CPTPieChart *pieChart = [[CPTPieChart alloc] init];
    pieChart.dataSource = self;
    pieChart.delegate = self;
    pieChart.pieRadius = 75.0;
    pieChart.identifier = graph.title;
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
    [graph addPlot:pieChart];
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


#pragma mark - CPTPieChart Delegate methods
-(void)pieChart:(CPTPieChart *)plot sliceWasSelectedAtRecordIndex:(NSUInteger)idx
{
    if(idx !=tappedSlice)
    {
        tappedSlice = idx;
        selectedDocCat = [(NSArray*)[pieValues objectForKey:kPieTitles]objectAtIndex:idx ];
    }
    else
    {
        switch (EQSel) {
            case kCustomer:
                EQSel = KDocumentType;
                [filters addObject:[NSString stringWithFormat:@"DocumentCategoryId eq '%@'",[(NSArray*)[pieValues objectForKey:kPieTitlesID]objectAtIndex:idx]]];
                selects = [NSMutableArray arrayWithObjects:@"MaterialGroup",@"NetValue",nil];
                [self.PieChartView setHidden:YES];
                loadingCharts.center = self.PieChartView.center;
                [loadingCharts startAnimating];
                [self performSelectorInBackground:@selector(requestEQ) withObject:nil];
                break;
            case KDocumentType:
                break;
            default:
                break;
        }
    }
}


@end
