//
//  MaterialInfo.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 14-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "MaterialInfo.h"
#import "CustomerViewController.h"
@implementation MaterialInfo

-(void)perform
{
    MaterialInfoViewController *mivc = (MaterialInfoViewController*)self.destinationViewController;
    UIPopoverController *pop = [[UIPopoverController alloc]initWithContentViewController:mivc];
    pop.popoverContentSize = CGSizeMake(350, 600);
    mivc.parent = self.sourceViewController;

    
    if([self.identifier isEqualToString:@"MaterialInfo"]){
        ProductViewController *pvc = (ProductViewController*)self.sourceViewController;
        pvc.pop = pop;
        if([pvc.MaterialCollection isHidden])
        {
            MaterialCell *cell = (MaterialCell*)[pvc.MaterialTable cellForRowAtIndexPath:pvc.tappedIndexPath];
            [pop presentPopoverFromRect:cell.frame inView:pvc.MaterialTable permittedArrowDirections:(UIPopoverArrowDirectionLeft|UIPopoverArrowDirectionRight) animated:YES];
            mivc.MaterialImage.image = cell.MaterialImage.image;
            
        }
        else
        {
            MaterialCollectionCell *cell = (MaterialCollectionCell*)[pvc.MaterialCollection cellForItemAtIndexPath:pvc.MaterialCollection.indexPathsForSelectedItems[0]];
            [pop presentPopoverFromRect:cell.frame inView:pvc.MaterialCollection permittedArrowDirections:(UIPopoverArrowDirectionLeft|UIPopoverArrowDirectionRight) animated:YES];
            mivc.MaterialImage.image = cell.MaterialImage.image;

        }
    }
    else if([self.identifier isEqualToString:@"editItem"])
    {
        DocumentViewController *dvc = (DocumentViewController*)self.sourceViewController;
        dvc.pop = pop;
        UITableViewCell *cell = [dvc.ItemsTable cellForRowAtIndexPath:dvc.ItemsTable.indexPathForSelectedRow];
        mivc.editItem = dvc.tempSalesDocument.Items[dvc.ItemsTable.indexPathForSelectedRow.row];
        [pop presentPopoverFromRect:cell.frame inView:dvc.ItemsTable permittedArrowDirections:(UIPopoverArrowDirectionLeft|UIPopoverArrowDirectionRight) animated:YES];
        if(dvc.cvc.materialPictures)
            mivc.MaterialImage.image = [dvc.cvc.materialPictures objectForKey:mivc.editItem.Material];
    }
}
@end
