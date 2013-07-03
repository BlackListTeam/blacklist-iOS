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

- (id) initWithEscorts:(int) e andVip:(Boolean) v{
    return [self initWithEscorts:e andVip:false andRooms:0];
}

- (id) initWithEscorts:(int) e andVip:(Boolean) v andRooms:(int) r{
    return [self initWithEscorts:e andVip:false andRooms:0 andQr:@""];
}

- (id) initWithEscorts:(int) e andVip:(Boolean) v andRooms:(int) r andQr:(NSString *) q{
    if (self = [super init]) {
        self.escorts = e;
        self.vip = v;
        self.rooms=r;
        self.qr=q;
    }
    return self;
}

@end
