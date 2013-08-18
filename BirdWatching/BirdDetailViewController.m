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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"HouseInfoSegue"]) {
        SecondDetailViewController *detailViewController = [segue destinationViewController];
        
        detailViewController.house = self.event.house;
    }
}


@end
