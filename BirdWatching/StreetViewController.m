//
//  StreetViewController.m
//  BirdWatching
//
//  Created by Alon Daks on 8/22/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "StreetViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "House.h"

@interface StreetViewController ()

@end

@implementation StreetViewController{
    GMSPanoramaView *panoView_;
}

- (void)loadView {
    panoView_ = [[GMSPanoramaView alloc] initWithFrame:CGRectZero];
    self.view = panoView_;
    
    double lat = [self.house.latitude doubleValue];
    double lon = [self.house.longitude doubleValue];
    
    [panoView_ moveNearCoordinate:CLLocationCoordinate2DMake(lat, lon)];
    panoView_.camera = [GMSPanoramaCamera cameraWithHeading:(int)self.house.cameraHeading
                                                      pitch:0
                                                       zoom:1];
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
    self.navigationItem.title = [self.house.greek stringByAppendingString:@" Street View"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
