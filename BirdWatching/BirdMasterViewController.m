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
#import "UIColor+FlatUI.h"
#import "UISlider+FlatUI.h"
#import "UIStepper+FlatUI.h"
#import "UITabBar+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "FUIButton.h"
#import "FUISwitch.h"
#import "UIFont+FlatUI.h"
#import "FUIAlertView.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UIProgressView+FlatUI.h"
#import "FUISegmentedControl.h"
#import "UIPopoverController+FlatUI.h"
#import "UITableViewCell+FlatUI.h"
#import "UIColor+FlatUI.h"

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
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor peterRiverColor]
                                  highlightedColor:[UIColor belizeHoleColor]
                                      cornerRadius:3
                                   whenContainedIn:[UINavigationBar class], nil];
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];
    
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
        return [[self.dataController.eventsForDay objectAtIndex:section] integerValue];
    }
    return [self.dataController countOfEvents];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self.dataController.events count] > 0) {
        NSInteger total = 0;
        for (NSInteger i = 0; i < section; i++) {
            total += [self tableView:tableView numberOfRowsInSection:i];
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"E, MMM dd"];
        
        if ([self.dataController objectInEventsAtIndex:total].date == nil || [[self.dataController objectInEventsAtIndex:total].date isEqual:[NSDate date]]) {
            return @"Today";
        }
        return [formatter stringFromDate:[self.dataController objectInEventsAtIndex:total].date];
    }
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataController.events count] > 0) {
        static NSString *CellIdentifier = @"EventCell";
        
        
        UITableViewCell *cell = [UITableViewCell configureFlatCellWithColor:[UIColor greenSeaColor] selectedColor:[UIColor cloudsColor] reuseIdentifier:CellIdentifier inTableView:(UITableView *)tableView];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"hh:mm"];

        NSInteger x = 0;
        for (int i = 0; i < indexPath.section; i++) {
            x += [self tableView:tableView numberOfRowsInSection:i];
//            NSLog([NSString stringWithFormat:@"%@", self.dataController.eventsForDay[i]]);
        }
        
        x += indexPath.row;

        
        Event *eventAtIndex = [self.dataController objectInEventsAtIndex:x];
        [[cell textLabel] setText:eventAtIndex.eventName];
        [[cell detailTextLabel] setText:[[df stringFromDate:eventAtIndex.date] stringByAppendingString:[@" @ " stringByAppendingString:eventAtIndex.houseName]]];
        return cell;
        
    } else {
        static NSString *CellIdentifier = @"EventCell";
        UITableViewCell *cell = [UITableViewCell configureFlatCellWithColor:[UIColor greenSeaColor] selectedColor:[UIColor cloudsColor] reuseIdentifier:CellIdentifier inTableView:(UITableView *)tableView];
        [[cell textLabel] setText:@"No events available"];
        return cell;
    }
    
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
        
        NSInteger x = 0;
        for (int i = 0; i < [self.tableView indexPathForSelectedRow].section; i++) {
            x += [self tableView:self.tableView numberOfRowsInSection:i];
        }
        
        x += [self.tableView indexPathForSelectedRow].row;
        
        detailViewController.event = [self.dataController objectInEventsAtIndex:x];
    }
}


@end
