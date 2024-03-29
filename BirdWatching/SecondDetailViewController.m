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
#import "UIFont+FlatUI.h"


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
        self.view.backgroundColor = [UIColor cloudsColor];
        self.rushChairName.text = h.rushChairName;
        self.rushChairNumber.text = h.rushChairPhoneNumber;
        self.rushChair.text = [h.rushChairName stringByAppendingString:[NSString stringWithFormat:@" %@", h.rushChairPhoneNumber]];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    if (self.house.greek) {
        self.navigationItem.title = self.house.greek;
    } else {
        self.navigationItem.title = self.house.name;
    }
    self.houseNameLabel.font = [UIFont flatFontOfSize:30];
    
    
    self.houseBioLabel.numberOfLines = 0;
    [self.houseBioLabel sizeToFit];
    self.houseBioLabel.font = [UIFont flatFontOfSize:16];
    
    self.rushChairHeader.font = [UIFont flatFontOfSize:16];
    
    self.houseAddressLabel.numberOfLines = 0;
    [self.houseAddressLabel sizeToFit];
    self.houseAddressLabel.font = [UIFont flatFontOfSize:14]; 
    
    self.rushChair.font = [UIFont flatFontOfSize:14];
    
    // Style mapButton
    self.mapButton.buttonColor = [UIColor peterRiverColor];
    self.mapButton.shadowColor = [UIColor wetAsphaltColor];
    self.mapButton.shadowHeight = 3.0f;
    self.mapButton.cornerRadius = 6.0f;
    self.mapButton.titleLabel.font = [UIFont flatFontOfSize:22];
    [self.mapButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.mapButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    // Style eventsButton
    self.eventsButton.buttonColor = [UIColor peterRiverColor];
    self.eventsButton.shadowColor = [UIColor wetAsphaltColor];
    self.eventsButton.shadowHeight = 3.0f;
    self.eventsButton.cornerRadius = 6.0f;
    self.eventsButton.titleLabel.font = [UIFont flatFontOfSize:22];
    [self.eventsButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.eventsButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
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
        [masterViewController.dataController createSections];
    } else if ([[segue identifier] isEqualToString:@"HouseMapSegue"]){
        MapViewController *mapView = [segue destinationViewController];
        mapView.house = self.house;
    }
}


@end
