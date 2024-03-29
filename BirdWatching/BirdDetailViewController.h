//
//  BirdDetailViewController.h
//  BirdWatching
//
//  Created by Nishant Desai on 8/5/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FUIButton.h"

@class Event;

@interface BirdDetailViewController : UIViewController

@property (strong, nonatomic) Event *event;
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet FUIButton *eventHouseButton;
@property (weak, nonatomic) IBOutlet UILabel *eventDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDateLabel;
@property (weak, nonatomic) IBOutlet FUIButton *reminderButton;

-(IBAction)reminderButtonPress:(id)sender;

@end
