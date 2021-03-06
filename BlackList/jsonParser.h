//
//  jsonParser.h
//  BlackList
//
//  Created by Air on 01/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "Party.h"
#import "Reservation.h"
#import "MessageThread.h"
#import "Message.h"

@interface jsonParser : NSObject
{
    Boolean authError;
    NSString *errorMessage;
}

+ (Boolean) authError;

+ (NSString *) errorMessage;

+ (Boolean) parseValidatePromoterCode:(NSMutableData *) webData;

+ (Boolean) parseAddUser:(NSMutableData *) webData;

+ (NSString *) parseLogin:(NSMutableData *) webData;

+ (NSMutableArray *) parseGetPartyCovers:(NSMutableData *) webData;
/*
+ (Boolean) parseGetParty:(NSMutableData *) webData;

+ (Boolean) parseGetPartyGallery:(NSMutableData *) webData;
*/
+ (Reservation *) parseGetCurrentReservation:(NSMutableData *) webData;

+ (Boolean) parseMakeReservation:(NSMutableData *) webData;

+ (Boolean) parseEditReservation:(NSMutableData *) webData;

+ (Boolean) parseDeleteReservation:(NSMutableData *) webData;

+ (NSMutableArray *) parseGetMessages:(NSMutableData *) webData;

+ (Boolean) parseReplyMessage:(NSMutableData *) webData;

+ (Boolean) parseAddMessage:(NSMutableData *) webData;

+ (Boolean) parseDeleteMessage:(NSMutableData *) webData;

+ (Boolean) parseSendInvitation:(NSMutableData *) webData;

+ (NSString *) parseGetUserQr: (NSMutableData *) webData;

+ (int) parseGetNewMessages: (NSMutableData *) webData;



@end
