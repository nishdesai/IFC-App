//
//  House.h
//  BirdWatching
//
//  Created by Nishant Desai on 8/5/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface House : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *bio;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSMutableArray *events;
@property (nonatomic) BOOL isFavorite;

-(id)initWithName:(NSString *)name andBio:(NSString *)bio andAddress:(NSString *)address;

@end
