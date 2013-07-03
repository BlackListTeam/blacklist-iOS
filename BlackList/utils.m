//
//  utils.m
//  BlackList
//
//  Created by Air on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "utils.h"

static NSString *userAllowDocName=@"allowUse.txt";

@implementation utils

+ (Boolean) userAllowedToUseApp
{
    Boolean ret=false;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    NSString *fileName =
        [documentsDir stringByAppendingPathComponent:@"data.txt"];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        ret=true;
    }    
    return ret;
}


+ (void) allowUserToUseApp
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    NSString *fileName =
    [documentsDir stringByAppendingPathComponent:@"data.txt"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:@"Allowed"];
    [array writeToFile:fileName atomically:YES];
}

@end
