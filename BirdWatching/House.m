//
//  House.m
//  BirdWatching
//
//  Created by Nishant Desai on 8/5/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "House.h"

@implementation House : NSObject


-(id)initWithName:(NSString *)name andBio:(NSString *)bio andAddress:(NSString *)address {
    
    self = [super init];
    
    NSArray *letters = [NSArray arrayWithObjects:@"Alpha", @"Beta", @"Gamma", @"Delta", @"Epsilon", @"Zeta", @"Eta", @"Theta", @"Iota", @"Kappa", @"Lambda", @"Mu", @"Nu", @"Xi", @"Omicron", @"Pi", @"Rho", @"Sigma", @"Tau", @"Upsilon", @"Phi", @"Chi", @"Psi", @"Omega", @"Tao", nil];
    
    NSArray *unicodeLetters = [NSArray arrayWithObjects:@"\u0391", @"\u0392", @"\u0393", @"\u0394", @"\u0395", @"\u0396", @"\u0397", @"\u0398", @"\u0399", @"\u039a", @"\u039b", @"\u039c", @"\u039d", @"\u039e", @"\u039f", @"\u03a0", @"\u03a1", @"\u03a3", @"\u03a4", @"\u03a5", @"\u03a6", @"\u03a7", @"\u03a8", @"\u03a9", @"\u03a4", nil];
    
    
    NSDictionary *greekLetters = [NSDictionary dictionaryWithObjects:unicodeLetters forKeys:letters];
    
    
    if (self) {
        _name = name;
        _bio = bio;
        _address = address;
        _events = nil;
        
        NSMutableArray *splitName = (NSMutableArray *)[name componentsSeparatedByString:@" "];
        NSMutableArray *greekNameArray = [[NSMutableArray alloc] init];
        for (NSString *letter in splitName) {
            if ([greekLetters objectForKey:letter] != nil) {
                [greekNameArray addObject:[greekLetters objectForKey:letter]];
            }
        }
        
        if ([greekNameArray count] == [splitName count]) {
            _greek = [greekNameArray componentsJoinedByString:@""];
        }
        
        return self;
    }
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.address forKey:@"address"];
    [coder encodeObject:self.bio forKey:@"bio"];
    [coder encodeObject:self.greek forKey:@"greek"];
    [coder encodeObject:self.events forKey:@"events"];
    [coder encodeObject:self.latitude forKey:@"latutude"];
    [coder encodeObject:self.longitude forKey:@"longitude"];
    [coder encodeInt:self.cameraHeading forKey:@"heading"];
    [coder encodeObject:self.rushChairName forKey:@"ruchChairName"];
    [coder encodeObject:self.rushChairPhoneNumber forKey:@"rushChairNumber"];
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [[House alloc] init];
    if (self != nil)
    {
        self.name = [coder decodeObjectForKey:@"name"];
        self.address = [coder decodeObjectForKey:@"address"];
        self.bio = [coder decodeObjectForKey:@"bio"];
        self. greek = [coder decodeObjectForKey:@"greek"];
        self.events = [coder decodeObjectForKey:@"events"];
        self.latitude = [coder decodeObjectForKey:@"latitude"];
        self.longitude = [coder decodeObjectForKey:@"longitude"];
        self.cameraHeading = [coder decodeIntegerForKey:@"heading"];
        self.rushChairName = [coder decodeObjectForKey:@"rushChairName"];
        self.rushChairPhoneNumber = [coder decodeObjectForKey:@"rushChairNumber"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    House *newHouse = [[[self class] allocWithZone:zone] init];
    if(newHouse) {
        [newHouse setName:[self name]];
        [newHouse setAddress:[self address]];
        [newHouse setBio:[self bio]];
        [newHouse setGreek:[self greek]];
        [newHouse setEvents:[self events]];
        [newHouse setLatitude:[self latitude]];
        [newHouse setLongitude:[self longitude]];
        [newHouse setCameraHeading:[self cameraHeading]];
        [newHouse setRushChairName:[self rushChairName]];
        [newHouse setRushChairPhoneNumber:[self rushChairPhoneNumber]];
    }
    return newHouse;
}

@end
