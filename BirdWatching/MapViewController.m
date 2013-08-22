//
//  MapViewController.m
//  BirdWatching
//
//  Created by Alon Daks on 8/22/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController ()

@end

@implementation MapViewController{
    GMSMapView *mapView_;
}


- (void)loadView {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:37.867773
                                                            longitude:-122.254114
                                                                 zoom:18];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;

    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(37.867773, -122.254114);
    marker.title = @"Sigma Chi";
    marker.map = mapView_;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
