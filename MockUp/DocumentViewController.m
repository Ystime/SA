//
//  NewDocumentViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 31-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "DocumentViewController.h"
#import "CustomerViewController.h"
#import "HeaderViewController.h"
#import "RecentDocumentsViewController.h"
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
        tempSalesDocument.NetValue = [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    self.ShipToLabel.text = cvc.selectedBusinessPartner.BusinessPartnerName;
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
#pragma mark - Add Item 
- (void)addItemWithQuantity:(int)quant andMaterial:(Material*)material andAction:(NSString*)docAction andPrice:(NSDecimalNumber*)price
{
    SalesDocItem *item = [[SalesDocItem alloc]init];
    item.Quantity = [NSNumber numberWithInt:quant];
    item.Material = material.MaterialNumber;
    item.Description = material.Description;
    item.UoM = material.UoM;
    item.ItemNumber = docAction;
    item.OrderID = item.Plant = item.Status.Delivery_Status = item.Status.Overall_Status = item.Status.Invoice_Status = @" ";
    item.NetPrice = price;
    float totalValue = item.Quantity.floatValue * item.NetPrice.floatValue;
    item.NetValue = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f",totalValue]];
    [tempSalesDocument.Items addObject:item];
    
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
                [self performSegueWithIdentifier:@"recentDocuments" sender:self];
                break;
            case 2:
            {
                ZBarReaderViewController *reader = [ZBarReaderViewController new];
                reader.readerDelegate = self;
                [self presentViewController:reader animated:YES completion:^{}];
                
            }
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
        if(!(sender ==nil))
        {
            MaterialInfoViewController *mivc = segue.destinationViewController;
            mivc.material = sender;
        }
    }
    
    else if([segue.identifier isEqualToString:@"recentDocuments"])
    {
        RecentDocumentsViewController *rdvc = segue.destinationViewController;
        rdvc.dvc = self;
        rdvc.documents = cvc.SalesDocuments;
    }
}

- (IBAction)saveDocs:(id)sender {
    //Check if all items have actions assigned
    for(SalesDocItem *item in tempSalesDocument.Items)
    {
        if(item.ItemNumber==nil)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Incomplete Data" message:@"Some items are missing an action!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
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
        cvc.creatingDoc = NO;
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
    if(self.changeMode)
    {
        for(SalesDocItem *tempItem in tempSalesDocument.Items)
        {
            tempItem.ItemNumber = tempSalesDocument.OrderType;
        }
    }
    [self.ItemsTable reloadData];
}


#pragma mark - ZBar Delegate

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    Material *temp = [self getBarcode:symbol.data];
    if(temp == nil)
    {
        LGViewHUD *hud = [[LGViewHUD alloc] initWithFrame:CGRectMake(0, 0, 160, 160)];
        hud.topText =[NSString stringWithFormat:@"Barcode:%@",symbol.data];
        hud.bottomText = @"Unknown!";
        hud.image = [UIImage imageNamed:@"unknown.png"];
        [hud showInView:reader.view];
    }
    else
    {
        SalesDocItem *tempItem = [[SalesDocItem alloc]init];
        tempItem.Material = temp.MaterialNumber;
        tempItem.Quantity = [NSNumber numberWithFloat:1.0];
        tempItem.UoM = temp.UoM;
        tempItem.Description = temp.Description;
        tempItem.ItemNumber = tempItem.OrderID = tempItem.Plant = tempItem.Status.Delivery_Status = tempItem.Status.Overall_Status = tempItem.Status.Invoice_Status = @" ";
        tempItem.NetPrice = tempItem.NetValue = [NSDecimalNumber decimalNumberWithString:@"1"];
        [tempSalesDocument.Items addObject:tempItem];
        [self.ItemsTable reloadData];
        [self dismissViewControllerAnimated:YES completion:^
         {
             [self.ItemsTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:tempSalesDocument.Items.count-1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
             [self performSegueWithIdentifier:@"editItem" sender:nil];
         }];
    }
}

#pragma mark - Query for specific Material

-(Material*)getBarcode:(NSString*)barcode
{
    NSLog(@"Scanned Barcode:%@",barcode);
    Material *result = nil;
    for(Material* temp in cvc.materials)
    {
        if([temp.EANCode isEqualToString:barcode])
            result = temp;
    }
    return result;
}

@end
