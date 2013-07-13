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
    int vip;
    int rooms;
    NSString *qr;
}

@property (nonatomic) int escorts;
@property (nonatomic) int vip;
@property (nonatomic) int rooms;
@property (nonatomic, retain) NSString *qr;
@property (nonatomic, retain) NSString *party_name;

- (id) initWithEscorts:(int) e;

- (id) initWithEscorts:(int) e andVip:(int) v;

- (id) initWithEscorts:(int) e andVip:(int) v andRooms:(int) r;

- (id) initWithEscorts:(int) e andVip:(int) v andRooms:(int) r andQr:(NSString *) q;


@end