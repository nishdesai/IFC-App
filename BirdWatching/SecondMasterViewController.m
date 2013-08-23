//
//  SecondMasterViewController.m
//  SecondWatching
//
//  Created by Nishant Desai on 8/5/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "SecondMasterViewController.h"
#import "SecondDetailViewController.h"
#import "RushDataController.h"
#import "House.h"
#import "Event.h"

@implementation SecondMasterViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.dataController = [[RushDataController alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = nil;
//    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moveObject:(id)sender
{
    [super setEditing:YES animated:YES];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataController countOfHouses];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HouseCell";
    
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    House *houseAtIndex = [self.dataController objectInHousesAtIndex:indexPath.row];
    [[cell textLabel] setText:houseAtIndex.name];
    if (houseAtIndex.greek != nil) {
        [[cell detailTextLabel] setText:houseAtIndex.greek];
    } else {
        [[cell detailTextLabel] setText:@""];
    }
    cell.showsReorderControl = YES;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}


 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
     House *house = [self.dataController.houses objectAtIndex:fromIndexPath.row];
     [self.dataController.houses removeObjectAtIndex:fromIndexPath.row];
     [self.dataController.houses insertObject:house atIndex:toIndexPath.row];
     
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.dataController.houses];
     [defaults setObject:data forKey:@"houseArray"];
     [defaults synchronize];
     
 }



 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"HouseInfoSegue"]) {
        SecondDetailViewController *detailViewController = [segue destinationViewController];
        
        detailViewController.house = [self.dataController objectInHousesAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

@end
