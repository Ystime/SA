//
//  HeaderViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 19-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "HeaderViewController.h"
#import "CustomerViewController.h"
@interface HeaderViewController ()

@end

@implementation HeaderViewController
@synthesize sd;
DocumentViewController *ndvc;
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
    self.DlvDatePicker.minimumDate = [NSDate dateWithTimeInterval:3600*24*7 sinceDate:[NSDate date]];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.POField.text = sd.CustomerPurchaseOrderNumber;
    if(!(sd.RequestedDeliveryDate == nil))
        [self.DlvDatePicker setDate:sd.RequestedDeliveryDate];
    for(UILabel *label in self.Labels)
    {
        switch (label.tag) {
            case 1:
                label.text = ndvc.cvc.selectedBusinessPartner.BusinessPartnerName;
                break;
            case 2:
                label.text = [SettingsUtilities getUsernameFromUserSettings];
                break;
            case 3:
                label.text = sd.SalesOrganization;
                break;
            case 4:
                label.text = sd.Division;
                break;
            case 5:
                label.text = sd.DistributionChannel;
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

- (IBAction)topButtonClicked:(id)sender {
    if([sender tag] == 1)
    {
        sd.CustomerPurchaseOrderNumber = self.POField.text;
        sd.RequestedDeliveryDate = self.DlvDatePicker.date;
        [ndvc setHeaderLabelView];
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setNDVC:(UIViewController*)nv
{
    ndvc = (DocumentViewController*)nv;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"shipToChoice"])
    {
        UITableViewController *tvc = (UITableViewController*)segue.destinationViewController;
        tvc.tableView.delegate = self;
        tvc.tableView.dataSource = self;
    }
}
@end
