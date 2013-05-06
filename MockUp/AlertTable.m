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
NSArray *noteKeys;
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
        notes = nil;
        noteKeys = nil;
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
    cell.alertText.text = noteKeys[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlertCell *cell = (AlertCell*)[self cellForRowAtIndexPath:indexPath];
    NSString *key = cell.alertText.text;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:key message:[notes objectForKey:key] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}

-(void)processNotes:(NSNotification*)notification
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSError *error;
    error = [notification.userInfo objectForKey:kResponseError];
    
    notes = [notification.userInfo objectForKey:kResponseItems];
    if (error || noteKeys.count == 0)
        notes = [NSMutableDictionary dictionaryWithObject:@"No sales alerts were found for this business partner" forKey:@"No Alerts"];
    noteKeys = notes.allKeys;
    [self reloadData];
    
    
}
@end
