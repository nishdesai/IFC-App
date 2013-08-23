//
//  RushDataController.m
//  BirdWatching
//
//  Created by Nishant Desai on 8/5/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "RushDataController.h"
#import "House.h"
#import "Event.h"


@implementation RushDataController



-(void)initializeDefaultDataLists {
        
    NSMutableArray *houseList = [[NSMutableArray alloc] init];
    NSMutableArray *eventList = [[NSMutableArray alloc] init];
    self.events = eventList;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    NSData *temp = [defaults objectForKey:@"houseArray"];
    NSMutableArray *houseArray = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:temp];
    if (temp == nil) {
        NSLog(@"temp is nil");
    } else {
        NSLog([NSString stringWithFormat:@"%d", [houseArray count]]);
        self.houses = houseArray;
    }
    
    NSDictionary *data;
    NSData *jsonPage = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ucb-ifc.herokuapp.com/home.json"]];
    if (jsonPage != nil) {
        data = [NSJSONSerialization JSONObjectWithData:jsonPage
                                                options:NSJSONReadingMutableContainers
                                                  error:nil];
    }
    
    if (data) {
        for (id key in data) {
            NSLog(@"looping");
            NSMutableArray *houseEvents = [[NSMutableArray alloc] init];
            NSDictionary *subDictionary = [data objectForKey:key];
            NSString *name = [subDictionary objectForKey:@"name"];
            NSString *bio = [subDictionary objectForKey:@"bio"];
            NSString *address = [subDictionary objectForKey:@"address"];
            NSNumber *latitude = [subDictionary objectForKey:@"latitude"];
            NSNumber *longitude = [subDictionary objectForKey:@"longitude"];
//            NSInteger *cameraHeading = [subDictionary objectForKey:@"heading"];
            NSString *rushChairName = [subDictionary objectForKey:@"rushchair_name"];
            NSString *rushChairNumber = [subDictionary objectForKey:@"rushchair_phone_number"];
            House *house = [[House alloc] initWithName:name
                                                andBio:bio
                                            andAddress:address];
            house.latitude = latitude;
            house.longitude = longitude;
//            house.cameraHeading = cameraHeading;
            house.rushChairName = rushChairName;
            house.rushChairPhoneNumber = rushChairNumber;
            
            NSArray *calendar = [subDictionary objectForKey:@"calendar"];
            
            for (NSDictionary *houseEvent in calendar) {
                
                NSString *eventName = [houseEvent objectForKey:@"name"];
                NSString *eventDescription = [houseEvent objectForKey:@"description"];
                
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                //Change JSON event date/times to this format.
                [df setDateFormat:@"dd/MM/yyyy hh:mm"];
                NSString *dateString = [houseEvent objectForKey:@"time"];
                NSDate *eventDate = [df dateFromString:dateString];
                
                Event *event = [[Event alloc] initWithHouse:house
                                                    andName: eventName
                                                    andDate:eventDate
                                             andDescription:eventDescription];
                
                if ([eventDate timeIntervalSinceNow] >= 0) {
                    [houseEvents addObject:event];
                }
            }
            house.events = houseEvents;
            [houseList addObject:house];
            if ([houseEvents count] > 0) {
                [self.events addObjectsFromArray:houseEvents];
            }
            
            if ([self.houses count] > 0) {
                BOOL isInHouseList = NO;
                for (House *h in self.houses) {
                    if ([h.name isEqualToString:house.name]){
                        h.events = house.events;
                        isInHouseList = YES;
                        break;
                    }
                }
                if (!isInHouseList) {
                    [self.houses addObject:house];
                }
            }
        }
        
        [defaults setObject:self.events forKey:@"eventsArray"];
        [defaults setObject:self.houses forKey:@"houseArray"];
        [defaults synchronize];
        
        if ([self.houses count] == 0) {
            self.houses = houseList;
        }
        
    } else if ([defaults objectForKey:@"eventsArray"] != nil){
        self.events = [defaults objectForKey:@"eventsArray"];
    } else {
        self.events = [NSMutableArray arrayWithObject:[[Event alloc] initWithHouse:nil andName:@"Data Loading Error" andDate:nil andDescription:nil]];
    }

    

// UNCOMMENT THE FOLLOWING BLOCK WHEN DATE FORMAT IS FIXED;
    
   NSDate *prevDate;
   int numOfEvents = 0;
   for (int i = 0; i < [self.events count]; i++) {
       if (prevDate == nil || [((Event *)[self.events objectAtIndex:i]).date isEqual:prevDate]) {
            numOfEvents++;
        } else {
            [self.eventsForDay addObject:[NSNumber numberWithInt:numOfEvents]];
            numOfEvents = 0;
            prevDate = ((Event *)[self.events objectAtIndex:i]).date;
        }
    }
    [self.eventsForDay addObject:[NSNumber numberWithInt:numOfEvents]];
    
    self.events = (NSMutableArray *)[self.events sortedArrayUsingSelector:@selector(compareByDate:)];
}


-(void)reloadLists {
    NSMutableArray *eventList = [[NSMutableArray alloc] init];
    self.events = eventList;
    
    
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ucb-ifc.herokuapp.com/home.json"]]
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
    
    if (data) {
        for (id key in data) {
            NSMutableArray *houseEvents = [[NSMutableArray alloc] init];
            NSDictionary *subDictionary = [data objectForKey:key];
            NSString *name = [subDictionary objectForKey:@"name"];
            NSString *bio = [subDictionary objectForKey:@"bio"];
            NSString *address = @"address placeholder";
            House *house = [[House alloc] initWithName:name
                                                andBio:bio
                                            andAddress:address];
            
            NSArray *calendar = [subDictionary objectForKey:@"calendar"];
            
            for (NSDictionary *houseEvent in calendar) {
                
                NSString *eventName = [houseEvent objectForKey:@"name"];
                NSString *eventDescription = [houseEvent objectForKey:@"description"];
                
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                //Change JSON event date/times to this format.
                [df setDateFormat:@"dd/MM/yyyy hh:mm a"];
                NSString *dateString = [houseEvent objectForKey:@"time"];
                NSDate *eventDate = [df dateFromString:dateString];
                
                Event *event = [[Event alloc] initWithHouse:house
                                                    andName: eventName
                                                    andDate:eventDate
                                             andDescription:eventDescription];
                if ([eventDate timeIntervalSinceNow] >= 0) {
                    [houseEvents addObject:event];
                }
            }
            
            for (House *h in self.houses) {
                if ([h.name isEqualToString:house.name]){
                    h.events = house.events;
                    break;
                }
            }
            
            if ([houseEvents count] > 0){
                [self.events addObjectsFromArray:houseEvents];
            }
        }
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.events forKey:@"eventsArray"];
        [defaults synchronize];
    }
    
    // UNCOMMENT THE FOLLOWING BLOCK WHEN DATE FORMAT IS FIXED;
    
       NSDate *prevDate;
       int numOfEvents = 0;
       for (int i = 0; i < [self.events count]; i++) {
           if (prevDate == nil || [((Event *)[self.events objectAtIndex:i]).date isEqual:prevDate]) {
                numOfEvents++;
            } else {
                [self.eventsForDay addObject:[NSNumber numberWithInt:numOfEvents]];
                numOfEvents = 0;
                prevDate = ((Event *)[self.events objectAtIndex:i]).date;
            }
        }
        [self.eventsForDay addObject:[NSNumber numberWithInt:numOfEvents]];
    
    self.events = (NSMutableArray *)[self.events sortedArrayUsingSelector:@selector(compareByDate:)];

}

-(void)setHouses:(NSMutableArray *)houses {
    if(_houses != houses) {
        _houses = [houses mutableCopy];
    }
}

-(void)setEvents:(NSMutableArray *)events {
    if(_events != events) {
        _events = [events mutableCopy];
    }
}

-(id)init {
    if (self = [super init]) {
        [self initializeDefaultDataLists];
        return self;
    }
    return nil;
}



-(NSUInteger)countOfHouses {
    return [self.houses count];
}

-(NSUInteger)countOfEvents {
    return [self.events count];
}

-(House *)objectInHousesAtIndex:(NSUInteger)index {
    return [self.houses objectAtIndex:index];
}

-(Event *)objectInEventsAtIndex:(NSUInteger)index {
    return [self.events objectAtIndex:index];
}

-(void)addHousewithHouse:(House *)house {
    [self.houses addObject:house];
}

-(void)addEventwithEvent:(Event *)event {
    [self.events addObject:event];
}


@end
