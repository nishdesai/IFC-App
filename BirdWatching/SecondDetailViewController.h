//
//  SecondDetailViewController.h
//  SecondWatching
//
//  Created by Nishant Desai on 8/5/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class House;

@interface SecondDetailViewController : UIViewController


@property (nonatomic, retain) House *house;
@property (weak, nonatomic) IBOutlet UILabel *houseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseBioLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseGreekLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;


@end
