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
    
    NSLog(@"Response %@",response);
    
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
    
    errorMessage=[response objectForKey:@"errorMessage"];
    if([[NSString stringWithFormat:@"%@",[response objectForKey:@"authError"]] isEqual: @"1"]){
        authError=true;
    }else{
        authError=false;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        for(id party_json_index in [response objectForKey:@"parties"]){
            
            NSDictionary *party_json = [party_json_index objectForKey:@"Party"];
            NSDictionary *gallery_json = [party_json_index objectForKey:@"Image"];
            //TODO
            Party *p=[[Party alloc] init];
            p.cover =[NSString stringWithFormat:@"http://www.blacklistmeetings.com/files/party/cover/%@/iphone_%@",
                      [party_json objectForKey:@"cover_dir"],
                      [party_json objectForKey:@"cover"]];
            p.party_id =[[party_json objectForKey:@"id"] intValue];
            p.info = [party_json objectForKey:@"info"];
            p.image = [NSString stringWithFormat:@"http://www.blacklistmeetings.com/files/party/img/%@/iphone_%@",
                       [party_json objectForKey:@"img_dir"],
                       [party_json objectForKey:@"img"]];
            p.date =[dateFormatter dateFromString:[party_json objectForKey:@"date"]];
            p.location_date =[dateFormatter dateFromString:[party_json objectForKey:@"place_date"]];
            p.price_info =[party_json objectForKey:@"price_info"];
            p.place_text =[party_json objectForKey:@"place_text"];
            p.max_escorts =[[party_json objectForKey:@"max_escorts"] intValue];
            p.max_rooms =[[party_json objectForKey:@"max_rooms"] intValue];
            p.vip_allowed =[[party_json objectForKey:@"vip_allowed"] boolValue];
            p.gallery = [NSMutableArray array];
            for(id party_image in gallery_json){
                NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.blacklistmeetings.com/files/image/img/%@/iphone_%@",
                                                   [party_image objectForKey:@"img_dir"],
                                                   [party_image objectForKey:@"img"]]];
                if (URL)
                {
                    [p.gallery addObject:URL];
                }
                else
                {
                    NSLog(@"'%@' is not a valid URL", p.gallery);
                }

            }
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
