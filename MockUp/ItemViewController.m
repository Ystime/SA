//
//  ItemViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 28-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "ItemViewController.h"

@interface ItemViewController ()

@end

@implementation ItemViewController
@synthesize item;
UIImage *matImage;
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.MaterialImage.image=nil;
}

-(void)viewDidAppear:(BOOL)animated
{
    if(matImage)
        self.MaterialImage.image = matImage;
    for(UILabel *label in self.CellLabels)
    {
        switch (label.tag) {
            case 1:
                label.text = item.Material;
                break;
            case 2:
                label.text = item.Description;
                break;
            case 3:
                label.text =[NSString stringWithFormat:@"%.2f",item.Quantity.floatValue];
                break;
            case 4:
                label.text = item.UoM;
                break;
            case 5:
                label.text = [NSString stringWithFormat:@"%.2f",item.NetPrice.floatValue];
                break;
            case 6:
                label.text = [NSString stringWithFormat:@"%.2f",item.NetValue.floatValue];
                break;
                
            default:
                break;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadMaterialImage
{
//    UIImage *temp= [[RequestHandler uniqueInstance]loadImage:@"DEMO" forEntityType:@"Material" withID:item.Material];
//    if(temp)
//        self.MaterialImage.image = temp;
//    else
        self.MaterialImage.image = [UIImage imageNamed:@"unknown.png"];
}

-(void)setItem:(SalesDocItem *)Selecteditem andImage:(UIImage*)image
{
    item = Selecteditem;
    matImage = image;

}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)viewDidUnload {
    [self setCellLabels:nil];
    [self setMaterialImage:nil];
    [super viewDidUnload];
}
@end
