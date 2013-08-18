//
//  Event.h
//  BirdWatching
//
//  Created by Nishant Desai on 8/5/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@class House;

@interface Event : NSObject

@property (nonatomic, copy) House *house;
@property (nonatomic, copy) NSString *eventName;
@property (nonatomic, copy) NSDate *date;
@property (nonatomic, copy) NSString *description;

-(id)initWithHouse:(House *)house andName:(NSString *)name andDate:(NSDate *)date andDescription:(NSString *)description;


@end
