//
//  ProductViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 07-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "ProductViewController.h"
#import "CustomerViewController.h"
@interface ProductViewController ()

@end

@implementation ProductViewController
NSMutableArray *materials;
@synthesize pop,tappedIndexPath;
LGViewHUD *loadingMaterials;
CustomerViewController *cvc;
BOOL imageAvailable;
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
    cvc = (CustomerViewController*)self.navigationController.parentViewController;
    materials = cvc.materials;
    loadingMaterials = [[LGViewHUD alloc]initWithFrame:CGRectMake(0,0, 150, 150)];
    loadingMaterials.activityIndicatorOn = YES;
    loadingMaterials.topText = @"Loading Materials";
    loadingMaterials.bottomText= @"Please Wait!";
    imageAvailable = NO;

}

-(void)viewWillAppear:(BOOL)animated
{
    [self setVisibilityTable:NO];
    [self.ViewButton setTitle:@"List" forState:UIControlStateNormal];
    if(!materials)
    {
        [loadingMaterials showInView:self.view];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(materialsLoaded:) name:kMaterialsProcesssed object:nil];
    }
    else
    {
        [self.MaterialCollection reloadData];
        [self.MaterialTable reloadData];
    }
    if(cvc.materialPictures)
        imageAvailable = YES;
    else
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imagesProcessed) name:kMaterialPicuresProcesssed object:nil];
        
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)switchView:(id)sender {
    UIButton *button = (UIButton*)sender;
    if([button.titleLabel.text isEqualToString:@"List"])
    {
        [button setTitle:@"Collection" forState:UIControlStateNormal];
        [self setVisibilityTable:YES];
        [self.MaterialTable reloadData];
    }
    else
    {
        [button setTitle:@"List" forState:UIControlStateNormal];
        [self setVisibilityTable:NO];
        [self.MaterialCollection reloadData];

    }
    
}

#pragma mark - Collection View Datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return materials.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"MaterialCollCell";
    MaterialCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    Material *mat = materials[indexPath.row];
    if(cell == nil)
    {
        cell = [[MaterialCollectionCell alloc]initWithMaterial:mat];
    }
    else
    {
        [cell setMaterial:mat];
    }
    if(imageAvailable)
        cell.MaterialImage.image = [cvc.materialPictures objectForKey:mat.MaterialNumber];
    return cell;
}
#pragma mark - Collection View Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"MaterialInfo" sender:materials[indexPath.row]];
}

#pragma mark - Table View Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return materials.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"MaterialCell";
    MaterialCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    Material *mat = materials[indexPath.row];

    if(cell == nil)
    {
        cell = [[MaterialCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID withMaterial:mat];
    }
    else
    {
        [cell setMaterial:mat];
    }
    if(imageAvailable)
        cell.MaterialImage.image = [cvc.materialPictures objectForKey:mat.MaterialNumber];

    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    tappedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"MaterialInfo" sender:materials[indexPath.row]];
}

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"MaterialInfo"])
    {
        MaterialInfoViewController *mivc = segue.destinationViewController;
        mivc.material = (Material*)sender;
        mivc.materials = cvc.materials;
        mivc.matPics = cvc.materialPictures;
    }
}


#pragma mark - Other Functions

-(void)setVisibilityTable:(BOOL)visible
{
    for(UILabel *label in self.TableLabels)
    {
        [label setHidden:!visible];
    }
    [self.MaterialTable setHidden:!visible];
    [self.MaterialCollection setHidden:visible];
}

-(void)materialsLoaded:(NSNotification*)notification
{
    [loadingMaterials hideWithAnimation:HUDAnimationNone];
//    materials = [notification.userInfo objectForKey:kResponseItems];
    materials = cvc.materials;
    if(materials.count == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No Materials" message:@"No materials were retrieved!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        [self.MaterialTable reloadData];
        [self.MaterialCollection reloadData];
    }
}

- (void)addItemWithQuantity:(int)quant andMaterial:(Material*)material andAction:(NSString*)docAction
{
    SalesDocItem *item = [[SalesDocItem alloc]init];
    item.Quantity = [NSNumber numberWithInt:quant];
    item.Material = material.MaterialNumber;
    item.Description = material.Description;
    item.UoM = material.UoM;
    item.ItemNumber = docAction;
    item.OrderID = item.Plant = item.Status.Delivery_Status = item.Status.Overall_Status = item.Status.Invoice_Status = @" ";
    item.NetPrice = item.NetValue = [NSDecimalNumber decimalNumberWithString:@"1"];
    DocumentViewController *ndvc = (DocumentViewController*)self. navigationController.viewControllers[0];
    
    [ndvc.tempSalesDocument.Items addObject:item];
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    [ndvc.ItemsTable reloadData];
}

-(void)imagesProcessed
{
    imageAvailable = YES;
    [self.MaterialTable reloadData];
    [self.MaterialCollection reloadData];
}
@end
