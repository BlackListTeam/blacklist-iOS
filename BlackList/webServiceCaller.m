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

+ (void) addUser: (User *) user withPromoterCode: (NSString *) promoterCode andDelegateTo:(id) delegator
{
    NSString *postStr = [NSString stringWithFormat:@"promoter_code=%@&name=%@&email=%@&birth_year=%@"
                         ,promoterCode, [user.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],user.email,user.birth_year];

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

+ (void) login: (NSString *) name withPassword: (NSString *) password andDelegateTo:(id) delegator
{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/login?name=%@&password=%@",[name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],password];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) getPartyCovers: (NSString *) sessionId andDelegateTo:(id) delegator
{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/getPartyCovers?session_id=%@",sessionId];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}
/*
+ (void) getParty: (int) partyId withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator
{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/getParty?party_id=%d&session_id=%@",partyId,sessionId];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) getPartyGallery: (int) partyId withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator
{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/getPartyGallery?party_id=%d&session_id=%@",partyId,sessionId];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}
*/
+ (void) getCurrentReservation: (NSString *) sessionId andDelegateTo:(id) delegator
{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/getCurrentReservation?session_id=%@",sessionId];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) makeReservation: (Reservation *) reservation withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator
{
    NSString *postStr = [NSString stringWithFormat:@"escorts=%d&vip=%c&rooms=%d&session_id=%@"
                         ,reservation.escorts,reservation.vip,reservation.rooms,sessionId];
    NSURL *url = [NSURL URLWithString:@"http://www.blacklistmeetings.com/ws/makeReservation"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    NSString *strLength = [NSString stringWithFormat:@"%d", [postStr length]];
    [req addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content- Type"];
    [req addValue:strLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [postStr dataUsingEncoding:NSUTF8StringEncoding]];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) editReservation: (Reservation *) reservation withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator
{
    NSString *postStr = [NSString stringWithFormat:@"escorts=%d&vip=%c&rooms=%d&session_id=%@"
                         ,reservation.escorts,reservation.vip,reservation.rooms,sessionId];
    NSURL *url = [NSURL URLWithString:@"http://www.blacklistmeetings.com/ws/editReservation"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    NSString *strLength = [NSString stringWithFormat:@"%d", [postStr length]];
    [req addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content- Type"];
    [req addValue:strLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [postStr dataUsingEncoding:NSUTF8StringEncoding]];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) deleteReservation: (NSString *) sessionId andDelegateTo:(id) delegator
{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/deleteReservation?session_id=%@",sessionId];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) getMessages: (NSString *) sessionId andDelegateTo:(id) delegator
{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/getMessages?session_id=%@",sessionId];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) replyMessage: (NSString *) message inMessageStreamId: (int) messageStreamId withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator
{
    NSString *postStr = [NSString stringWithFormat:@"message=%@&message_stream_id=%d&session_id=%@"
                         ,[message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],messageStreamId,sessionId];
    NSURL *url = [NSURL URLWithString:@"http://www.blacklistmeetings.com/ws/replyMessage"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    NSString *strLength = [NSString stringWithFormat:@"%d", [postStr length]];
    [req addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content- Type"];
    [req addValue:strLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [postStr dataUsingEncoding:NSUTF8StringEncoding]];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) addMessage: (NSString *) message withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator
{
    NSString *postStr = [NSString stringWithFormat:@"message=%@&session_id=%@"
                         ,[message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],sessionId];
    NSURL *url = [NSURL URLWithString:@"http://www.blacklistmeetings.com/ws/addMessage"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    NSString *strLength = [NSString stringWithFormat:@"%d", [postStr length]];
    [req addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content- Type"];
    [req addValue:strLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [postStr dataUsingEncoding:NSUTF8StringEncoding]];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) deleteMessage: (int) m_id withSessionId:(NSString *) sessionId andDelegateTo:(id) delegator
{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/deleteMessage?message_stream_id=%d&session_id=%@",m_id,sessionId];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];

}

+ (void) sendInvitation: (NSString *) email withSessionId: (NSString *) sessionId andDelegateTo:(id) delegator
{
    NSString *postStr = [NSString stringWithFormat:@"email=%@&session_id=%@"
                         ,email,sessionId];
    NSURL *url = [NSURL URLWithString:@"http://www.blacklistmeetings.com/ws/sendInvitation"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    NSString *strLength = [NSString stringWithFormat:@"%d", [postStr length]];
    [req addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content- Type"];
    [req addValue:strLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [postStr dataUsingEncoding:NSUTF8StringEncoding]];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) getUserQr: (NSString *) sessionId andDelegateTo:(id) delegator
{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/getUserQr?session_id=%@",sessionId];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) getNewMessages: (NSString *) sessionId andDelegateTo:(id) delegator
{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/getNewMessages?session_id=%@",sessionId];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

+ (void) readMessages: (NSString *) sessionId andDelegateTo:(id) delegator
{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/readMessages?session_id=%@",sessionId];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
}

@end
