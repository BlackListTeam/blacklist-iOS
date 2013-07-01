//
//  webServiceCaller.h
//  BlackList
//
//  Created by Air on 01/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface webServiceCaller : NSObject
{
    NSURLConnection *conn;
}


+ (void) validatePromoterCode:(NSString *) promoterCode andDelegateTo:(id) delegator;

@end
