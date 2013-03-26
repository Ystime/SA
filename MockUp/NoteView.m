//
//  NoteView.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 28-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "NoteView.h"
#import "CustomerOverViewController.h"

@implementation NoteView
@synthesize notes,cvc;
NSMutableArray *noteKeys;
UITextView *noteText;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setNotes:(NSMutableDictionary *)newNotes
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    noteKeys=nil;
    notes = nil;
    [self.noteTable reloadData];
    if(newNotes)
    {
        notes = newNotes;
        noteKeys = (NSMutableArray*)notes.allKeys;
        [self.noteTable reloadData];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notesProcessed:) name:kNotesProcesssed object:nil];
}

-(void)notesProcessed:(NSNotification*)notification
{
    [self setNotes:[notification.userInfo objectForKey:kResponseItems]];
}

#pragma mark - TableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row <noteKeys.count)
    {
        [noteText removeFromSuperview];
        noteText = nil;
        noteText = [[UITextView alloc]initWithFrame:CGRectMake(367, 20, 339, 281)];
        NSLog(@"%@",noteKeys[indexPath.row]);
        noteText.text = [notes objectForKey:noteKeys[indexPath.row]];
        [self addSubview:noteText];
    }
    else //The Add cell is clicked
    {
        [cvc performSegueWithIdentifier:@"addNote" sender:self];
    }
}
#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return noteKeys.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.noteTable dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    if(indexPath.row < noteKeys.count)
    {
        /*Fill contents of  cell*/
        cell.textLabel.text = noteKeys[indexPath.row];
        cell.imageView.image = nil;
    }
    else //Cell is addCell
    {
        cell.textLabel.text = @"Add Note";
        cell.imageView.image = [UIImage imageNamed:@"add_note.png"];
    }
    return cell;
}
@end
