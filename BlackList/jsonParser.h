//
//  jsonParser.h
//  BlackList
//
//  Created by Air on 01/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@interface jsonParser : NSObject
{
    Boolean authError;
    NSString *errorMessage;
}

+ (Boolean) parseValidatePromoterCode:(NSMutableData *) webData;

@end
