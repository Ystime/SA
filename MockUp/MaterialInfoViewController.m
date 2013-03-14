//
//  MaterialInfoViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 14-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "MaterialInfoViewController.h"

@interface MaterialInfoViewController ()

@end

@implementation MaterialInfoViewController
@synthesize material,editItem,parent;
int value;

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated
{
    if(editItem)
    {
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
                    //label.text = material.Price;
                    break;
                case 5:
//                    label.text = [NSString stringWithFormat:@"%.0f",editItem.Quantity.floatValue];
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
    else{
        
        
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
                    //label.text = material.Price;
                    break;
                case 5:
                    label.text = [NSString stringWithFormat:@"%.0f",material.Quantity.floatValue];
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
    for(UIButton *button in self.SliderButtons)
    {
        button.layer.cornerRadius = 15.0;
        button.layer.masksToBounds = YES;
    }
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
            itemAction = @"Quotation";
            break;
        case 2:
            itemAction = @"Return Order";
            break;
        case 3:
            itemAction = @"Sales Order";
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
        ProductViewController *pvc = (ProductViewController*)parent;
        [pvc.pop dismissPopoverAnimated:YES];
        [pvc addItemWithQuantity:self.QuantitySlider.value andMaterial:self.material andAction:itemAction];
    }
}

-(void)changeItemValue:(int)diff
{
    value = value + diff;
    [self.QuantitySlider setValue:value animated:YES];
    self.QuantityLabel.text = [NSString stringWithFormat:@"%i",value];
}

@end
