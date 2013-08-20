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
    
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"HouseList.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"HouseList" ofType:@"plist"];
    }
    
    NSMutableArray *temp = [NSMutableArray arrayWithContentsOfFile:plistPath];
    if (temp) {
        self.houses = temp;
    }
    
    
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
                
                [houseEvents addObject:event];
            }
            
            house.events = houseEvents;
            [houseList addObject:house];
            [self.events addObjectsFromArray:houseEvents];
            
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
        
        if ([self.houses count] == 0) {
            self.houses = houseList;
        }
    }

    

// UNCOMMENT THE FOLLOWING BLOCK WHEN DATE FORMAT IS FIXED;
    
//   NSDate *prevDate;
//   int numOfEvents = 0;
//   for (int i = 0; i < [self.events count]; i++) {
//       if (prevDate == nil || [((Event *)[self.events objectAtIndex:i]).date isEqual:prevDate]) {
//            numOfEvents++;
//        } else {
//            [self.eventsForDay addObject:[NSNumber numberWithInt:numOfEvents]];
//            numOfEvents = 0;
//            prevDate = ((Event *)[self.events objectAtIndex:i]).date;
//        }
//    }
//    [self.eventsForDay addObject:[NSNumber numberWithInt:numOfEvents]];
    
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
                
                [houseEvents addObject:event];
            }
            
            for (House *h in self.houses) {
                if ([h.name isEqualToString:house.name]){
                    h.events = house.events;
                    break;
                }
            }
            [self.events addObjectsFromArray:houseEvents];
        }
        
    }
    
    // UNCOMMENT THE FOLLOWING BLOCK WHEN DATE FORMAT IS FIXED;
    
    //   NSDate *prevDate;
    //   int numOfEvents = 0;
    //   for (int i = 0; i < [self.events count]; i++) {
    //       if (prevDate == nil || [((Event *)[self.events objectAtIndex:i]).date isEqual:prevDate]) {
    //            numOfEvents++;
    //        } else {
    //            [self.eventsForDay addObject:[NSNumber numberWithInt:numOfEvents]];
    //            numOfEvents = 0;
    //            prevDate = ((Event *)[self.events objectAtIndex:i]).date;
    //        }
    //    }
    //    [self.eventsForDay addObject:[NSNumber numberWithInt:numOfEvents]];
    
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
