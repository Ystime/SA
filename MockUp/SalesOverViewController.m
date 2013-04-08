//
//  SalesOverViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 22-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "SalesOverViewController.h"
#import "AlertTable.h"
@interface SalesOverViewController ()

@end

@implementation SalesOverViewController
BusinessPartner *selectedBUPA;
NSMutableArray *salesDocuments;
NSMutableArray *allSDs;
NSMutableArray *selectedSDItems;
LGViewHUD *loadingItems;
int lastSortedSD;
int lastSortedItem;
int selectedRow;
@synthesize pop,FilterPullView,cvc;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    for(UIView *tempView in self.ViewCollection)
    {
        tempView.layer.cornerRadius = 8.0;
        tempView.layer.masksToBounds = YES;
    }
    loadingItems = [[LGViewHUD alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    loadingItems.activityIndicatorOn = YES;
    loadingItems.topText = @"Loading";
    loadingItems.bottomText = @"Items...";
    cvc = (CustomerViewController*)self.parentViewController;
    selectedBUPA = cvc.selectedBusinessPartner;
    [self.AlertTable performSelectorInBackground:@selector(loadAlertsForBusinessPartner:) withObject:selectedBUPA];
    [self.DocumentTable addPullToRefreshWithActionHandler:^{
        [_NothingLabel setText:@"Loading Sales Documents, please wait...." ];
        allSDs = salesDocuments = selectedSDItems =   nil;
        [self.ItemTable reloadData];
        [self.DocumentTable reloadData];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getSalesDocs) name:kCVCLoadedDocs object:nil];
        [[RequestHandler uniqueInstance]loadSalesDocuments:selectedBUPA.SalesDocumentsQuery];
        [self.DocumentTable.pullToRefreshView stopAnimating];
    }];
    [self setUpPullUp];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.DocumentTable reloadData];
    salesDocuments = [[NSMutableArray alloc]init];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getSalesDocs) name:kCVCLoadedDocs object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(salesDocumentItemsLoaded:) name:kLoadSalesDocumentItemsCompletedNotification object:nil];
    [self performSelectorInBackground:@selector(getSalesDocs) withObject:nil];
    
    lastSortedSD = -1;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    salesDocuments = selectedSDItems =nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDocumentTable:nil];
    [self setItemTable:nil];
    [self setViewCollection:nil];
    [self setDocumentView:nil];
    [self setItemView:nil];
    [self setNothingLabel:nil];
    salesDocuments = selectedSDItems =nil;
    selectedBUPA = nil;
    [self setItemButtons:nil];
    [self setStatusButtons:nil];
    [self setTypeButtons:nil];
    [super viewDidUnload];
}


#pragma mark - Sales Document functions

-(void)salesDocumentsLoaded
{
    lastSortedSD = -1;
    for(UIButton* button in self.TypeButtons)
    {
        switch (button.tag) {
            case 1:
                [self orderType:@"QUOTATION" visible:button.selected];
                break;
            case 2:
                [self orderType:@"ORDER" visible:button.selected];
                break;
            case 3:
                [self orderType:@"RETURN_ORDER" visible:button.selected];
                break;
            default:
                break;
        }
        selectedSDItems = nil;
        [self.ItemTable reloadData];
    }
    self.NothingLabel.text = @"This Customer has no Sales Documents (for these filters)";
    [self.DocumentTable reloadData];
}

-(void)getSalesDocs
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kCVCLoadedDocs object:nil];
    allSDs = cvc.SalesDocuments;
    salesDocuments = [[NSMutableArray alloc]init];
    [self performSelectorOnMainThread:@selector(salesDocumentsLoaded) withObject:nil waitUntilDone:NO];
}



-(void)salesDocumentItemsLoaded:(NSNotification*)notification
{
    NSDictionary *userInfoDict = [notification userInfo];
    selectedSDItems = [userInfoDict objectForKey:kResponseItems];
    
    /*Check wether view has to be changed*/
    
    [loadingItems hideWithAnimation:HUDAnimationNone];
    lastSortedItem = -1;
    [self.ItemTable reloadData];
}


#pragma mark - TableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 1)
    {
        if(salesDocuments.count >0)
        {
            self.DocumentView.hidden = NO;
            self.NothingLabel.hidden = YES;
        }
        else
        {
            selectedSDItems = nil;
            [self.ItemTable reloadData];
            self.DocumentView.hidden = NO;
            self.NothingLabel.hidden = NO;
        }
        return salesDocuments.count+1;
    }
    else if(tableView.tag == 2)
    {
        if(selectedSDItems.count >0)
        {
            if(self.ItemView.hidden)
                [self showItemTable];
        }
        else
        {
            if(self.ItemView.hidden == NO)
                [self hideItemTable];
        }
        
        return selectedSDItems.count;
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 1)
    {
        if(indexPath.row < salesDocuments.count)
        {
            SalesHeaderCell *cell;
            cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
            if(cell)
                [cell changeSalesDocument:[salesDocuments objectAtIndex:indexPath.row]];
            else
                cell = [[SalesHeaderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HeaderCell" andSalesDocument:[salesDocuments objectAtIndex:indexPath.row]];
            return cell;
        }
        else
        {
            UITableViewCell *cell;
            cell = [tableView dequeueReusableCellWithIdentifier:@"addDocCell"];
            if(!cell)
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addDocCell"];
            return cell;
        }
    }
    else if(tableView.tag == 2)
    {
        SalesItemCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
        if(cell)
            [cell changeItem:[selectedSDItems objectAtIndex:indexPath.row]];
        else
            cell = [[SalesItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ItemCell" andSalesItem:[selectedSDItems objectAtIndex:indexPath.row]];
        return cell;
    }
    else return nil;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 1)
    {
        if(indexPath.row < salesDocuments.count)
        {
            if((indexPath.row+1 < salesDocuments.count) && self.ItemView.hidden)
                [self.DocumentTable scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
            if(self.ItemView.hidden)
                [loadingItems showInView:self.DocumentView];
            else
                [loadingItems showInView:self.ItemView];
            SalesDocument *selectedSD = [salesDocuments objectAtIndex:indexPath.row];
            [[RequestHandler uniqueInstance]loadSalesDocumentItems:selectedSD];
        }
        else
        {
            [cvc showDocumentViewWithSalesDocument:nil];
        }
    }
    else if (tableView.tag == 2)
    {
        [self performSegueWithIdentifier:@"itemDetail" sender:self];
    }
    
    
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 1)
    {
        if(indexPath.row < salesDocuments.count)
            [cvc showDocumentViewWithSalesDocument:salesDocuments[indexPath.row]];
    }
}


-(void)changeLengthOfView:(UIView*)view withY:(float)y
{
    CGRect temp =view.frame;
    temp.size.height = temp.size.height+y;
    view.frame = temp;
}

-(void)showItemTable
{
    /*Suspend animations*/
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    /*Shorten Document View*/
    [self changeLengthOfView:self.DocumentView withY:-330.0];
    
    /*Move up the Items view*/
    self.ItemView.hidden = NO;
    CGRect old = self.ItemView.frame;
    old.origin.y = old.origin.y-323;
    self.ItemView.frame = old;
    
    /*Commit animations*/
    [UIView commitAnimations];
}

-(void)hideItemTable
{
    /*Suspend animations*/
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    /*Shorten Document View*/
    [self changeLengthOfView:self.DocumentView withY:+330.0];
    
    /*Move down the Items view*/
    self.ItemView.hidden = YES;
    CGRect old = self.ItemView.frame;
    old.origin.y = old.origin.y+323;
    self.ItemView.frame = old;
    
    /*Commit animations*/
    [UIView commitAnimations];
}

#pragma mark - Prepare segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"itemDetail"]) {
        ItemViewController *ivc = (ItemViewController*)segue.destinationViewController;
        SalesDocItem *item = [selectedSDItems objectAtIndex:self.ItemTable.indexPathForSelectedRow.row];
        if(cvc.materialPictures)
            [ivc setItem:item andImage:[cvc.materialPictures objectForKey:item.Material]];
        else
            [ivc setItem:item andImage:nil];
    }
}

#pragma mark - Pull Up Actions

-(void)setUpPullUp
{
    [FilterPullView setupPullableView:FilterPullView.frame];
    FilterPullView.openedCenter = CGPointMake(894,137);
    FilterPullView.closedCenter = CGPointMake(1044,137);
    FilterPullView.center = FilterPullView.closedCenter;
    FilterPullView.handleView.frame = self.FilterHandle.frame;
    FilterPullView.delegate = self;
    for(UIView *view in self.PullableSubViews)
    {
        view.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        view.layer.borderWidth = 2.0;
    }
}

#pragma mark - Button actions

- (IBAction)orderDocuments:(id)sender {
    BOOL ascending;
    if([sender tag] == lastSortedSD)
    {
        ascending = NO;
        lastSortedSD = -1;
    }
    else
    {
        ascending = YES;
        lastSortedSD = [sender tag];
    }
    
    switch ([sender tag]) {
        case 1:
            [self sortingOrders:@"CustomerPurchaseOrderNumber" ascending:ascending];
            break;
        case 2:
            [self sortingOrders:@"RequestedDeliveryDate" ascending:ascending];
            break;
        case 3:
            [self sortingOrders:@"OrderType" ascending:ascending];
            break;
        case 4:
            [self sortingOrders:@"NetValue" ascending:ascending];
            break;
        case 5:
            [self sortingOrders:@"" ascending:ascending];
            break;
        case 6:
            [self sortingOrders:@"" ascending:ascending];
            break;
        default:
            break;
    }
    
    
}

- (IBAction)orderItems:(id)sender {
    BOOL ascending;
    if([sender tag] == lastSortedItem)
    {
        ascending = NO;
        lastSortedItem = -1;
    }
    else
    {
        ascending = YES;
        lastSortedItem = [sender tag];
    }
    switch ([sender tag]) {
        case 1:
            [self sortingItems:@"Material" ascending:ascending];
            break;
        case 2:
            [self sortingItems:@"Description" ascending:ascending];
            break;
        case 3:
            [self sortingItems:@"Quantity" ascending:ascending];
            break;
        case 4:
            [self sortingItems:@"UoM" ascending:ascending];
            break;
        case 5:
            [self sortingItems:@"NetValue" ascending:ascending];
            break;
        default:
            break;
    }
    
}

- (IBAction)changeStatus:(id)sender {
    for(UIButton *button in self.StatusButtons)
    {
        if([sender tag]!=button.tag)
            button.selected = NO;
        else
        {
            if(!button.selected)
            {
                button.selected = YES;
                /*Filter the list of documents on the tag, 1= open,2 =all;*/
            }
        }
    }
    
}

- (IBAction)filterOnType:(id)sender {
    UIButton *button = (UIButton*)sender;
    if(button.selected)
        button.selected = NO;
    else
        button.selected = YES;
    switch (button.tag) {
        case 1:
            [self orderType:@"QUOTATION" visible:button.selected];
            break;
        case 2:
            [self orderType:@"ORDER" visible:button.selected];
            break;
        case 3:
            [self orderType:@"RETURN_ORDER" visible:button.selected];
            break;
        default:
            break;
    }
    selectedSDItems = nil;
    [self.ItemTable reloadData];
}

-(void)orderType:(NSString*)type visible:(BOOL)vis
{
    if(vis)
    {
        for(SalesDocument *sd in allSDs)
        {
            if([sd.OrderType isEqualToString:type])
                [salesDocuments addObject:sd];
        }
    }
    else
    {
        NSMutableArray *temp = [NSMutableArray arrayWithArray:salesDocuments];
        for(SalesDocument *sd in temp)
            if ([sd.OrderType isEqualToString:type]) {
                [salesDocuments removeObject:sd];
            }
    }
    
    [self.DocumentTable reloadData];
}

-(void)sortingOrders:(NSString*)attribute ascending:(BOOL)ascend
{
    SalesDocument *sd = [salesDocuments objectAtIndex:self.DocumentTable.indexPathForSelectedRow.row];
    NSMutableArray* oldSortedOrders = [NSMutableArray arrayWithArray:salesDocuments];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:attribute ascending:ascend];
    salesDocuments= [NSMutableArray arrayWithArray:[oldSortedOrders sortedArrayUsingDescriptors:[NSMutableArray arrayWithObject:sortDescriptor]]];
    [self.DocumentTable reloadData];
    NSIndexPath *path;
    for(int i = 0;i<salesDocuments.count;i++)
    {
        SalesDocument *temp = [salesDocuments objectAtIndex:i];
        if([temp.OrderID isEqualToString:sd.OrderID])
            path = [NSIndexPath indexPathForRow:i inSection:0];
    }
    if(path && (!self.ItemView.hidden))
    {
        [self.DocumentTable selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
}

-(void)sortingItems:(NSString*)attribute ascending:(BOOL)ascend
{
    NSMutableArray* oldSortedItems = [NSMutableArray arrayWithArray:selectedSDItems];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:attribute ascending:ascend];
    selectedSDItems= (NSMutableArray*)[oldSortedItems sortedArrayUsingDescriptors:[NSMutableArray arrayWithObject:sortDescriptor]];
    [self.ItemTable reloadData];
}


-(void)pullableView:(PullableView *)pView didChangeState:(BOOL)opened
{
    
}
@end
