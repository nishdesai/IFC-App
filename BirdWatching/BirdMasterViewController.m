//
//  BirdMasterViewController.m
//  BirdWatching
//
//  Created by Nishant Desai on 8/5/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "BirdMasterViewController.h"
#import "BirdDetailViewController.h"
#import "RushDataController.h"
#import "Event.h"
#import "House.h"

@interface BirdMasterViewController ()

@property NSDate *lastRefresh;

@end

@implementation BirdMasterViewController{
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.dataController = [[RushDataController alloc] init];
    self.lastRefresh = [NSDate date];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(checkForRefresh:)
                                                  name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
//	// Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = nil;
//
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)checkForRefresh:(NSNotification *)notification {
    NSLog(@"Message Received");
    if ([self.lastRefresh timeIntervalSinceNow] <= -43200) {
        [self.dataController reloadLists];
        self.lastRefresh = [NSDate date];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)insertNewObject:(id)sender
//{
//    if (!_objects) {
//        _objects = [[NSMutableArray alloc] init];
//    }
//    [_objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.dataController.eventsForDay count] > 0) {
        return [self.dataController.eventsForDay count];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.dataController.eventsForDay count] > 0) {
        return [(NSNumber *)[self.dataController.eventsForDay objectAtIndex:section] integerValue];
    }
    return [self.dataController countOfEvents];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSInteger total = 1;
    for (NSInteger i = 0; i < section; i++) {
        total = total + [self tableView:tableView numberOfRowsInSection:i];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"E, dd/MM"];
    
    if ([self.dataController objectInEventsAtIndex:total].date == nil || [[self.dataController objectInEventsAtIndex:total].date isEqual:[NSDate date]]) {
        return @"Today";
    }
    return [formatter stringFromDate:[self.dataController objectInEventsAtIndex:total].date];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventCell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Event *eventAtIndex = [self.dataController objectInEventsAtIndex:indexPath.row];
    [[cell textLabel] setText:eventAtIndex.eventName];
    [[cell detailTextLabel] setText:[eventAtIndex.houseName stringByAppendingString:@" @ 6:00"]];
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"EventInfoSegue"]) {
        BirdDetailViewController *detailViewController = [segue destinationViewController];
        
        detailViewController.event = [self.dataController objectInEventsAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}


@end
