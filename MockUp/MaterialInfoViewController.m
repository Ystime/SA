//
//  MaterialInfoViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 14-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "MaterialInfoViewController.h"
#import "ProductCatalogViewController.h"
#import "DocumentViewController.h"
@interface MaterialInfoViewController ()

@end

@implementation MaterialInfoViewController
@synthesize material,materials,matPics,editItem,parent;
int value;
AFOpenFlowView *matFlow;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    float value = floorf(self.QuantitySlider.value);
    self.QuantityLabel.text = [NSString stringWithFormat:@"%.0f",value];
    [UIView changeLayoutToDefaultProjectSettings:self.AddButton];
    for(UIButton *button in self.SliderButtons)
    {
        button.layer.cornerRadius = 15.0;
        button.layer.masksToBounds = YES;
    }
    for(UIView *view in self.ViewCollection)
    {
        [UIView changeLayoutToDefaultProjectSettings:view];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated
{
    if(editItem)
    {
        self.MaterialImage.hidden = NO;
        [matFlow removeFromSuperview];
        matFlow = nil;
        for (UILabel *label in self.MaterialLabels)
        {
            switch (label.tag) {
                case 1:
                    label.text = editItem.Description;
                    break;
                case 2:
                    label.text = editItem.Material;
                    break;
                case 3:
                    label.text = editItem.UoM;
                    break;
                case 4:
                    label.text =[NSString stringWithFormat:@"%.2f",editItem.NetPrice.floatValue];
                    break;
                case 5:
                    label.text = [NSString stringWithFormat:@"%.0f",editItem.Quantity.floatValue];
                    break;
                case 6:
                    //                    label.text = editItem.EANCode;
                    break;
                default:
                    break;
            }
        }
        value =editItem.Quantity.floatValue;
    }
    else if(materials)
    {
        matFlow = [[AFOpenFlowView alloc]initWithFrame:self.TopCell.frame];
        matFlow.numberOfImages = materials.count;
        self.MaterialImage.hidden = YES;
        for(int i = 0;i<materials.count;i++)
        {
            Material *temp = materials[i];
            [matFlow setImage:[UIImage imageWithImage:[matPics objectForKey:temp.MaterialNumber] scaledToSize:CGSizeMake(125, 125)] forIndex:i];
        }
        matFlow.viewDelegate = self;
        [self.TopCell addSubview:matFlow];
        if(material)
        {
            int tempIndex = [materials indexOfObject:material];
            [matFlow setSelectedCover:tempIndex];
            [matFlow centerOnSelectedCover:YES];
            [self openFlowView:matFlow selectionDidChange:tempIndex];
        }
    }
    else
    {
        self.MaterialImage.hidden = NO;
        [matFlow removeFromSuperview];
        matFlow = nil;
        for (UILabel *label in self.MaterialLabels)
        {
            switch (label.tag) {
                case 1:
                    label.text = material.Description;
                    break;
                case 2:
                    label.text = material.MaterialNumber;
                    break;
                case 3:
                    label.text = material.UoM;
                    break;
                case 4:
                    label.text = [NSString stringWithFormat:@"%@ %.2f",material.Price.Currency,material.Price.Price.floatValue];
                    break;
                case 5:
                    label.text = [NSString stringWithFormat:@"%.0f",material.MinimumOrderQuantity.floatValue];
                    break;
                case 6:
                    label.text = material.EANCode;
                    break;
                default:
                    break;
            }
        }
        value = 1;
    }
    
    [self.QuantitySlider setValue:value animated:NO];
    self.QuantityLabel.text = [NSString stringWithFormat:@"%i",value];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)QuantityChanged:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    value = floorf(slider.value);
    self.QuantityLabel.text = [NSString stringWithFormat:@"%i",value];
    slider.value = value;
}


- (IBAction)changeValue:(id)sender
{
    switch ([sender tag]) {
        case 1:
            [self changeItemValue:-1];
            break;
        case 2:
            [self changeItemValue:1];
            break;
        default:
            break;
    }
}

- (IBAction)addItem:(id)sender
{
    NSString *itemAction;
    switch ([sender tag]) {
        case 1:
            itemAction = @"QUOTATION";
            break;
        case 2:
            itemAction = @"RETURN_ORDER";
            break;
        case 3:
            itemAction = @"ORDER";
            break;
        default:
            break;
    }
    if(editItem)
    {
        editItem.ItemNumber = itemAction;
        editItem.Quantity = [NSNumber numberWithFloat:self.QuantitySlider.value];
        DocumentViewController *dvc = (DocumentViewController*)parent;
        [dvc.pop dismissPopoverAnimated:YES];
        [dvc.ItemsTable reloadData];
    }
    else
    {
        if([self.parent isKindOfClass:[ProductViewController class]])
        {
            ProductViewController *pvc = (ProductViewController*)parent;
            [pvc.pop dismissPopoverAnimated:YES];
            [pvc addItemWithQuantity:self.QuantitySlider.value andMaterial:self.material andAction:itemAction andPrice:self.material.Price.Price];
        }
        else
            
        {
            DocumentViewController *dvc = self.parent.tabBarController.viewControllers[1];

            [dvc addItemWithQuantity:self.QuantitySlider.value andMaterial:self.material andAction:itemAction andPrice:self.material.Price.Price];
            ProductCatalogViewController* pc = (ProductCatalogViewController*)self.parent;
            [pc.pop dismissPopoverAnimated:YES];
        
            
        }
    }
}

-(void)changeItemValue:(int)diff
{
    value = value + diff;
    [self.QuantitySlider setValue:value animated:YES];
    self.QuantityLabel.text = [NSString stringWithFormat:@"%i",value];
}

#pragma mark - AFOpenFlowViewDelegate
- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index
{
    value = 0;
    [self changeItemValue:1];
    material = materials[index];
    for (UILabel *label in self.MaterialLabels)
    {
        switch (label.tag) {
            case 1:
                label.text = material.Description;
                break;
            case 2:
                label.text = material.MaterialNumber;
                break;
            case 3:
                label.text = material.UoM;
                break;
            case 4:
                label.text = [NSString stringWithFormat:@"%.2f",material.Price.Price.floatValue];
                break;
            case 5:
                label.text = [NSString stringWithFormat:@"%.0f",material.MinimumOrderQuantity.floatValue];
                break;
            case 6:
                label.text = material.EANCode;
                break;
            default:
                break;
        }
    }
}

@end
