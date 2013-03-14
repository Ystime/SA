//
//  NoteView.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 28-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "NoteView.h"

@implementation NoteView
@synthesize notes;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setNotes:(NSMutableArray *)newNotes
{
    self.notes = newNotes;
    [self.noteTable reloadData];
}

#pragma mark - TableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.noteView.text = [NSString stringWithFormat:@"You have clicked on note number: %i",indexPath.row ];
}
#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
//    return notes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.noteTable dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    
    
    /*Fill contents of  cell*/
    cell.detailTextLabel.text = @"Testing something";
    cell.textLabel.text = [NSString stringWithFormat:@"Number: %i",indexPath.row];
    return cell;
}
@end
