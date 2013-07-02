//
//  User.h
//  WsTest
//
//  Created by Air on 28/06/13.
//  Copyright (c) 2013 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    @public NSString *name;
    NSString *email;
    NSString *birth_year;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *birth_year;

- (id) initWithName:(NSString *) n;

- (id) initWithName:(NSString *) n andEmail:(NSString *)e;

- (id) initWithName:(NSString *) n andEmail:(NSString *)e andBirthYear:(NSString *)b;

@end
