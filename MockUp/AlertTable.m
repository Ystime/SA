//
//  AlertTable.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 07-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "AlertTable.h"

@implementation AlertTable

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
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - Table Datasource Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlertCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlertCell"];
    if(cell == nil)
    {
        cell = [[AlertCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AlertCell"];
    }
    cell.alertText.text = [NSString stringWithFormat:@"Alert:%i",indexPath.row];
    cell.alertIcon.image = [UIImage imageNamed:@"Suspect_Icon.png"];
    
    return cell;
}

@end
