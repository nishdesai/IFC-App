//
//  SecondDetailViewController.m
//  SecondWatching
//
//  Created by Nishant Desai on 8/5/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "SecondDetailViewController.h"
#import "BirdMasterViewController.h"
#import "RushDataController.h"
#import "House.h"
#import "Event.h"
#import "MapViewController.h"

@interface SecondDetailViewController ()
- (void)configureView;
@end

@implementation SecondDetailViewController


#pragma mark - Managing the detail item

- (void)setHouse:(House *)house
{
    if (_house != house) {
        _house = house;
        
        // Update the view.
        [self configureView];
    }
}


- (void)configureView
{
    // Update the user interface for the detail item.
    
    House *h = self.house;
    
    if (h) {
        self.houseNameLabel.text = h.name;
        self.houseBioLabel.text = h.bio;
        self.houseAddressLabel.text = h.address;
        self.houseGreekLabel.text = h.greek;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    self.navigationItem.title = self.house.greek;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"HouseEventsSegue"]) {
        BirdMasterViewController *masterViewController = [segue destinationViewController];
        masterViewController.dataController.events = self.house.events;
    } else if ([[segue identifier] isEqualToString:@"HouseMapSegue"]){
        MapViewController *mapView = [segue destinationViewController];
        mapView.house = self.house;
    }
}


@end
