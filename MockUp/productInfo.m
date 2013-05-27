//
//  productInfo.m
//  Sales Around
//
//  Created by IJsbrand van Rijn on 14-05-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "productInfo.h"
#import "ProductCatalogViewController.h"
#import "MaterialInfoViewController.h"
#import "ProductCell.h"

@implementation productInfo
-(void)perform
{
    MaterialInfoViewController *mivc = (MaterialInfoViewController*)self.destinationViewController;
    UIPopoverController *pop = [[UIPopoverController alloc]initWithContentViewController:mivc];
    if([self.identifier isEqualToString:@"infoProduct"])
    {
        ProductCatalogViewController *pvcv = self.sourceViewController;
        pvcv.pop = pop;
        mivc.parent = pvcv;
        pop.popoverContentSize = CGSizeMake(350, 600);
        MaterialCollectionCell *pc = (MaterialCollectionCell*)[pvcv.MaterialCollectionView cellForItemAtIndexPath:pvcv.MaterialCollectionView.indexPathsForSelectedItems[0]];
        [pop presentPopoverFromRect:pc.frame inView:pvcv.MaterialCollectionView permittedArrowDirections:(UIPopoverArrowDirectionRight|UIPopoverArrowDirectionLeft) animated:YES];
        mivc.MaterialImage.image = pc.MaterialImage.image;
    }
}
@end
