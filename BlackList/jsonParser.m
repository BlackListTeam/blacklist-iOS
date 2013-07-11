//
//  jsonParser.m
//  BlackList
//
//  Created by Air on 01/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "jsonParser.h"
#import "SBJson.h"
#import <MapKit/MapKit.h>

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
            p.latitude = [[party_json objectForKey:@"place_lat"]doubleValue];
            p.longitude = [[party_json objectForKey:@"place_long"]doubleValue];
            p.place_text =[party_json objectForKey:@"place_text"];
            p.name =[party_json objectForKey:@"name"];
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
/*
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
*/
+ (Reservation *) parseGetCurrentReservation:(NSMutableData *) webData
{
    [self reset];
    Reservation *ret=[Reservation alloc];
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
        NSDictionary *reservation=[response objectForKey:@"reservation"];
        
        if(reservation != [NSNull null]){
            ret=[ret initWithEscorts:0
                              andVip:false
                            andRooms:1
                               andQr:[[reservation objectForKey:@"Reservation"] objectForKey:@"qr"]];
        }
        //NSLog(@"asd %@",[[response objectForKey:@"reservation"] objectForKey:@"Reservation"]);
        
    }
    
    
    
    
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
    
    if([[NSString stringWithFormat:@"%@",[response objectForKey:@"reservated"]] isEqual: @"1"]){
        ret= true;
    }else{
        errorMessage=[response objectForKey:@"errorMessage"];
        ret=false;
    }
    
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
    
    errorMessage=[response objectForKey:@"errorMessage"];
    if([[NSString stringWithFormat:@"%@",[response objectForKey:@"authError"]] isEqual: @"1"]){
        authError=true;
    }else{
        authError=false;
        if([[NSString stringWithFormat:@"%@",[response objectForKey:@"deleted"]] isEqual: @"1"]){
            ret=true;
        }
    }
    
    
    
    
    return ret;
}

+ (NSMutableArray *) parseGetMessages:(NSMutableData *) webData
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
        [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        for(id message_thread_index in [response objectForKey:@"messages"]){
            NSDictionary *message_thread = [message_thread_index objectForKey:@"MessageThread"];
            NSDictionary *messages = [message_thread_index objectForKey:@"Message"];
            
            MessageThread *mt=[[MessageThread alloc] init];
            
            mt.mt_id=[[message_thread objectForKey:@"id"] intValue];
            mt.from=[message_thread objectForKey:@"from"];
            mt.subject=[message_thread objectForKey:@"subject"];
    
            mt.messages=[NSMutableArray array];
            for(id msj in messages){
                Message *m=[[Message alloc] init];
                m.m_id=[[msj objectForKey:@"id"] intValue];
                m.answer=[[msj objectForKey:@"answer"] intValue];
                m.text=[msj objectForKey:@"text"];
                m.pay_link=[msj objectForKey:@"pay_link"];
                m.date = [dateFormatter dateFromString:[msj objectForKey:@"created"]];
                [mt.messages addObject:m];
            }
            
            
            [ret addObject:mt];
        }
        
    } 
    
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
    
    errorMessage=[response objectForKey:@"errorMessage"];
    if([[NSString stringWithFormat:@"%@",[response objectForKey:@"authError"]] isEqual: @"1"]){
        authError=true;
    }else{
        authError=false;
        if([[NSString stringWithFormat:@"%@",[response objectForKey:@"replied"]] isEqual: @"1"]){
            ret=true;
        }
    }
    
    return ret;
}

+ (Boolean) parseAddMessage:(NSMutableData *) webData
{
    [self reset];
    Boolean ret=false;
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
        if([[NSString stringWithFormat:@"%@",[response objectForKey:@"added"]] isEqual: @"1"]){
            ret=true;
        }
    }
    
    return ret;
}

+ (Boolean) parseDeleteMessage:(NSMutableData *) webData
{
    [self reset];
    Boolean ret=false;
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
        if([[NSString stringWithFormat:@"%@",[response objectForKey:@"deleted"]] isEqual: @"1"]){
            ret=true;
        }
    }
    
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
    
    
    errorMessage=[response objectForKey:@"errorMessage"];
    if([[NSString stringWithFormat:@"%@",[response objectForKey:@"authError"]] isEqual: @"1"]){
        authError=true;
    }else{
        authError=false;
        if([[NSString stringWithFormat:@"%@",[response objectForKey:@"sended"]] isEqual: @"1"]){
            ret=true;
        }
    }
    
    return ret;
}

+ (NSString *) parseGetUserQr: (NSMutableData *) webData{
    [self reset];
    NSString *ret=@"";
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
        ret=[response objectForKey:@"qr"];
    }    
    return ret;
}

+ (void) reset
{
    authError=false;
    errorMessage=@"";
}

+ (Boolean) authError { return authError; }

+ (NSString *) errorMessage { return errorMessage; }


@end
