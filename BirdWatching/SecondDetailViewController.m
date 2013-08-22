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
#import <GoogleMaps/GoogleMaps.h>

@interface SecondDetailViewController ()
- (void)configureView;
@end

@implementation SecondDetailViewController{
    GMSMapView *mapView_;
}

- (void)loadView {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;
}

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
    }
}


@end
