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
        self.view.backgroundColor = [UIColor cloudsColor];
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
    self.eventNameLabel.font = [UIFont systemFontOfSize:30];
    
    self.eventHouseButton.buttonColor = [UIColor tangerineColor];
    self.eventHouseButton.shadowColor = [UIColor wetAsphaltColor];
    self.eventHouseButton.shadowHeight = 3.0f;
    self.eventHouseButton.cornerRadius = 6.0f;
    self.eventHouseButton.titleLabel.font = [UIFont systemFontOfSize:22];
    [self.eventHouseButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.eventHouseButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.reminderButton.buttonColor = [UIColor tangerineColor];
    self.reminderButton.shadowColor = [UIColor wetAsphaltColor];
    self.reminderButton.shadowHeight = 3.0f;
    self.reminderButton.cornerRadius = 6.0f;
    self.reminderButton.titleLabel.font = [UIFont systemFontOfSize:22];
    [self.reminderButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.reminderButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.eventDescriptionLabel.numberOfLines = 0;
    [self.eventDescriptionLabel sizeToFit];
    
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
