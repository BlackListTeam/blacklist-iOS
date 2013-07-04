//
//  Party.h
//  WsTest
//
//  Created by Air on 28/06/13.
//  Copyright (c) 2013 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Party : NSObject
{
    @public NSString *name;
    NSDate *date;
    NSString *cover;
    NSString *image;
    NSMutableArray *gallery;
    NSString *info;
    NSString *price_info;
    NSDate *location_date;
    NSString *map;
    int party_id;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString *cover;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, retain) NSMutableArray *gallery;
@property (nonatomic, retain) NSString *info;
@property (nonatomic, retain) NSString *price_info;
@property (nonatomic, retain) NSDate *location_date;
@property (nonatomic, retain) NSString *map;
@property (nonatomic) int party_id;




@end
