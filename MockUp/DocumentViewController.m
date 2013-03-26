//
//  NewDocumentViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 31-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "DocumentViewController.h"
#import "CustomerViewController.h"
@interface DocumentViewController ()
@end

@implementation DocumentViewController
@synthesize tempSalesDocument,pop,cvc;
AddPopover *addPopover;
UIPopoverController *upc;
ItemViewController *ivc;
BOOL rowSelected;
LGViewHUD *creatingDocs;



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
    for(UIView *view in _ViewCollection)
    {
        [UIView changeLayoutToDefaultProjectSettings:view];
    }
    cvc = (CustomerViewController*)self.navigationController.parentViewController;
    rowSelected = NO;
    creatingDocs = [[LGViewHUD alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    creatingDocs.activityIndicatorOn = YES;
    creatingDocs.topText = @"Creating Documents";
    creatingDocs.bottomText = @"Please wait!";
}

-(void)viewWillAppear:(BOOL)animated
{
    if(!tempSalesDocument)
    {
        tempSalesDocument = [[SalesDocument alloc]init];
        tempSalesDocument.Items = [[NSMutableArray alloc]init];
        tempSalesDocument.CustomerID = cvc.selectedBusinessPartner.BusinessPartnerID;
        tempSalesDocument.SalesOrganization = @"1000";
        tempSalesDocument.Division = @"10";
        tempSalesDocument.DistributionChannel = @"10";
        tempSalesDocument.OrderID = @" ";
        tempSalesDocument.Currency = @"EUR";
        tempSalesDocument.DocumentDate = [NSDate date];
        tempSalesDocument.NetValue = [NSDecimalNumber decimalNumberWithString:@"1"];
    }
    [self setHeaderLabelView];
    [self.ItemsTable reloadData];
    if(tempSalesDocument.RequestedDeliveryDate==nil)
    {
        [self performSegueWithIdentifier:@"showHeaderView" sender:self];
    }
    if(self.changeMode)
    {
        [self.AddButton setHidden:YES];
        self.SaveButton.hidden = YES;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadingItemsCompleted:) name:kLoadSalesDocumentItemsCompletedNotification object:nil];
        [[RequestHandler uniqueInstance]loadSalesDocumentItems:tempSalesDocument];
    }
    else
    {
        [self.AddButton setHidden:NO];
        self.SaveButton.hidden = NO;
    }
}

-(void)viewDidAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    for(UIView *view in self.ItemActionButtons)
    {
        view.hidden = YES;
    }
    return tempSalesDocument.Items.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 1)
    {
        SalesItemCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
        if(cell)
            [cell changeItem:[tempSalesDocument.Items objectAtIndex:indexPath.row]];
        else
            cell = [[SalesItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ItemCell" andSalesItem:[tempSalesDocument.Items  objectAtIndex:indexPath.row]];
        return cell;
    }
    else
        return nil;
}

#pragma mark - TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 1)
    {
        //        if(self.ItemInfoView.hidden)
        //        {
        //            for(UIButton *button in self.ItemActionButtons)
        //            {
        //                [button setHidden:NO];
        //            }
        //            self.ItemInfoView.hidden = NO;
        //        }
        //        [ivc setItem:tempSalesDocument.Items[indexPath.row]];
        for(UIButton *button in self.ItemActionButtons)
        {
            [button setHidden:NO];
        }
    }
    
    else if(tableView.tag == 2)
    {
        switch (indexPath.row) {
            case 0:
                [self performSegueWithIdentifier:@"productCatalog" sender:self];
                break;
            case 1:
                [self performSegueWithIdentifier:@"recentDocs" sender:self];
                break;
            case 2:
                break;
            default:
                break;
        }
        [upc dismissPopoverAnimated:YES];
    }
}
#pragma mark - Preparing Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddPopover"])
    {
        upc = [(UIStoryboardPopoverSegue *)segue popoverController];
        addPopover = segue.destinationViewController;
        addPopover.tableView.delegate = self;
    }
    else if([segue.identifier isEqualToString:@"ItemInfo"])
    {
        ivc = (ItemViewController*)segue.destinationViewController;
    }
    else if([segue.identifier isEqualToString:@"showHeaderView"])
    {
        HeaderViewController *hvc = (HeaderViewController*)segue.destinationViewController;
        hvc.sd = tempSalesDocument;
        [hvc setNDVC:self];
    }
    else if([segue.identifier isEqualToString:@"editItem"])
    {
        
    }
}

- (IBAction)saveDocs:(id)sender {
    [creatingDocs performSelectorOnMainThread:@selector(showInView:) withObject:self.view waitUntilDone:YES];
    [self performSelectorInBackground:@selector(tryingToSaveDocuments) withObject:nil];
}

-(void)tryingToSaveDocuments
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for(SalesDocItem *item in tempSalesDocument.Items)
    {
        NSMutableArray *actionItem = [dic objectForKey:item.ItemNumber];
        if(actionItem == nil)
            actionItem = [NSMutableArray arrayWithObject:item];
        else
            [actionItem addObject:item];
        [dic setObject:actionItem forKey:[NSString stringWithString:item.ItemNumber]];
    }
    NSArray *allkeys = [dic allKeys];
    
    BOOL allSuccess = YES;
    
    for(NSString *key in allkeys)
    {
        NSMutableArray *temp = [dic objectForKey:key];
        tempSalesDocument.Items = temp;
        for(int i =0;i<tempSalesDocument.Items.count;i++)
        {
            SalesDocItem *tempItem = tempSalesDocument.Items[i];
            tempItem.ItemNumber = [NSString stringWithFormat:@"%i",(i+1)*10];
        }
        tempSalesDocument.OrderType = key;
        tempSalesDocument.Description = key;
        if([[RequestHandler uniqueInstance]createSalesDocument:tempSalesDocument])
        {
            
        }
        else
        {
            allSuccess = NO;
        }
    }
    [creatingDocs hideWithAnimation:YES];
    if(allSuccess)
    {
        [[RequestHandler uniqueInstance]loadSalesDocuments:cvc.selectedBusinessPartner.SalesDocumentsQuery];
        UIButton *temp = [[UIButton alloc]init];
        temp.tag = 2;
        [cvc performSelectorOnMainThread:@selector(clickedTab:) withObject:temp waitUntilDone:NO];
    }
    
}

- (IBAction)changeItem:(id)sender {
    switch ([sender tag]) {
        case 2:
            [self performSegueWithIdentifier:@"editItem" sender:self.tempSalesDocument.Items[self.ItemsTable.indexPathForSelectedRow.row]];
            break;
        case 3:
            [tempSalesDocument.Items removeObjectAtIndex:self.ItemsTable.indexPathForSelectedRow.row];
            [self.ItemsTable reloadData];
            for(UIButton *button in self.ItemActionButtons)
            {
                [button setHidden:YES];
            }
            break;
            
        default:
            break;
    }
}


-(void)setHeaderLabelView
{
    for(UILabel *label in self.HeaderLabel)
    {
        switch (label.tag) {
            case 1:
                label.text = cvc.selectedBusinessPartner.BusinessPartnerName;
                break;
            case 2:
                label.text = [GlobalFunctions getStringFormat:@"dd-MM-yyyy" FromDate:tempSalesDocument.RequestedDeliveryDate];
                break;
            case 3:
                label.text = tempSalesDocument.CustomerPurchaseOrderNumber;
                break;
            case 4:
            {
                NSDate *temp = tempSalesDocument.DocumentDate;
                if(temp == nil)
                    temp = [NSDate date];
                if(tempSalesDocument.DocumentDate)
                    label.text = [GlobalFunctions getStringFormat:@"dd-MM-yyyy" FromDate:temp];
            }
                break;
            default:
                break;
        }
    }
}

-(void)loadingItemsCompleted:(NSNotification*)notification
{
    NSMutableArray *temp = [notification.userInfo objectForKey:kResponseItems];
    tempSalesDocument.Items = temp;
    [self.ItemsTable reloadData];
    
}
@end
