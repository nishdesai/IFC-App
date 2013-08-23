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
    
    [panoView_ moveNearCoordinate:CLLocationCoordinate2DMake(37.867773, -122.254114)];
    panoView_.camera = [GMSPanoramaCamera cameraWithHeading:100
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
