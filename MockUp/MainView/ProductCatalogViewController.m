//
//  ProductCatalogViewController.m
//  Sales Around
//
//  Created by IJsbrand van Rijn on 17-04-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "ProductCatalogViewController.h"
#import "MaterialInfoViewController.h"

@interface ProductCatalogViewController ()

@end

NSDictionary *materialPics;
NSArray *mpKeys;
NSArray *allKeys;
NSArray *materialGroups;
BOOL visible;
@implementation ProductCatalogViewController

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
    for(UIView *view in self.Views)
        [UIView changeLayoutToDefaultProjectSettings:view];
    self.view.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.view.layer.borderWidth = 1.0;
//    UIViewController *vc = self.tabBarController.viewControllers[1];
//    vc.view;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    visible = YES;
    [self.loadingPicIV startAnimating];
    [self performSelectorInBackground:@selector(getMaterialGroups) withObject:nil];
    
    [self performSelectorInBackground:@selector(getMaterialPics) withObject:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    visible = NO;
}

#pragma mark - Collection View Datasource & Delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return mpKeys.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"productCell";
    MaterialCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if(!cell)
        cell = [[MaterialCollectionCell alloc]init];
    cell.MaterialImage.image = [materialPics objectForKey:mpKeys[indexPath.row]];
    for(Material *temp in self.mvc.Materials)
    {
        if([temp.MaterialNumber isEqualToString:mpKeys[indexPath.row]])
        {
            cell.MaterialName.text = temp.Description;
            break;
        }
        
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Material *temp;
    for(Material *mat in self.mvc.Materials)
    {
        if([mat.MaterialNumber isEqualToString:mpKeys[indexPath.row]])
        {
            temp = mat;
            break;
        }
    }
    if(temp)
        [self performSegueWithIdentifier:@"infoProduct" sender:temp];
}
#pragma mark - Picker View delegate & datasource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return materialGroups.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    MaterialGroup *mg = materialGroups[row];
    return mg.Description;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(row == 0)
        mpKeys = allKeys;
    else
    {
        NSMutableArray *temp = [NSMutableArray array];
        MaterialGroup *mg = materialGroups[row];
        for(Material* mat in mg.MaterialSet)
        {
            [temp addObject:mat.MaterialNumber];
        }
        mpKeys = [NSArray arrayWithArray:temp];
    }
    [self.MaterialCollectionView reloadData];
}

#pragma mark - Button actions
- (IBAction)closeCatalog:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"infoProduct"])
    {
        MaterialInfoViewController *mivc = segue.destinationViewController;
        mivc.material = sender;
        
    }
}
#pragma mark - Listeners

-(void)getMaterialGroups
{
    while(!self.mvc.MaterialGroups&& visible){};
    if(!visible)
        return;
    materialGroups = self.mvc.MaterialGroups;
    [self.GroupPicker performSelectorOnMainThread:@selector(reloadAllComponents) withObject:nil waitUntilDone:NO];
}

-(void)getMaterialPics
{
    while(!self.mvc.MaterialPictures && visible){};
    [self.loadingPicIV stopAnimating];
    if(!visible)
        return;
    materialPics = self.mvc.MaterialPictures;
    allKeys = mpKeys = [materialPics.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self.MaterialCollectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    [self.GroupPicker selectRow:0 inComponent:0 animated:NO];
}
@end
