//
//  webServiceCaller.m
//  BlackList
//
//  Created by Air on 01/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "webServiceCaller.h"


static NSMutableData *webData;
static NSURLConnection *conn;


@implementation webServiceCaller

+ (void) validatePromoterCode:(NSString *) promoterCode andDelegateTo:(id)delegator
{
    NSString *queryURL =
    [NSString stringWithFormat:@"http://www.blacklistmeetings.com/ws/validatePromoterCode?promoterCode=%s","TEST123"];
    
    NSURL *url = [NSURL URLWithString: queryURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    conn = [[NSURLConnection alloc] initWithRequest:req
                                           delegate:delegator];
    if (conn) {
        webData = [NSMutableData data];
    }
}
@end
