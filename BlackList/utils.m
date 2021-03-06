//
//  utils.m
//  BlackList
//
//  Created by Air on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "utils.h"

static NSString *userAllowDocName=@"allowUse.txt";
static NSString *userDataDocName=@"userData.txt";

@implementation utils

+ (Boolean) userAllowedToUseApp
{
    Boolean ret=false;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    NSString *fileName =
    [documentsDir stringByAppendingPathComponent:userAllowDocName];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        ret=true;
    }
    return ret;
}


+ (void) allowUserToUseApp:(NSString *)promoterCode
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    NSString *fileName =
    [documentsDir stringByAppendingPathComponent:userAllowDocName];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:promoterCode];
    [array writeToFile:fileName atomically:YES];
}

+ (NSString *) retrivePromoterCode
{
    NSString *ret=@"";
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    NSString *fileName =
    [documentsDir stringByAppendingPathComponent:userAllowDocName];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        NSArray *array = [[NSArray alloc] initWithContentsOfFile: fileName];
        ret = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
    }
    return ret;
}

+ (NSString *) retriveUserName
{
    NSString *ret=@"Nombre";
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    NSString *fileName =
    [documentsDir stringByAppendingPathComponent:userDataDocName];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        NSArray *array = [[NSArray alloc] initWithContentsOfFile: fileName];
        ret = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
    }
    return ret;
}

+ (void) saveUserName:(NSString *) name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    NSString *fileName =
    [documentsDir stringByAppendingPathComponent:userDataDocName];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:name];
    [array writeToFile:fileName atomically:YES];
}

+ (NSString *) prettyDate:(NSDate *) date{
    NSArray *weekdays = [NSArray arrayWithObjects:@"Domingo", @"Lunes", @"Martes", @"Miércoles", @"Jueves", @"Viernes", @"Sábado", @"Domingo", nil];
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    
    NSInteger weekday = [weekdayComponents weekday];
    // weekday 1 = Sunday for Gregorian calendar
    
    NSString *ret=[NSString stringWithFormat:@"%@ %@",weekdays[weekday-1],[dateFormatter stringFromDate:date]];
    return ret;
}

@end
