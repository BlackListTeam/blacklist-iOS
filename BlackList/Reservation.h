//
//  Reservation.h
//  WsTest
//
//  Created by Air on 28/06/13.
//  Copyright (c) 2013 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reservation : NSObject
{
    @public int escorts;
    Boolean vip;
    int rooms;
    NSString *qr;
}

@property (nonatomic) int escorts;
@property (nonatomic) Boolean vip;
@property (nonatomic) int rooms;
@property (nonatomic, retain) NSString *qr;

- (id) initWithEscorts:(int) e;

- (id) initWithEscorts:(int) e andVip:(Boolean) v;

- (id) initWithEscorts:(int) e andVip:(Boolean) v andRooms:(int) r;

- (id) initWithEscorts:(int) e andVip:(Boolean) v andRooms:(int) r andQr:(NSString *) q;


@end