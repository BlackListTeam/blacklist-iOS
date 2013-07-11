//
//  Reservation.m
//  WsTest
//
//  Created by Air on 28/06/13.
//  Copyright (c) 2013 Air. All rights reserved.
//

#import "Reservation.h"

@implementation Reservation

@synthesize escorts;
@synthesize vip;
@synthesize rooms;
@synthesize qr;

- (id) initWithEscorts:(int) e{
    return [self initWithEscorts:e andVip:false];
}

- (id) initWithEscorts:(int) e andVip:(int) v{
    return [self initWithEscorts:e andVip:v andRooms:0];
}

- (id) initWithEscorts:(int) e andVip:(int) v andRooms:(int) r{
    NSLog(@"Var1 %d",v);
    return [self initWithEscorts:e andVip:v andRooms:r andQr:@""];
}

- (id) initWithEscorts:(int) e andVip:(int) v andRooms:(int) r andQr:(NSString *) q{
    NSLog(@"Var2 %d",v);
    if (self = [super init]) {
        self.escorts = e;
        self.vip = v;
        self.rooms=r;
        self.qr=q;
    }
    return self;
}

@end
