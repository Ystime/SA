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

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -Tableview Datasource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag ==1)
    {
        if(documents)
            return documents.count;
    }
    else if(tableView.tag==2)
    {
        if(selectedDocument)
            if(selectedDocument.Items.count >0)
                return selectedDocument.Items.count;
    }
    return 0;
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
    else
    {
        if(self.ItemCopyBtn.hidden)
            self.ItemCopyBtn.hidden = NO;
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
- (IBAction)copyOrder:(id)sender {
    [self addItemsToDocument:selectedDocument.Items];
}

- (IBAction)copyItems:(id)sender {
    NSMutableArray *temp = [NSMutableArray array];
    for(NSIndexPath *path in self.ItemTable.indexPathsForSelectedRows)
    {
        [temp addObject:selectedDocument.Items[path.row]];
    }
    [self addItemsToDocument:temp];
}

-(void)addItemsToDocument:(NSArray*)items
{
    for(SalesDocItem *item in items)
    {
        //Create a temp material object to transfer some properties
        Material *temp = [[Material alloc]init];
        temp.MaterialNumber = item.Material;
        temp.Description = item.Description;
        temp.UoM = item.UoM;
        temp.Price = item.NetPrice;
        
        [self.dvc addItemWithQuantity:item.Quantity.integerValue andMaterial:temp andAction:selectedDocument.OrderType];
    }
    [self.dvc.ItemsTable reloadData];
}
@end
