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
NSArray *productKeys;
NSArray *events;
NSMutableArray *tasks;
EKEventStore *store;
EKReminder *selectedReminder;


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
        for(UIView *view in self.subviews)
        {
            if(![view isKindOfClass:[UILabel class]])
            {
                view.layer.borderColor = [[UIColor lightGrayColor]CGColor];
                view.layer.borderWidth = 1.0;
                store  = [[EKEventStore alloc] init];
            }
        }
    }
    return self;
}

-(void)setupNewProductViewWithProducts:(NSDictionary*)products
{
    
    picFlow = [[AFOpenFlowView alloc]initWithFrame:self.leftView.frame];
    picFlow.viewDelegate = self;
    picFlow.numberOfImages = products.count;
    productKeys = [products.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    for(int i =0;i<productKeys.count;i++)
    {
        [picFlow setImage:[UIImage imageWithImage:[products objectForKey:productKeys[i]] scaledToSize:CGSizeMake(150, 150)] forIndex:i];
    }
    [self openFlowView:picFlow selectionDidChange:0];
    [picFlow setSelectedCover:0];
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
        {
            if(events)
                return events.count;
            else
                return 0;
        }
        case 2:
            if(tasks)
                return tasks.count;
            else
                return 0;
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
            EKEvent *temp =  events[indexPath.row];
            cell.textLabel.text = [GlobalFunctions getStringFormat:@"hh:mm" FromDate:temp.startDate];
            cell.detailTextLabel.text = temp.title;
        }
            break;
        case 2:
        {
            EKReminder *reminder = tasks[indexPath.row];
            cell = [tableView dequeueReusableCellWithIdentifier:@"note"];
            if(cell == nil)
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"note"];
            cell.imageView.image = [UIImage imageNamed:@"warning.png"];
            cell.textLabel.text = reminder.title;
            cell.detailTextLabel.text = reminder.notes;
        }
            break;
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag ==1)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:cell.textLabel.text message:cell.detailTextLabel.text delegate:nil cancelButtonTitle:@"OK"otherButtonTitles: nil];
        [alert show];
    }
    else if(tableView.tag ==2)
    {
        selectedReminder = tasks[indexPath.row];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:selectedReminder.title message:selectedReminder.notes delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Completed", nil];
        [alert show];
    }
}


- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index
{
    self.productTitle.text = productKeys[index];
}

#pragma mark - Setting up the calendar

-(void)getCalenderEvents
{
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted,NSError *error)
     {
         if(granted)
         {
             // Get the appropriate calendar
             NSCalendar *calendar = [NSCalendar currentCalendar];
             
             // Create the start date components
             NSDateComponents *oneDayAgoComponents = [[NSDateComponents alloc] init];
             oneDayAgoComponents.day = 0;
             NSDate *oneDayAgo = [calendar dateByAddingComponents:oneDayAgoComponents
                                                           toDate:[NSDate date]
                                                          options:0];
             
             // Create the end date components
             NSDateComponents *oneYearFromNowComponents = [[NSDateComponents alloc] init];
             oneYearFromNowComponents.day = 1;
             oneYearFromNowComponents.hour = -([GlobalFunctions getStringFormat:@"hh" FromDate:[NSDate date]].integerValue);
             oneYearFromNowComponents.minute = -([GlobalFunctions getStringFormat:@"mm" FromDate:[NSDate date]].integerValue);
             oneYearFromNowComponents.second = -([GlobalFunctions getStringFormat:@"ss" FromDate:[NSDate date]].integerValue);
             NSDate *oneYearFromNow = [calendar dateByAddingComponents:oneYearFromNowComponents
                                                                toDate:[NSDate date]
                                                               options:0];
             
             // Create the predicate from the event store's instance method
             NSPredicate *predicate = [store predicateForEventsWithStartDate:oneDayAgo
                                                                     endDate:oneYearFromNow
                                                                   calendars:nil];
             // Fetch all events that match the predicate
             events = [store eventsMatchingPredicate:predicate];
             [self.calendarTable reloadData];
         }
     }];
}

-(void)getCalendarTasks
{

    tasks = [NSMutableArray array];
    [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted,NSError *error)
     {
         if(granted)
         {
             NSPredicate *predicate = [store predicateForRemindersInCalendars:nil];
             [store fetchRemindersMatchingPredicate:predicate completion:^(NSArray *reminders)
              {
                  for(EKReminder *reminder in reminders)
                  {
                      if(!reminder.completed)
                          [tasks addObject:reminder];
                  }
                  [self.taskTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
              }];
         }
     }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == alertView.cancelButtonIndex)
    {
        
    }
    else
    {
        [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted,NSError *error)
         {
             if(granted)
             {
                 NSPredicate *predicate = [store predicateForRemindersInCalendars:nil];
                 [store fetchRemindersMatchingPredicate:predicate completion:^(NSArray *reminders)
                  {
                      for(EKReminder *reminder in reminders)
                      {
                          if([reminder.calendarItemIdentifier isEqualToString:selectedReminder.calendarItemIdentifier])
                          {
                              NSError *error;
                              reminder.completed = YES;
                              [store saveReminder:reminder commit:YES error:&error];
                              [self getCalendarTasks];
                              return;
                          }
                      }
                      [self.taskTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
                  }];
             }
         }];
    }
}
@end
