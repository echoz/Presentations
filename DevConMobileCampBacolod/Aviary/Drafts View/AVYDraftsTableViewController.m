//
//  AVYDraftsTableViewController.m
//  Aviary
//
//  Created by Jeremy Foo on 21/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AVYDraftsTableViewController.h"
#import "AVYTweetDraft.h"
#import "AVYDraftViewController.h"

@interface AVYDraftsTableViewController ()

@end

@implementation AVYDraftsTableViewController
@synthesize drafts;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.drafts = [NSMutableArray arrayWithCapacity:0];        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonTapped:)] autorelease];
    self.title = @"Tweet Drafts";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.drafts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    cell.textLabel.text = [[self.drafts objectAtIndex:indexPath.row] tweetBody];
    cell.detailTextLabel.text = [[[self.drafts objectAtIndex:indexPath.row] dateCreated] description];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}  

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.drafts removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AVYDraftViewController *editDraft = [[AVYDraftViewController alloc] initWithTweetDraft:[self.drafts objectAtIndex:indexPath.row] completion:nil];
    [self.navigationController pushViewController:editDraft animated:YES];
}

- (void)addButtonTapped:(id)sender {
    AVYTweetDraft *tweet = [[AVYTweetDraft alloc] init];
    
    [self.drafts addObject:tweet];
    
    AVYDraftViewController *editNewDraft = [[AVYDraftViewController alloc] initWithTweetDraft:tweet completion:^{
        [self dismissModalViewControllerAnimated:YES]; 
    }];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:editNewDraft];
    
    [self presentModalViewController:nav animated:YES];
    
    [nav release];
    [tweet release];
    
}
- (void)dealloc {
    [super dealloc];
}
@end
