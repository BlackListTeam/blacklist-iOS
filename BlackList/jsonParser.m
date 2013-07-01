//
//  jsonParser.m
//  BlackList
//
//  Created by Air on 01/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "jsonParser.h"
#import "SBJson.h"

static Boolean authError;
static NSString *errorMessage;

@implementation jsonParser

+ (Boolean) parseValidatePromoterCode:(NSMutableData *) webData
{
    NSString *strResult=[[NSString alloc] initWithBytes:[webData mutableBytes]
                                                 length:[webData length]
                                               encoding:NSUTF8StringEncoding];
    
    NSDictionary *result= [[[SBJsonParser alloc] init] objectWithString:strResult];
    
    NSDictionary *response = [result objectForKey:@"response"];
    Boolean ret=false;
    if([response objectForKey:@"valid"]){
        ret= true;
    }
    
    return ret;
}


/* EXEMPLE DE RECORRER EL JSON
 NSString *strResult=[[NSString alloc] initWithBytes:[webData mutableBytes]
 length:[webData length]
 encoding:NSUTF8StringEncoding];
 
 NSDictionary *result= [[[SBJsonParser alloc] init] objectWithString:strResult];
 for(id theKey in result){
 NSDictionary *detailedItems = [result objectForKey:theKey];
 
 NSLog(@"Key is %@, Value is %@",theKey, detailedItems);
 
 //---print out individual keys and their values---
 for (id detailedKey in detailedItems){
 id detailedValue = [detailedItems objectForKey:detailedKey];
 NSLog(@"Key is %@, Value is %@", detailedKey, detailedValue);
 }
 
 }

 */

@end
