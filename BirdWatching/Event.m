//
//  Event.m
//  BirdWatching
//
//  Created by Nishant Desai on 8/5/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "Event.h"
#import "House.h"

@implementation Event

-(id)initWithHouse:(House *)house andName:(NSString *)name andDate:(NSDate *)date andDescription:(NSString *)description {
    self = [super init];
    if (self){
        _house = house;
        _eventName = name;
        _date = date;
        _description = description;
        _houseName = house.name;
        _reminder = NO;
        
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [date dateByAddingTimeInterval:-3600];
        notification.alertBody = [NSString stringWithFormat:@"%@ at %@ in 1 hour", name, house.greek];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.userInfo = [NSDictionary dictionaryWithObject:name forKey:@"name"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:notification];
        [defaults setObject:data forKey:name];
        [defaults synchronize];
        
        
        
        return self;
    }
    return nil;
}

- (NSComparisonResult)compareByDate:(Event *)otherObject {
    return [self.date compare:otherObject.date];
}

-(void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.eventName forKey:@"eventName"];
    [coder encodeObject:self.date forKey:@"date"];
    [coder encodeObject:self.description forKey:@"description"];
    [coder encodeObject:self.houseName forKey:@"houseName"];
    
}

-(id)initWithCoder:(NSCoder *)coder {
    self = [[Event alloc] init];
    if (self != nil)
    {
        self.date = [coder decodeObjectForKey:@"date"];
        self.eventName = [coder decodeObjectForKey:@"eventName"];
        self.description = [coder decodeObjectForKey:@"description"];
        self.houseName = [coder decodeObjectForKey:@"houseName"];
    }
    return self;
}

@end
