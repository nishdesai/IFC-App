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
@property (nonatomic, copy) NSString *greek;
@property (nonatomic, copy) NSNumber *latitude;
@property (nonatomic, copy) NSNumber *longitude;
@property (nonatomic) NSInteger cameraHeading;
@property (nonatomic, copy) NSString *rushChairName;
@property (nonatomic, copy) NSString *rushChairPhoneNumber;

-(id)initWithName:(NSString *)name andBio:(NSString *)bio andAddress:(NSString *)address;
- (void)encodeWithCoder:(NSCoder *)coder;
- (id)initWithCoder:(NSCoder *)coder;

@end
