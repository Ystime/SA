//
//  CustomerViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 08-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "CustomerViewController.h"
#import "CustomerOverViewController.h"
@interface CustomerViewController ()

@end

@implementation CustomerViewController
@synthesize selectedBusinessPartner,SalesDocuments,SDItems,documentsLoaded,PullUpView,PullHandle,bupaPictures,materialPictures,materials,notes,creatingDoc;
NSString * const kCVCLoadedDocs = @"CVCLoadedDocuments";

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
    if(!self.bupaLogo)
        self.bupaLogo = [UIImage imageNamed:@"AllComps.png"];
    creatingDoc = NO;
    [[RequestHandler uniqueInstance]setViewVisible:YES];
	// Do any additional setup after loading the view.
    for(UIButton *button in self.BottomButtons)
    {
        [UIView changeLayoutToDefaultProjectSettings:button];
    }
    for(UIButton *button in self.TopButtons)
    {
        [UIView changeLayoutToDefaultProjectSettings:button];
        
    }
    [UIView changeLayoutToDefaultProjectSettings:self.PullHandle];
    self.PullHandle.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.PullHandle.layer.borderWidth = 2.0;
    
    [self setUpPullUpView];
    CustomerOverViewController *sub1 = [self.storyboard instantiateViewControllerWithIdentifier:@"COVC"];
    sub1.selectedBUPA = selectedBusinessPartner;
    sub1.cvc = self;
    [self addChildViewController:(UIViewController*)sub1];
    
    UIViewController *sub3 = [self.storyboard instantiateViewControllerWithIdentifier:@"PVC"];
    [self addChildViewController:sub3];
    
    [self setViewInContainer:self.childViewControllers[0]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bupaPicturesLoaded:) name:kPicturesLoaded object:nil];
    [self performSelectorInBackground:@selector(retrieveMaterials) withObject:nil];
    [self performSelectorInBackground:@selector(retrieveMaterialPics) withObject:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bupaNotesLoaded:) name:kNotesLoaded object:nil];
    [[RequestHandler uniqueInstance]performSelectorInBackground:@selector(loadImagesforBusinessPartner:) withObject:selectedBusinessPartner];
    [self performSelectorInBackground:@selector(loadNotesWithPrefix:) withObject:nil];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //Change view for prospect actions
    if([selectedBusinessPartner.BusinessPartnerType isEqualToString:@"Prospect"])
    {
        self.TitleLabel.text = @"Prospect info sheet";
        for(UIButton *button in self.TopButtons)
        {
            if(button.tag != 1 && button.tag != 3)
                button.hidden = YES;
        }
        for(UIButton *button in self.BottomButtons)
        {
            if(button.tag == (6))
                [button setHidden:YES];
            else
                button.hidden = NO;
        }
        
    }
    //Change view for competitor actions
    else if([selectedBusinessPartner.BusinessPartnerType isEqualToString:@"Competitor"])
    {
        self.TitleLabel.text = @"Competitor info sheet";
        for(UIButton *button in self.TopButtons)
        {
            if(button.tag != 1 && button.tag != 3)
                button.hidden = YES;
        }
        for(UIButton *button in self.BottomButtons)
        {
            if (button.tag == 4||button.tag == 7 || button.tag == 10)
                [button setHidden:NO];
            else
                [button setHidden:YES];
        }
    }
    
    //Partner is customer, start pre-loading customer items such as Sales Docs and Pics
    else
    {
        for(UIButton *button in self.BottomButtons)
        {
            [button setHidden:NO];
        }
        documentsLoaded = NO;
        UIViewController *sub2 = [self.storyboard instantiateViewControllerWithIdentifier:@"SOS"];
        [self addChildViewController:sub2];
        
        UINavigationController *sub4 = [self.storyboard instantiateViewControllerWithIdentifier:@"NSN"];
        [self addChildViewController:sub4];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(salesDocumentsLoaded:) name:kLoadSalesDocumentsCompletedNotification object:nil];
        
        //        [[RequestHandler uniqueInstance]loadSalesDocuments:selectedBusinessPartner.SalesDocumentsQuery];
        
        [[RequestHandler uniqueInstance]performSelectorInBackground:@selector(loadSalesDocuments:) withObject:selectedBusinessPartner.SalesDocumentsQuery];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTopButtons:nil];
    [self setTitleLabel:nil];
    [self setBottomButtons:nil];
    [self setContainerView:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [super viewDidUnload];
}

-(void)setUpPullUpView
{
    //    PullUpView.openedCenter = CGPointMake((self.view.frame.size.width/2),self.view.frame.size.height-25 );
    [PullUpView setupPullableView:PullUpView.frame];
    self.InsidePullView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.InsidePullView.layer.borderWidth = 2.0;
    [UIView changeLayoutToDefaultProjectSettings:self.InsidePullView];
    
    PullUpView.openedCenter = CGPointMake(641,718);
    PullUpView.closedCenter = CGPointMake(641,798);
    PullUpView.center = PullUpView.closedCenter;
    PullUpView.handleView.frame = self.PullHandle.frame;
    PullUpView.delegate = self;
}

#pragma mark - Clicking buttons or segueing to other views
- (IBAction)clickedBottomButton:(id)sender
{
    switch ([sender tag]) {
        case 4: //Home Button
        {
            if(self.childViewControllers.count>2)
                [[NSNotificationCenter defaultCenter]removeObserver:self.childViewControllers[2]];
            [[NSNotificationCenter defaultCenter]removeObserver:self];
            [[RequestHandler uniqueInstance]setViewVisible:NO];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case 5: //New Contact Button
            break;
        case 6: //New Document Button
        {
            creatingDoc = YES;
            [self showDocumentViewWithSalesDocument:nil];
        }
            break;
        case 7: //New Picture Button
        {
            if ([UIImagePickerController isSourceTypeAvailable:
                 UIImagePickerControllerSourceTypeCamera] == NO)
                return ;
            UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
            cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            cameraUI.allowsEditing = NO;
            cameraUI.delegate = self;
            
            [self presentViewController:cameraUI animated:YES completion:nil];
        }
            break;
        case 8:
            break;
        case 9:
            break;
        case 10:
            [self performSegueWithIdentifier:@"addNote" sender:nil];
            break;
        default:
            break;
    }
    [PullUpView setOpened:NO animated:NO];
}
- (IBAction)clickedTab:(id)sender
{
    if(creatingDoc)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning!" message:@"If you leave this view all data will be lost! Do you want to proceed?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        alert.tag = [sender tag];
        [alert show];
    }
    else
    {
        for(UIButton *button  in self.TopButtons)
        {
            if(button.tag == [sender tag])
            {
                if(button.selected)
                    return;
                button.selected = YES;
            }
            else
            {
                button.selected = NO;
            }
        }
        switch([sender tag])
        {
            case 1:
                for(UIViewController *vc in self.childViewControllers)
                {
                    if([vc isKindOfClass:[CustomerOverViewController class]])
                    {
                        [self setViewInContainer:vc];
                        break;
                    }
                }
                break;
            case 2:
                for(UIViewController *vc in self.childViewControllers)
                {
                    if([vc isKindOfClass:[SalesOverViewController class]])
                    {
                        [self setViewInContainer:vc];
                        break;
                    }
                }
                break;
            case 3:
                for(UIViewController *vc in self.childViewControllers)
                {
                    if([vc isKindOfClass:[PictureViewController class]])
                    {
                        [self setViewInContainer:vc];
                        break;
                    }
                }
                break;
            default:
                break;
        }
        //    [self setViewInContainer:self.childViewControllers[[sender tag]-1]];
    }
}

-(void)setViewInContainer:(UIViewController*)newViewController
{
    UIView *newView = newViewController.view;
    for(UIView *view in self.containerView.subviews)
    {
        [view removeFromSuperview];
    }
    [self.containerView addSubview:newView];
    newView.frame = self.containerView.bounds;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"newContacts"])
    {
        NewContactController *ncc = (NewContactController*)segue.destinationViewController;
        ncc.relBUPA = selectedBusinessPartner;
    }
    else if([segue.identifier isEqualToString:@"addNote"])
    {
        NewTextController *ntc = (NewTextController*)segue.destinationViewController;
        ntc.cvc = self;
    }
    else if([segue.identifier isEqualToString:@"newPic"])
    {
        NewPictureViewController *npvc = segue.destinationViewController;
        npvc.takenPicture = sender;
        npvc.bupa = selectedBusinessPartner;
    }
}
-(void)showDocumentViewWithSalesDocument:(SalesDocument*)sd
{
    for(UIButton *button  in self.TopButtons)
    {
        button.selected = NO;
    }
    
    self.TitleLabel.text = @"New Document";
    UINavigationController *navi;
    for(UIViewController *vc in self.childViewControllers)
    {
        if ([vc isKindOfClass:[UINavigationController class]])
            navi = (UINavigationController*)vc;
    }
    DocumentViewController *dvc = navi.viewControllers[0];
    if(sd)
    {
        dvc.changeMode = YES;

    }
    else
    {
        dvc.changeMode = NO;
    }
    
    dvc.tempSalesDocument = sd;
    creatingDoc = YES;
    [navi popToRootViewControllerAnimated:NO];
    [self setViewInContainer:navi];
    
}

-(void)showPictureViewForKey:(NSString*)key
{
    for(UIButton *button in self.TopButtons)
    {
        if(button.tag!=3)
            button.selected = NO;
        else
            button.selected = YES;
    }
    PictureViewController *pvc;
    for(UIViewController *vc in self.childViewControllers)
    {
        if([vc isKindOfClass:[PictureViewController class]])
        {
            pvc = (PictureViewController*)vc;
            break;
        }
        
    }
    //    PictureViewController *pvc = self.childViewControllers[2];
    [self setViewInContainer:pvc];
    [pvc showPVCWithPictureForKey:key];
}

#pragma mark - Loading data for Business Partner


-(void)loadNotesWithPrefix:(NSString*)prefix
{
    [[RequestHandler uniqueInstance]loadNotesForBusinessPartner:selectedBusinessPartner withPrefix:prefix];
}
-(void)salesDocumentsLoaded:(NSNotification*)notification
{
    NSDictionary *userInfoDict = [notification userInfo];
    SalesDocuments = [userInfoDict objectForKey:kResponseItems];
    /*Temporarely manual filtering in application*/
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    for(SalesDocument *sd in SalesDocuments)
    {
        if ([sd.CustomerID isEqualToString:selectedBusinessPartner.BusinessPartnerID])
            [temp addObject:sd];
    }
    SalesDocuments = temp;
    [[NSNotificationCenter defaultCenter]postNotificationName:kCVCLoadedDocs object:nil];
}

-(void)bupaPicturesLoaded:(NSNotification*)notification
{
    NSError *error;
    error = [notification.userInfo objectForKey:kResponseError];
    if(error)
    {
        bupaPictures = [NSMutableDictionary dictionary];
    }
    else
    {
        bupaPictures = [notification.userInfo objectForKey:kResponseItems];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:kPicturesProcesssed object:self userInfo:notification.userInfo];
    
}

-(void)bupaNotesLoaded:(NSNotification*)notification
{
    NSError *error;
    error = [notification.userInfo objectForKey:kResponseError];
    if(error)
    {
        notes = [NSMutableDictionary dictionary];
    }
    else
    {
        notes = [notification.userInfo objectForKey:kResponseItems];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotesProcesssed object:self userInfo:notification.userInfo];
}

-(void)retrieveMaterials
{
    while(!self.mvc.Materials){}
    materials = self.mvc.Materials;
    [[NSNotificationCenter defaultCenter]postNotificationName:kMaterialsProcesssed object:self];
}

-(void)retrieveMaterialPics
{
    while(!self.mvc.MaterialPictures){}
    materialPictures = self.mvc.MaterialPictures;
    [[NSNotificationCenter defaultCenter]postNotificationName:kMaterialPicuresProcesssed object:self userInfo:materialPictures];
}



#pragma mark - Pull Up View Delegate
- (void)pullableView:(PullableView *)pView didChangeState:(BOOL)opened {
    if (opened)
    {
        
    }
    else
    {
        
    }
}

#pragma mark - Camera Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *capturedImage = (UIImage *) [info objectForKey:
                                          UIImagePickerControllerOriginalImage];
    UIImage *resultingImage = [UIImage imageWithImage:capturedImage scaledToSize:CGSizeMake(640, 480)];
    [self dismissViewControllerAnimated:YES completion:^
     {
         [self performSegueWithIdentifier:@"newPic" sender:resultingImage];
     }];
}

#pragma mark - AlerView Delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == [alertView cancelButtonIndex])
    {
        
    }
    else
    {
        creatingDoc = NO;
        [self clickedTab:alertView];
    }
}
@end
