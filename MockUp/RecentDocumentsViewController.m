//
//  RecentDocumentsViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 07-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "RecentDocumentsViewController.h"
#import "RecentDocumentCell.h"
#import "RDItemCell.h"
@interface RecentDocumentsViewController ()

@end

@implementation RecentDocumentsViewController
SalesDocument *selectedDocument;
NSMutableArray *selectedItems;
UIPopoverController *upc;
int docOrder =-1;
int itemOrder =-1;
@synthesize documents;


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
    for(UIView *view in self.ViewCollection)
    {
        [UIView changeLayoutToDefaultProjectSettings:view];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)orderDocsOn:(id)sender {
    NSString *selector;
    int tagNumber = [sender tag];
    switch (tagNumber) {
        case 1:
            selector = @"OrderID";
            break;
        case 2:
            selector = @"OrderType";
            break;
        case 3:
            selector = @"DocumentDate";
            break;
        case 4:
            selector = @"CustomerPurchaseOrderNumber";
            break;
        case 5:
            selector = @"NetValue";
            break;
        default:
            break;
    }
    documents = [self sortArray:documents By:selector andAscending:(tagNumber == docOrder)];
    [self.DocumentTable reloadData];
    (docOrder == tagNumber)?(docOrder =-1 ): (docOrder =tagNumber);
}

- (IBAction)orderItemsOn:(id)sender {
    NSString *selector;
    int tagNumber = [sender tag];
    switch (tagNumber) {
        case 1:
            selector = @"Material";
            break;
        case 2:
            selector = @"Description";
            break;
        case 3:
            selector = @"Quantity";
            break;
        case 4:
            selector = @"UoM";
            break;
        case 5:
            selector = @"NetPrice";
            break;
        case 6:
            selector = @"NetValue";
            break;
        default:
            break;
    }
    selectedDocument.Items = (NSMutableArray*)[self sortArray:selectedDocument.Items By:selector andAscending:(tagNumber == itemOrder)];
    [self.ItemTable reloadData];
    (itemOrder == tagNumber)?(itemOrder =-1 ): (itemOrder =tagNumber);
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -Tableview Datasource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int result = 0;
    if(tableView.tag ==1)
    {
        if(documents)
            result = documents.count;
        tableView.hidden = (result==0);
    }
    else if(tableView.tag==2)
    {
        if(selectedDocument && selectedDocument.Items.count >0)
            result =  selectedDocument.Items.count;
        
        for(UIView *view in self.ItemViews)
        {
            view.hidden = (result == 0);
        }
    }
    return result;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag ==1)
    {
        NSString *cellIdentifier = @"RD";
        RecentDocumentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
            cell = [[RecentDocumentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier andSalesDocument:documents[indexPath.row]];
        else
            [cell setDocument:documents[indexPath.row]];
        return cell;
    }
    else
    {
        NSString *cellIdentifier = @"RDI";
        RDItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
            cell = [[RDItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setDocItem:selectedDocument.Items[indexPath.row]];
        return cell;
    }
}

#pragma mark - TableView
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 1)
    {
        if(self.OrderCopyBtn.hidden)
            self.OrderCopyBtn.hidden = NO;
        selectedDocument = documents[indexPath.row];
        if(selectedDocument.Items.count ==0)
        {
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(itemsLoaded:) name:kLoadSalesDocumentItemsCompletedNotification object:nil];
            [[RequestHandler uniqueInstance]loadSalesDocumentItems:selectedDocument];
        }
        else
            [self.ItemTable reloadData];
    }
    else if(tableView.tag ==2)
    {
        if(self.ItemCopyBtn.hidden)
            self.ItemCopyBtn.hidden = NO;
    }
    else if(tableView.tag ==3)
    {
        [upc dismissPopoverAnimated:YES];
        if(indexPath.row == 2 && !([selectedDocument.OrderType isEqualToString:@"ORDER"]))
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Not Possible!" message:@"Returns can only be created based upon orders!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            NSString *action;
            switch (indexPath.row) {
                case 0:
                    action = @"QUOTATION";
                    break;
                case 1:
                    action = @"ORDER";
                    break;
                case 2:
                    action = @"RETURN_ORDER";
                    break;
                default:
                    break;
            }
            [self addItemsToDocument:selectedItems withAction:action ];
        }
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag ==2 && (self.ItemTable.indexPathsForSelectedRows.count == 0))
        self.ItemCopyBtn.hidden = YES;
}


-(void)itemsLoaded:(NSNotification*)notification
{
    if(![notification.userInfo objectForKey:kResponseError])
    {
        selectedDocument.Items = [notification.userInfo objectForKey:kResponseItems];
        [self.ItemTable reloadData];
    }
    
}
//- (IBAction)copyOrder:(id)sender {
//    [self addItemsToDocument:selectedDocument.Items];
//}
//
//- (IBAction)copyItems:(id)sender {
//    NSMutableArray *temp = [NSMutableArray array];
//    for(NSIndexPath *path in self.ItemTable.indexPathsForSelectedRows)
//    {
//        [temp addObject:selectedDocument.Items[path.row]];
//    }
//    [self addItemsToDocument:temp];
//}

-(void)addItemsToDocument:(NSArray*)items withAction:(NSString*)action
{
    for(SalesDocItem *item in items)
    {
        //Create a temp material object to transfer some properties
        Material *temp = [[Material alloc]init];
        temp.MaterialNumber = item.Material;
        temp.Description = item.Description;
        temp.UoM = item.UoM;
        temp.Price = item.NetPrice;
        [self.dvc addItemWithQuantity:item.Quantity.integerValue andMaterial:temp andAction:action andPrice:item.NetPrice];
    }
    [self.dvc.ItemsTable reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    selectedItems = [NSMutableArray array];
    UITableViewController *utvc = segue.destinationViewController;
    UIStoryboardPopoverSegue *pop = (UIStoryboardPopoverSegue*)segue;
    upc  = pop.popoverController;
    utvc.tableView.delegate = self;
    if([segue.identifier isEqualToString:@"addOrder"])
    {
        selectedItems = selectedDocument.Items;
    }
    else if([segue.identifier isEqualToString:@"addItems"])
    {
        for(NSIndexPath *path in self.ItemTable.indexPathsForSelectedRows)
        {
            [selectedItems addObject:selectedDocument.Items[path.row]];
        }
    }
}

-(NSArray*)sortArray:(NSArray*)oldArray By:(NSString*)attribute andAscending:(BOOL)ascend
{
    NSMutableArray* oldSortedItems = [NSMutableArray arrayWithArray:oldArray];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:attribute ascending:ascend];
    return  [oldSortedItems sortedArrayUsingDescriptors:[NSMutableArray arrayWithObject:sortDescriptor]];
}

@end
