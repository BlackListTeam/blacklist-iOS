//
//  jsonParser.m
//  BlackList
//
//  Created by Air on 01/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "jsonParser.h"
#import "SBJson.h"

static Boolean authError=false;
static NSString *errorMessage=@"";

@implementation jsonParser

+ (Boolean) parseValidatePromoterCode:(NSMutableData *) webData
{
    [self reset];
    NSString *strResult=[[NSString alloc] initWithBytes:[webData mutableBytes]
                                                 length:[webData length]
                                               encoding:NSUTF8StringEncoding];
    
    NSDictionary *result= [[[SBJsonParser alloc] init] objectWithString:strResult];
    
    NSDictionary *response = [result objectForKey:@"response"];
    Boolean ret=false;
    if([[NSString stringWithFormat:@"%@",[response objectForKey:@"valid"]] isEqual: @"1"]){
        ret= true;
    }
    
    return ret;
}

+ (Boolean) parseAddUser:(NSMutableData *) webData
{
    [self reset];
    NSString *strResult=[[NSString alloc] initWithBytes:[webData mutableBytes]
                                                 length:[webData length]
                                               encoding:NSUTF8StringEncoding];
    
    NSDictionary *result= [[[SBJsonParser alloc] init] objectWithString:strResult];
    
    NSDictionary *response = [result objectForKey:@"response"];
    Boolean ret=false;
    if([[NSString stringWithFormat:@"%@",[response objectForKey:@"added"]] isEqual: @"1"]){
        ret= true;
    }else{
        errorMessage=[response objectForKey:@"errorMessage"];
        ret=false;
    }
    
    return ret;
}

+ (NSString *) parseLogin:(NSMutableData *) webData
{
    [self reset];
    NSString *ret=@"";
    NSString *strResult=[[NSString alloc] initWithBytes:[webData mutableBytes]
                                                 length:[webData length]
                                               encoding:NSUTF8StringEncoding];
    
    NSDictionary *result= [[[SBJsonParser alloc] init] objectWithString:strResult];
    
    NSDictionary *response = [result objectForKey:@"response"];
    
    
    if([[NSString stringWithFormat:@"%@",[response objectForKey:@"logged"]] isEqual: @"1"]){
        ret=[response objectForKey:@"sessionId"];
    }else{
        errorMessage=[response objectForKey:@"errorMessage"];
    }
    
    return ret;
}

+ (NSMutableArray *) parseGetPartyCovers:(NSMutableData *) webData
{
    [self reset];
    NSMutableArray *ret=[[NSMutableArray alloc] init];
    NSString *strResult=[[NSString alloc] initWithBytes:[webData mutableBytes]
                                                 length:[webData length]
                                               encoding:NSUTF8StringEncoding];
    
    NSDictionary *result= [[[SBJsonParser alloc] init] objectWithString:strResult];
    
    NSDictionary *response = [result objectForKey:@"response"];
    
    NSLog(@"JSONPARSER: %@",response);
    
    errorMessage=[response objectForKey:@"errorMessage"];
    if([[NSString stringWithFormat:@"%@",[response objectForKey:@"authError"]] isEqual: @"1"]){
        authError=true;
    }else{
        authError=false;
        for(id party_json_index in [response objectForKey:@"parties"]){
            
            NSDictionary *party_json = [party_json_index objectForKey:@"Party"];
            //TODO
            Party *p=[[Party alloc] init];
            p.cover =[NSString stringWithFormat:@"http://www.blacklistmeetings.com/files/party/cover/%@/%@",
                      [party_json objectForKey:@"cover_dir"],
                      [party_json objectForKey:@"cover"]];
            p.party_id =[[party_json objectForKey:@"id"] intValue];
            //p.date =[[party_json objectForKey:@"date"] date];
            [ret addObject:p];
        }

    }
    
    return ret;
}

+ (Boolean) parseGetParty:(NSMutableData *) webData
{
    [self reset];
    Boolean ret=false;
    NSString *strResult=[[NSString alloc] initWithBytes:[webData mutableBytes]
                                                 length:[webData length]
                                               encoding:NSUTF8StringEncoding];
    
    NSDictionary *result= [[[SBJsonParser alloc] init] objectWithString:strResult];
    
    NSDictionary *response = [result objectForKey:@"response"];
    
    
    
    
    
    
    return ret;
}

+ (Boolean) parseGetPartyGallery:(NSMutableData *) webData
{
    [self reset];
    Boolean ret=false;
    NSString *strResult=[[NSString alloc] initWithBytes:[webData mutableBytes]
                                                 length:[webData length]
                                               encoding:NSUTF8StringEncoding];
    
    NSDictionary *result= [[[SBJsonParser alloc] init] objectWithString:strResult];
    
    NSDictionary *response = [result objectForKey:@"response"];
    
    
    
    
    
    
    return ret;
}

+ (Boolean) parseGetCurrentReservation:(NSMutableData *) webData
{
    [self reset];
    Boolean ret=false;
    NSString *strResult=[[NSString alloc] initWithBytes:[webData mutableBytes]
                                                 length:[webData length]
                                               encoding:NSUTF8StringEncoding];
    
    NSDictionary *result= [[[SBJsonParser alloc] init] objectWithString:strResult];
    
    NSDictionary *response = [result objectForKey:@"response"];
    
    
    
    
    
    
    return ret;
}

+ (Boolean) parseMakeReservation:(NSMutableData *) webData
{
    [self reset];
    Boolean ret=false;
    NSString *strResult=[[NSString alloc] initWithBytes:[webData mutableBytes]
                                                 length:[webData length]
                                               encoding:NSUTF8StringEncoding];
    
    NSDictionary *result= [[[SBJsonParser alloc] init] objectWithString:strResult];
    
    NSDictionary *response = [result objectForKey:@"response"];
    
    
    
    
    
    
    return ret;
}

+ (Boolean) parseEditReservation:(NSMutableData *) webData
{
    [self reset];
    Boolean ret=false;
    NSString *strResult=[[NSString alloc] initWithBytes:[webData mutableBytes]
                                                 length:[webData length]
                                               encoding:NSUTF8StringEncoding];
    
    NSDictionary *result= [[[SBJsonParser alloc] init] objectWithString:strResult];
    
    NSDictionary *response = [result objectForKey:@"response"];
    
    
    
    
    
    
    return ret;
}

+ (Boolean) parseDeleteReservation:(NSMutableData *) webData
{
    [self reset];
    Boolean ret=false;
    NSString *strResult=[[NSString alloc] initWithBytes:[webData mutableBytes]
                                                 length:[webData length]
                                               encoding:NSUTF8StringEncoding];
    
    NSDictionary *result= [[[SBJsonParser alloc] init] objectWithString:strResult];
    
    NSDictionary *response = [result objectForKey:@"response"];
    
    
    
    
    
    
    return ret;
}

+ (Boolean) parseGetMessages:(NSMutableData *) webData
{
    [self reset];
    Boolean ret=false;
    NSString *strResult=[[NSString alloc] initWithBytes:[webData mutableBytes]
                                                 length:[webData length]
                                               encoding:NSUTF8StringEncoding];
    
    NSDictionary *result= [[[SBJsonParser alloc] init] objectWithString:strResult];
    
    NSDictionary *response = [result objectForKey:@"response"];
    
    
    
    
    
    
    return ret;
}

+ (Boolean) parseReplyMessage:(NSMutableData *) webData
{
    [self reset];
    Boolean ret=false;
    NSString *strResult=[[NSString alloc] initWithBytes:[webData mutableBytes]
                                                 length:[webData length]
                                               encoding:NSUTF8StringEncoding];
    
    NSDictionary *result= [[[SBJsonParser alloc] init] objectWithString:strResult];
    
    NSDictionary *response = [result objectForKey:@"response"];
    
    
    
    
    
    
    return ret;
}

+ (Boolean) parseSendInvitation:(NSMutableData *) webData
{
    [self reset];
    Boolean ret=false;
    NSString *strResult=[[NSString alloc] initWithBytes:[webData mutableBytes]
                                                 length:[webData length]
                                               encoding:NSUTF8StringEncoding];
    
    NSDictionary *result= [[[SBJsonParser alloc] init] objectWithString:strResult];
    
    NSDictionary *response = [result objectForKey:@"response"];
    
    
    
    
    
    
    return ret;
}

+ (Boolean) parseGetUserQr: (NSMutableData *) webData{
    [self reset];
    Boolean ret=false;
    NSString *strResult=[[NSString alloc] initWithBytes:[webData mutableBytes]
                                                 length:[webData length]
                                               encoding:NSUTF8StringEncoding];
    
    NSDictionary *result= [[[SBJsonParser alloc] init] objectWithString:strResult];
    
    NSDictionary *response = [result objectForKey:@"response"];
    
    
    
    
    
    
    return ret;
}

+ (void) reset
{
    authError=false;
    errorMessage=@"";
}

+ (Boolean) authError { return authError; }

+ (NSString *) errorMessage { return errorMessage; }


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
