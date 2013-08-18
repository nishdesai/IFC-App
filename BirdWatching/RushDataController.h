//
//  RushDataController.h
//  BirdWatching
//
//  Created by Nishant Desai on 8/5/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@class House;
@class Event;

@interface RushDataController : NSObject


@property (nonatomic, copy) NSMutableArray *houses;
@property (nonatomic, copy) NSMutableArray *events;
@property BOOL hasFavoriteHouses;
@property (nonatomic, copy) NSMutableArray *eventsForDay;

- (NSUInteger)countOfHouses;
- (NSUInteger)countOfEvents;

- (House *)objectInHousesAtIndex:(NSUInteger)index;
- (Event *)objectInEventsAtIndex:(NSUInteger)index;

- (void)addHousewithHouse:(House *)house;
- (void)addEventwithEvent:(Event *)event;

- (void)reloadLists;

@end
