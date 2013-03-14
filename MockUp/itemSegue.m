//
//  itemSegue.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 28-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "itemSegue.h"
@implementation itemSegue

-(void)perform
{
    SalesOverViewController *sovc = (SalesOverViewController*)self.sourceViewController;
    ItemViewController *ivc = (ItemViewController*)self.destinationViewController;
    UITableViewCell *cell = [sovc.ItemTable cellForRowAtIndexPath:sovc.ItemTable.indexPathForSelectedRow];
    UIPopoverController * pop = [[UIPopoverController alloc]initWithContentViewController:ivc];
    sovc.pop = pop;
    CGSize size =CGSizeMake(250, 434);
    pop.popoverContentSize = size;
    [pop presentPopoverFromRect:cell.frame inView:sovc.ItemTable permittedArrowDirections:(UIPopoverArrowDirectionRight|UIPopoverArrowDirectionUp)  animated:YES];
    
}


@end
