//
//  House.m
//  BirdWatching
//
//  Created by Nishant Desai on 8/5/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "House.h"

@implementation House

-(id)initWithName:(NSString *)name andBio:(NSString *)bio andAddress:(NSString *)address {
    self = [super init];
    if (self) {
        _name = name;
        _bio = bio;
        _address = address;
        _events = nil;
        _isFavorite = NO;
        return self;
    }
    return nil;
}

@end
