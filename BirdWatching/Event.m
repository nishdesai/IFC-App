//
//  Event.m
//  BirdWatching
//
//  Created by Nishant Desai on 8/5/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "Event.h"

@implementation Event

-(id)initWithHouse:(House *)house andName:(NSString *)name andDate:(NSDate *)date andDescription:(NSString *)description {
    self = [super init];
    if (self){
        _house = house;
        _eventName = name;
        _date = date;
        _description = description;
        return self;
    }
    return nil;
}

@end
