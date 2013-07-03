//
//  webServiceCaller.h
//  BlackList
//
//  Created by Air on 01/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Party.h"
#import "Reservation.h"

@interface webServiceCaller : NSObject
{
    NSURLConnection *conn;
}


+ (void) validatePromoterCode:(NSString *) promoterCode andDelegateTo:(id) delegator;

+ (void) addUser: (User *) user withPromoterCode: (NSString *) promoterCode andDelegateTo:(id) delegator;

+ (void) login: (NSString *) name withPassword: (NSString *) password andDelegateTo:(id) delegator;

+ (void) getPartyCovers: (NSString *) sessionId andDelegateTo:(id) delegator;

+ (void) getParty: (int) partyId withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator;

+ (void) getPartyGallery: (int) partyId withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator;

+ (void) getCurrentReservation: (NSString *) sessionId andDelegateTo:(id) delegator;

+ (void) makeReservation: (Reservation *) reservation withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator;

+ (void) editReservation: (Reservation *) reservation withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator;

+ (void) deleteReservation: (NSString *) sessionId andDelegateTo:(id) delegator;

+ (void) getMessages: (NSString *) sessionId andDelegateTo:(id) delegator;

+ (void) replyMessage: (NSString *) message inMessageStreamId: (int) messageStreamId withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator;

+ (void) sendInvitation: (NSString *) email withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator;

+ (void) getUserQr: (NSString *) sessionId andDelegateTo:(id) delegator;

@end
