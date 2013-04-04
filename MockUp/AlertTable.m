//
//  AlertTable.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 07-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "AlertTable.h"

@implementation AlertTable
NSMutableDictionary *notes;
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

-(void)loadAlertsForBusinessPartner:(BusinessPartner*)bupa
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(processNotes:) name:kAlertsLoaded object:nil];
    [[RequestHandler uniqueInstance]loadNotesForBusinessPartner:bupa withPrefix:@"ALERT"];
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
    return notes.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlertCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlertCell"];
    if(cell == nil)
    {
        cell = [[AlertCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AlertCell"];
    }
    cell.alertText.text = [notes objectForKey:notes.allKeys[indexPath.row]];
    return cell;
}


-(void)processNotes:(NSNotification*)notification
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSError *error;
    error = [notification.userInfo objectForKey:kResponseError];
    if (error)
        return;
    else
    {
        notes = [notification.userInfo objectForKey:kResponseItems];
        [self reloadData];
    }
    
}
@end
