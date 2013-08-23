//
//  BirdDetailViewController.m
//  BirdWatching
//
//  Created by Nishant Desai on 8/5/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "BirdDetailViewController.h"
#import "SecondDetailViewController.h"
#import "Event.h"
#import "House.h"

@interface BirdDetailViewController ()
- (void)configureView;
@end

@implementation BirdDetailViewController

#pragma mark - Managing the detail item

- (void)setEvent:(Event *)event
{
    if (_event != event) {
        _event = event;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    Event *e = self.event;
    
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    
    if (e) {
        self.eventNameLabel.text = e.eventName;
        [self.eventHouseButton setTitle:e.house.name forState:UIControlStateNormal];
        self.eventDescriptionLabel.text = e.description;
        self.eventDateLabel.text = [formatter stringFromDate:e.date];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    BOOL notificationExists = NO;
    for (UILocalNotification *localNotification in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        if ([[localNotification.userInfo objectForKey:@"name"] isEqualToString:self.event.eventName]) {
            notificationExists = YES;
            break;
        }
    }
    if (notificationExists) {
        [self.reminderButton setTitle:@"Remove Reminder" forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reminderButtonPress:(id)sender{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UILocalNotification *notification = (UILocalNotification *)[NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:self.event.eventName]];
    
    BOOL notificationExists = NO;
    for (UILocalNotification *localNotification in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        if ([[localNotification.userInfo objectForKey:@"name"] isEqualToString:self.event.eventName]) {
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
            [self.reminderButton setTitle:@"Remind 1 Hour Before Event" forState:UIControlStateNormal];
            self.event.reminder = NO;
            notificationExists = YES;
            break;
        }
    }
    if (!notificationExists) {
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        [self.reminderButton setTitle:@"Cancel Reminder" forState:UIControlStateNormal];
        self.event.reminder = YES;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"HouseInfoSegue"]) {
        SecondDetailViewController *detailViewController = [segue destinationViewController];
        
        detailViewController.house = self.event.house;
    }
}


@end
