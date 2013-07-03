//
//  utils.h
//  BlackList
//
//  Created by Air on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface utils : NSObject
{
    NSString *userAllowDocName;
    NSString *userDataDocName;
}

+ (Boolean) userAllowedToUseApp;

+ (void) allowUserToUseApp;

+ (NSString *) retriveUserName;

+ (void) saveUserName:(NSString *) name;

@end