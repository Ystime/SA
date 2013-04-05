//
//  ExtrasView.m
//  Sales Around
//
//  Created by IJsbrand van Rijn on 05-04-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "ExtrasView.h"
#import "MainViewController.h"

@implementation ExtrasView
AFOpenFlowView *picFlow;
NSArray *productTitles;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        productTitles = [NSArray arrayWithObjects:@"Star Sign",@"Glass Sign", nil];
    }
    return self;
}

-(void)setupViews
{
    for(UIView *view in self.subviews)
    {
        if(![view isKindOfClass:[UILabel class]])
        {
            view.layer.borderColor = [[UIColor lightGrayColor]CGColor];
            view.layer.borderWidth = 1.0;
        }
    }
    picFlow = [[AFOpenFlowView alloc]initWithFrame:self.leftView.frame];
    picFlow.viewDelegate = self;
    picFlow.numberOfImages = 2;
    [picFlow setImage:[UIImage imageWithImage:[UIImage imageNamed:@"np1.jpg"] scaledToSize:CGSizeMake(150, 150)] forIndex:0];
    [picFlow setImage:[UIImage imageWithImage:[UIImage imageNamed:@"np2.jpg"] scaledToSize:CGSizeMake(150, 150)] forIndex:1];
    self.productTitle.text = productTitles[0];
    [self.leftView addSubview:picFlow];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(tableView.tag)
    {
        case 1:
            return 2;
            break;
        case 2:
            return 3;
            break;
        default:
            return 0;
            break;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    switch (tableView.tag) {
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"action"];
            if(cell == nil)
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"action"];
            cell.imageView.image = [UIImage imageNamed:@"coffee.png"];
            cell.textLabel.text =[NSString stringWithFormat:@"1%i:00h",indexPath.row];
            cell.detailTextLabel.text = @"Drink some coffee with your colleagues while you are discussing which football club should win the Champions League!";
        }
            break;
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"note"];
            if(cell == nil)
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"note"];
            cell.imageView.image = [UIImage imageNamed:@"warning.png"];
            cell.textLabel.text =@"Alert!";
            cell.detailTextLabel.text = @"Write hours before project controller Ms. Willemse sends an angry email";
            break;
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:cell.textLabel.text message:cell.detailTextLabel.text delegate:nil cancelButtonTitle:@"OK"otherButtonTitles: nil];
    [alert show];
}

- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index
{
    self.productTitle.text = productTitles[index];
}
@end
