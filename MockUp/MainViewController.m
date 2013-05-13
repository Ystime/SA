//
//  MainViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 08-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "MainViewController.h"
#import "ExtrasView.h"
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize BusinessPartners,VisibleBusinessPartners,Materials,MaterialGroups;
NSMutableArray *prospects;
NSMutableArray *bupasForLogo;
BOOL firstTime;
AFOpenFlowView *logoFlow;
LGViewHUD *hudBUPAS;
int selectedRow = -1;
NSMutableDictionary *hierLogos;
NSMutableArray *parentKeys;
NSMutableArray *visibleTypes;
NSMutableDictionary *parents;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    for(UIView *view in self.ViewCollection)
    {
        [UIView changeLayoutToDefaultProjectSettings:view];
    }
    self.FilterPullView.layer.masksToBounds = NO;
    /*Creating the borders*/
    self.mapView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.mapView.layer.borderWidth = 1.0;
    
    /*Initializing the variables*/
    BusinessPartners = [[NSMutableArray alloc]init];
    visibleTypes = [[NSMutableArray alloc]init];
    [visibleTypes addObject:[NSString stringWithFormat:@"Customer"]];
    
    firstTime = YES;
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(processingResultGetBusinessPartners:) name:kLoadBusinessPartnersCompletedNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(parentsLoaded:) name:kLoadHierarchyCompletedNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setupOpenFlow:) name:kParentsPicLoaded object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(materialsLoaded:) name:kLoadMaterialCompletedNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(materialPicturesLoaded:) name:kMaterialPicuresLoaded object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(materialGroupsLoaded:) name:kMaterialGroupsLoaded object:nil];

    [[RequestHandler uniqueInstance]performSelectorInBackground:@selector(loadParents) withObject:nil];
    [[RequestHandler uniqueInstance]performSelectorInBackground:@selector(loadMaterials) withObject:nil];
    [[RequestHandler uniqueInstance]performSelectorInBackground:@selector(loadMaterialGroups) withObject:nil];


    
    //Start requesting BUPAs
    
    hudBUPAS = [LGViewHUD defaultHUD];
    hudBUPAS.activityIndicatorOn = YES;
    hudBUPAS.topText = @"Loading Data!";
    hudBUPAS.bottomText = @"Please Wait!";
    
    [hudBUPAS showInView:self.CustomerTable];
    [[RequestHandler uniqueInstance]loadBusinessPartners];
    
    [self.FlowView addSubview:logoFlow];
    [self.CustomerTable addPullToRefreshWithActionHandler:^{
        [hudBUPAS showInView:_CustomerTable];
        [self.CustomerTable reloadData];
        [logoFlow removeFromSuperview];
        logoFlow = nil;
        [self.loadingParents startAnimating];
        [[RequestHandler uniqueInstance]loadBusinessPartners];
        [[RequestHandler uniqueInstance]loadParents];
        [self.CustomerTable.pullToRefreshView stopAnimating];
        
        
    }];
    [self setupPullView];
    [self setupFilterView];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.ExtrasSubView getCalenderEvents];
    [self.ExtrasSubView getCalendarTasks];
}
-(void)viewDidAppear:(BOOL)animated
{
    
    if(firstTime)
    {
        firstTime = NO;
        [self setMapRegion:_mapView.userLocation.coordinate forKilometers:50];
    }

}

-(void)viewWillDisappear:(BOOL)animated
{
    
}
- (void)viewDidUnload {
    [self setMapView:nil];
    [self setCustomerTable:nil];
    [self setFlowView:nil];
    [self setActionView:nil];
    [self setNewProductsView:nil];
    [self setCustomerSearchField:nil];
    [self setProspectSearchField:nil];
    [self setMapTypeButton:nil];
    [self setMyPositionButton:nil];
    [self setExtrasView:nil];
    [self setFilterImage:nil];
    [self setFilterIconView:nil];
    [self setFlowLabel:nil];
    [self setViewCollection:nil];
    [self setViewCollection:nil];
    [self setShiftingViews:nil];
    [self setOwnView:nil];
    [super viewDidUnload];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegation

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row <VisibleBusinessPartners.count)
    {
        [self annotateVisibleCustomers];
        selectedRow = indexPath.row;
        BusinessPartner *bp = [VisibleBusinessPartners objectAtIndex:indexPath.row];
        [self setMapRegion:CLLocationCoordinate2DMake(bp.Address.GeoCode.Latitude.doubleValue, bp.Address.GeoCode.Longitude.doubleValue)forKilometers:10];
        for(id<MKAnnotation> anno in self.mapView.annotations)
        {
            if([anno isKindOfClass:[CustomerAnnotation class]])
            {
                CustomerAnnotation *temp = (CustomerAnnotation*)anno;
                if([temp.bupa.BusinessPartnerID isEqualToString:bp.BusinessPartnerID])
                {
                    [self.mapView selectAnnotation:anno animated:YES];
                    break;
                }
            }
        }
    }
    else
        [self performSegueWithIdentifier:@"Details" sender:nil];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return VisibleBusinessPartners.count+1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < VisibleBusinessPartners.count)
    {
        CustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"standardCell"];
        if(cell == nil)
        {
            cell = [[CustomerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"standardCell"];
        }
        
        BusinessPartner *bp = [VisibleBusinessPartners objectAtIndex:indexPath.row];
        cell.CustomerName.text = bp.BusinessPartnerName;
        cell.CustomerPhone.text = bp.Address.Street;
        cell.CustomerCity.text = bp.Address.City;
        
        if([bp.BusinessPartnerType isEqualToString:@"Prospect"])
        {
            cell.CustomerIcon.image = [UIImage imageNamed:@"Prospect_Pin.png"];
        }
        else if([bp.BusinessPartnerType isEqualToString:@"Customer"])
        {
            cell.CustomerIcon.image = [UIImage imageNamed:@"Customer_Pin.png"];
        }
        else if([bp.BusinessPartnerType isEqualToString:@"Competitor"])
        {
            cell.CustomerIcon.image = [UIImage imageNamed:@"Competitor_Pin.png"];
        }
        else
            cell.CustomerIcon.image = [UIImage imageNamed:@"unknown.png"];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addBUPACell"];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"standardCell"];
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if([self.CustomerSearchField isFirstResponder])
        [self.CustomerSearchField resignFirstResponder];
    if(indexPath.row <VisibleBusinessPartners.count)
        [self performSegueWithIdentifier:@"CustomerOverview" sender:[VisibleBusinessPartners objectAtIndex:indexPath.row]];
}


#pragma mark - Loading Business Partners
-(void)clearBusinessPartners
{
    
}
-(void)processingResultGetBusinessPartners:(NSNotification*)notification
{
    [hudBUPAS hideWithAnimation:HUDAnimationHideFadeOut];
    NSDictionary *userInfoDict = [notification userInfo];
    NSError *error = [userInfoDict objectForKey:@"error"];
    if(error)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        NSMutableArray *unsortedBusinessParters = [userInfoDict objectForKey:kResponseItems];
        BusinessPartners = (NSMutableArray*)[unsortedBusinessParters sortedArrayUsingComparator:^NSComparisonResult(id a, id b)
                                             {
                                                 
                                                 NSString *first = [(BusinessPartner*)a BusinessPartnerName];
                                                 NSString *second = [(BusinessPartner*)b BusinessPartnerName];
                                                 NSString *firstUpper = [first uppercaseString];
                                                 NSString *secondUpper = [second uppercaseString];
                                                 return [firstUpper compare:secondUpper];
                                             }];
        [logoFlow centerOnSelectedCover:YES];
        [logoFlow setSelectedCover:0];
        //        [logoFlow centerOnSelectedCover:YES];
        self.FlowLabel.text = @"All companies";
        self.CustomerSearchField.text = self.ProspectSearchField.text = @"";
        bupasForLogo = BusinessPartners;
        VisibleBusinessPartners = [self filterBupaArray:bupasForLogo];
        
        [self.CustomerTable reloadData];
        [self annotateVisibleCustomers];
    }
}

-(void)annotateVisibleCustomers
{
    self.ProspectSearchField.text = @"";
    NSMutableArray *annotationsToRemove = [self.mapView.annotations mutableCopy];
    [annotationsToRemove removeObject:_mapView.userLocation];
    [self.mapView removeAnnotations:annotationsToRemove];
    for(BusinessPartner *bp in VisibleBusinessPartners)
    {
        CustomerAnnotation *annotation = [[CustomerAnnotation alloc]initWithBussinessPartner:bp];
        [self.mapView addAnnotation:annotation];
    }
//    [self centerMyPosition:nil];
}

-(void)loadProspects:(NSString*)searchText
{
    [self.mapView removeAnnotations:prospects];
    GooglePlacesSearchParser *parser = [[GooglePlacesSearchParser alloc]init];
    searchText = [searchText stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *apiKey = @"AIzaSyBGHEoD8uMDk7Fwq_Bk6l1jp8Gsxl9bL5Y";
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/xml?location=%f,%f&radius=25000&keyword=%@&sensor=true&key=%@",self.mapView.userLocation.coordinate.latitude,self.mapView.userLocation.coordinate.longitude,searchText,apiKey];
    prospects = [parser findPlaces:url];
    [self annotateProspects];
    
}

-(void)annotateProspects
{
    NSMutableArray *toKeep = [[NSMutableArray alloc]init];
    for(SuspectAnnotation *prospect in prospects)
    {
        if(![self checkProspectAlreadyCustomer:prospect])
        {
            [self.mapView addAnnotation:prospect];
            [toKeep addObject:prospect];
        }
    }
    prospects = toKeep;
    
    if(prospects.count == 0)
    {
        UIAlertView *noResults = [[UIAlertView alloc]initWithTitle:@"No Results" message:@"The given searchterm did not generate any results!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [noResults show];
    }
    else
    {
        [self centerMyPosition:nil];
    }
}

-(BOOL)checkProspectAlreadyCustomer:(SuspectAnnotation*)pProspect
{
    bool result = NO;
    for(BusinessPartner *bupa in BusinessPartners)
    {
        NSString *vicinity = [NSString stringWithFormat:@"%@ %@, %@",bupa.Address.Street,bupa.Address.HouseNumber,bupa.Address.City];
        if([vicinity isEqualToString:pProspect.vicinity])
            result  = YES;
    }
    return result;
}

#pragma mark - Loading Hierarchy
-(void)parentsLoaded:(NSNotification*)notification
{
    if([notification.userInfo objectForKey:kResponseError])
        self.FlowLabel.text = @"Unable to load";
    else
    {
        parents = [notification.userInfo objectForKey:kResponseItems];
        parentKeys = [NSMutableArray arrayWithArray:parents.allKeys];
        [parentKeys insertObject:@"All" atIndex:0];
        [[RequestHandler uniqueInstance]performSelectorInBackground:@selector(loadImagesForParents:) withObject:parents.allKeys];
//        [[RequestHandler uniqueInstance]loadImagesForParents:parents.allKeys];
    }
}

#pragma mark - Loading Materials

-(void)materialsLoaded:(NSNotification*)notification
{
    NSError *error = [notification.userInfo objectForKey:kResponseError];
    if(error)
    {
        Materials = [NSMutableArray arrayWithCapacity:0];
    }
    else
    {
        Materials = [notification.userInfo objectForKey:kResponseItems];
        NSMutableArray *temp = [NSMutableArray array];
        for(Material *material in Materials)
        {
            [temp addObject:material.MaterialNumber];
        }
        [[RequestHandler uniqueInstance]performSelectorInBackground:@selector(loadImagesforMaterials:) withObject:temp];
    }
}

-(void)materialPicturesLoaded:(NSNotification*)notification
{
    NSError *error;
    error = [notification.userInfo objectForKey:kResponseError];
    if(error)
    {
        self.MaterialPictures = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    else
    {
        self.MaterialPictures = [notification.userInfo objectForKey:kResponseItems];
        [self selectPromoMaterials];
    }
}

-(void)selectPromoMaterials
{
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    for(Material *temp in Materials)
    {
        if([temp.MaterialNumber hasSuffix:@"002"])
            [tempDic setObject:[self.MaterialPictures objectForKey:temp.MaterialNumber] forKey:temp.Description];
    }
    [self.ExtrasSubView setupNewProductViewWithProducts:tempDic];

}

-(void)materialGroupsLoaded:(NSNotification*)notification
{
    MaterialGroups = [notification.userInfo objectForKey:kResponseItems];
    
    /*
     Code below can be used in case materials can not be requested but material groups with materials can....
    */
    
    /*
    Materials = [NSMutableArray array];
    for(MaterialGroup *mg in MaterialGroups)
    {
        [Materials addObjectsFromArray:mg.MaterialSet];
    }
    NSMutableArray *temp = [NSMutableArray array];
    for(Material *material in Materials)
    {
        [temp addObject:material.MaterialNumber];
    }
    [[RequestHandler uniqueInstance]performSelectorInBackground:@selector(loadImagesforMaterials:) withObject:temp];
     */
}
#pragma mark - MapView Delegate Functions

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (annotation == mapView.userLocation)
    {
        return nil;
    }
    else if([annotation isKindOfClass:[CustomerAnnotation class]])
    {
        CustomerAnnotation *annot = (CustomerAnnotation*)annotation;
        MKAnnotationView *av = (MKAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomerAnnotation"];
        if(av == nil)
        {
            av= [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"CustomerAnnotation"];
        }
        else
            av.annotation = annotation;
        
        if([annot.bupa.BusinessPartnerType isEqualToString:@"Competitor"])
        {
            av.image = [UIImage imageWithImage:[UIImage imageNamed:@"Competitor_Pin.png"] scaledToSize:CGSizeMake(50, 50)];
            
        }
        else if ([annot.bupa.BusinessPartnerType isEqualToString:@"Prospect"])
        {
            av.image = [UIImage imageWithImage:[UIImage imageNamed:@"Prospect_Pin.png"] scaledToSize:CGSizeMake(50, 50)];
            
        }
        else
        {
            av.image = [UIImage imageWithImage:[UIImage imageNamed:@"Customer_Pin.png"] scaledToSize:CGSizeMake(50, 50)];
        }
        av.canShowCallout = YES;
        UIButton* details = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        av.rightCalloutAccessoryView = details;
        return av;
    }
    else if ([annotation isKindOfClass:[SuspectAnnotation class]])
    {
        MKAnnotationView *av = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"SuspectAnnotation"];
        if(av == nil)
            av = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"SuspectAnnotation"];
        else
            av.annotation = annotation;
        UIButton *addProspect = [UIButton buttonWithType:UIButtonTypeContactAdd];
        av.rightCalloutAccessoryView = addProspect;
        av.canShowCallout = YES;
        av.image = [UIImage imageWithImage:[UIImage imageNamed:@"Suspect_Pin.png"] scaledToSize:CGSizeMake(50, 50)];
        
        
        return av;
    }
    else
        return nil;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if([view.annotation isKindOfClass:[SuspectAnnotation class]])
    { 
        [self performSegueWithIdentifier:@"Details" sender:view.annotation];
    }
    else if([view.annotation isKindOfClass:[CustomerAnnotation class]])
    {
        CustomerAnnotation *ca = view.annotation;
        [self performSegueWithIdentifier:@"CustomerOverview" sender:ca.bupa];
    }
}

-(void)setMapRegion:(CLLocationCoordinate2D)location forKilometers:(int)km
{
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location, km*1000, km*1000);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion animated:YES];
}

#pragma mark - OpenFlowView Delegate functions

-(void)setupOpenFlow:(NSNotification*)notification
{
    /*Mocking up the logo flow*/
    hierLogos = [notification.userInfo objectForKey:kResponseItems];
    logoFlow = [[AFOpenFlowView alloc]initWithFrame:self.FlowView.bounds];
    logoFlow.numberOfImages = parentKeys.count;
    logoFlow.viewDelegate = self;
    for(int i = 0;i<parentKeys.count;i++)
    {
        UIImage *temp = [UIImage imageWithImage:[hierLogos objectForKey:parentKeys[i]] scaledToSize:CGSizeMake(150, 150)];
        [logoFlow setImage:temp forIndex:i];
    }
    [self.loadingParents stopAnimating];
    [self.FlowView addSubview:logoFlow];
}
- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index
{
    self.CustomerSearchField.text = @"";
    
    NSString *bupaID = parentKeys[index];
    if([bupaID isEqualToString:@"All"])
    {
        self.FlowLabel.text = bupaID;
        VisibleBusinessPartners = BusinessPartners;
    }
    else
    {
        BusinessPartnerParent *tempParent = [parents objectForKey:bupaID];
        VisibleBusinessPartners = [NSMutableArray array];
        for(BusinessPartner *bp in BusinessPartners)
        {
            if([tempParent.BusinessPartners containsObject:bp.BusinessPartnerID])
                [VisibleBusinessPartners addObject:bp];
        }
        self.FlowLabel.text = tempParent.BusinessPartnerName;
    }
    
    
    bupasForLogo = VisibleBusinessPartners;
    VisibleBusinessPartners = [self filterBupaArray:bupasForLogo];
    [self.CustomerTable reloadData];
    [self annotateVisibleCustomers];
}


#pragma mark - TextView Delegate Functions

-(void)textViewDidChange:(UITextView *)textView
{
    if([textView isEqual:self.CustomerSearchField])
    {
        if([textView.text isEqualToString:@""]||textView.text == nil)
        {
            VisibleBusinessPartners = bupasForLogo;
        }
        else
        {
            VisibleBusinessPartners = [self filterBupaArray:bupasForLogo onText:textView.text];
            VisibleBusinessPartners = [self filterBupaArray:VisibleBusinessPartners];
        }
        [self.CustomerTable reloadData];
        [self annotateVisibleCustomers];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
        if([textView isEqual:self.ProspectSearchField])
            [self loadProspects:textView.text];
        
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView isEqual:self.CustomerSearchField])
    {
        //        for(UIView *shiftingView in self.shiftingViews)
        //        {
        //            if([shiftingView isKindOfClass:[UITableView class]] ||[shiftingView isEqual:self.FilterIconView] )
        //            {
        //                CGRect oldFrame = shiftingView.frame;
        //                oldFrame.size.height = oldFrame.size.height-150;
        //                shiftingView.frame = oldFrame;
        //            }
        //            else
        //            {
        //                [self changeView:shiftingView YoriginWith:-150];
        //            }
        //        }
        //
        //
        //        [self changeView:self.CustomerSearchField YoriginWith:(-350)];
        //        [self changeView:self.filterImage YoriginWith:(-350)];
        //        //        VisibleBusinessPartners = BusinessPartners;
        //        [self.CustomerTable reloadData];
    }
    textView.text = @"";
    VisibleBusinessPartners = [self filterBupaArray:bupasForLogo onText:@""];
    VisibleBusinessPartners = [self filterBupaArray:VisibleBusinessPartners];
    [self.CustomerTable reloadData];
    [self.mapView removeAnnotations:prospects];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if([textView isEqual:self.CustomerSearchField])
    {
        //
        //        for(UIView *shiftingView in self.shiftingViews)
        //        {
        //            if([shiftingView isKindOfClass:[UITableView class]] ||[shiftingView isEqual:self.FilterIconView] )
        //            {
        //                CGRect oldFrame = shiftingView.frame;
        //                oldFrame.size.height = oldFrame.size.height+150;
        //                shiftingView.frame = oldFrame;
        //            }
        //            else
        //            {
        //                [self changeView:shiftingView YoriginWith:150];
        //            }
        //        }
        //
        //        [self changeView:self.CustomerSearchField YoriginWith:(350)];
        //        [self changeView:self.filterImage YoriginWith:(350)];
    }
}

#pragma mark - Filtering options for BUPA arrays

-(NSMutableArray*)filterBupaArray:(NSMutableArray*)unfilteredArray onText:(NSString*)filtertext
{
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    if( [filtertext isEqualToString:@""])
        return unfilteredArray;
    for(BusinessPartner *bp in unfilteredArray)
    {
        NSRange nameRange = [bp.BusinessPartnerName rangeOfString:filtertext options:NSCaseInsensitiveSearch];
        if(nameRange.location != NSNotFound)
        {
            [resultArray addObject:bp];
        }
    }
    return resultArray;
}

-(NSMutableArray*)filterBupaArray:(NSMutableArray*)unfilteredArray onHierarchy:(NSString*)hierarchy
{
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    for(BusinessPartner *bp in unfilteredArray)
    {
        if([bp.BusinessPartnerName isEqualToString:hierarchy])
            [resultArray addObject:bp];
    }
    return resultArray;
}

-(NSMutableArray*)filterBupaArray:(NSMutableArray*)unfilteredArray
{
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    for(BusinessPartner *bp in unfilteredArray)
    {
        if([visibleTypes containsObject:bp.BusinessPartnerType])
            [resultArray addObject:bp];
    }
    return resultArray;
}

#pragma mark - PullView Functions
-(void)setupPullView
{
    [self.ExtrasView setupPullableView:self.ExtrasView.frame];
    for(UIView *view in self.PullSubViews)
    {
        view.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        view.layer.borderWidth = 2.0;
    }
    self.ExtrasView.openedCenter = CGPointMake(642, self.view.frame.size.width-150);
    self.ExtrasView.closedCenter = CGPointMake(642, self.view.frame.size.width+122);
    self.ExtrasView.center = self.ExtrasView.closedCenter;
    self.ExtrasView.handleView.frame = self.handleLabel.frame;
}
-(void)setupFilterView
{
    [self.FilterPullView setupPullableView:self.FilterPullView.frame];
    self.FilterPullView.openedCenter = CGPointMake(125,356);
    self.FilterPullView.closedCenter = CGPointMake(125,487);
    self.FilterPullView.center = self.FilterPullView.closedCenter;
    self.FilterPullView.handleView.frame = self.filterHandle.frame; 
    
}





#pragma mark - Button functions
- (IBAction)changeMapType:(id)sender {
    if(self.mapView.mapType == MKMapTypeStandard)
    {
        self.mapView.mapType = MKMapTypeSatellite;
        [self.MapTypeButton setTitle:@"Hybrid" forState:UIControlStateNormal];
    }
    else if(self.mapView.mapType == MKMapTypeSatellite)
    {
        self.mapView.mapType = MKMapTypeHybrid;
        [self.MapTypeButton setTitle:@"Map" forState:UIControlStateNormal];
    }
    else if (self.mapView.mapType == MKMapTypeHybrid)
    {
        self.mapView.mapType = MKMapTypeStandard;
        [self.MapTypeButton setTitle:@"Satellite" forState:UIControlStateNormal];
    }
}

- (IBAction)centerMyPosition:(id)sender {
    [self setMapRegion:self.mapView.userLocation.coordinate forKilometers:50];
}

- (IBAction)showExtras:(id)sender {
    /*Suspend animations*/
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if(self.ExtrasView.hidden)
    {
        self.ExtrasView.hidden = NO;
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        CGRect temp = self.mapView.frame;
        temp.size.height -= 208;
        self.mapView.frame = temp;
        [self changeView:self.ExtrasView YoriginWith:-268];
        [self changeView:self.MapTypeButton YoriginWith:-208];
        [self changeView:self.MyPositionButton YoriginWith:-208];
        [UIView commitAnimations];
    }
    else
    {
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        CGRect temp = self.mapView.frame;
        temp.size.height += 208;
        self.mapView.frame = temp;
        [self changeView:self.ExtrasView YoriginWith:268];
        [self changeView:self.MapTypeButton YoriginWith:208];
        [self changeView:self.MyPositionButton YoriginWith:208];
        self.ExtrasView.hidden = YES;
        [UIView commitAnimations];
        
    }
}

- (IBAction)clickedFilterIcon:(id)sender {
    self.CustomerSearchField.text = @"";
    UIButton *button = (UIButton*)sender;
    switch (button.tag) {
        case 1:
            [button setSelected:YES];
            for(UIButton *but in self.OwnView)
            {
                if(but.tag != [sender tag])
                    [but setSelected:NO];
            }
            break;
        case 2:
            [button setSelected:YES];
            for(UIButton *but in self.OwnView)
            {
                if(but.tag != [sender tag])
                    [but setSelected:NO];
            }
            break;
        case 3:
            [button setSelected:YES];
            for(UIButton *but in self.OwnView)
            {
                if(but.tag != [sender tag])
                    [but setSelected:NO];
            }
            break;
        case 4:
            [self setFilterForType:@"Customer" On:button];
            break;
        case 5:
            [self setFilterForType:@"Prospect" On:button];
            
            break;
        case 6:
            [self setFilterForType:@"Competitor" On:button];
            break;
        default:
            if(button.selected)
                button.selected = NO;
            else
                button.selected = YES;
            break;
    }
}

-(void)setFilterForType:(NSString*)type On:(UIButton*)button
{
    if(button.isSelected)
    {
        [button setSelected:NO];
        [visibleTypes removeObject:[NSString stringWithString:type]];
    }
    else
    {
        [button setSelected:YES];
        [visibleTypes addObject:[NSString stringWithString:type]];
    }
    VisibleBusinessPartners = [self filterBupaArray:bupasForLogo];
    [self.CustomerTable reloadData];
    [self annotateVisibleCustomers];
}

-(void)changeView:(UIView*)view YoriginWith:(float)difference
{
    CGRect oldSV = view.frame;
    oldSV.origin.y = oldSV.origin.y + difference;
    view.frame = oldSV;
}

#pragma mark - Prepare Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Details"])
    {
        DetailViewController *dvc = (DetailViewController*)segue.destinationViewController;
        dvc.mvc = self;
        if([sender isKindOfClass:[SuspectAnnotation class]])
        {
            dvc.prospect = (SuspectAnnotation*)sender;
        }
        else if([sender isKindOfClass:[BusinessPartner class]])
        {
            dvc.bupa = sender;
        }
    }
    else if ([segue.identifier isEqualToString:@"CustomerOverview"])
    {
        CustomerViewController *cvc = segue.destinationViewController;
        cvc.selectedBusinessPartner = sender;
        cvc.mvc = self;
        if(cvc.selectedBusinessPartner.ParentID.length !=0)
            cvc.bupaLogo = [hierLogos objectForKey:cvc.selectedBusinessPartner.ParentID];
    }
    else if([segue.identifier isEqualToString:@"goToProducts"])
    {
        ProductCatalogViewController *pcvc = segue.destinationViewController;
        pcvc.mvc = self;
    }
}








@end
