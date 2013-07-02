//
//  User.m
//  WsTest
//
//  Created by Air on 28/06/13.
//  Copyright (c) 2013 Air. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize name;
@synthesize email;
@synthesize birth_year;

- (id) initWithName:(NSString *) n{
    return [self initWithName:n andEmail:@""];
}

- (id) initWithName:(NSString *) n andEmail:(NSString *)e{
    return [self initWithName:n andEmail:@"" andBirthYear:@""];
}

- (id) initWithName:(NSString *) n andEmail:(NSString *)e andBirthYear:(NSString *)b{
    if (self = [super init]) {
        self.name = n;
        self.email = e;
        self.birth_year=b;
    }
    return self;
}

@end
