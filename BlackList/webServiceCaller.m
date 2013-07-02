//
//  webServiceCaller.m
//  BlackList
//
//  Created by Air on 01/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "webServiceCaller.h"


static NSURLConnection *conn;


@implementation webServiceCaller

+ (void) validatePromoterCode:(NSString *) promoterCode andDelegateTo:(id)delegator
{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/validatePromoterCode?promoterCode=%@",promoterCode];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) addUser: (User *) user withPromoterCode: (NSString *) promoterCode andDelegateTo:(id) delegator{
    //promoter_code + name + email + birth_year
    NSString *postStr = [NSString stringWithFormat:@"promoter_code=%@&name=%@&email=%@&birth_year=%@"
                         ,promoterCode,user.name,user.email,user.birth_year];
    NSURL *url = [NSURL URLWithString:@"http://www.blacklistmeetings.com/ws/addUser"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    NSString *strLength = [NSString stringWithFormat:@"%d", [postStr length]];
    [req addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content- Type"];
    [req addValue:strLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [postStr dataUsingEncoding:NSUTF8StringEncoding]];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) login: (NSString *) email withPassword: (NSString *) password andDelegateTo:(id) delegator{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/login?email=%@&password=%@",email,password];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) getPartyCovers: (NSString *) sessionId andDelegateTo:(id) delegator{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/getPartyCovers?sessionId=%@",sessionId];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) getParty: (int) partyId withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/getParty?partyId=%d&sessionId=%@",partyId,sessionId];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) getPartyGallery: (int) partyId withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/getPartyGallery?partyId=%d&sessionId=%@",partyId,sessionId];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) getCurrentReservation: (NSString *) sessionId andDelegateTo:(id) delegator{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/getCurrentReservation?sessionId=%@",sessionId];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) makeReservation: (Reservation *) reservation withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator{
    
}

+ (void) editReservation: (Reservation *) reservation withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator{
    
}

+ (void) deleteReservation: (int) reservationId withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator{
    
}

+ (void) getMessages: (NSString *) sessionId andDelegateTo:(id) delegator{
    
}

+ (void) replyMessage: (NSString *) message inMessageStreamId: (int) messageStreamId withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator{
    
}

+ (void) sendInvitation: (NSString *) email withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator{
    
}

@end
