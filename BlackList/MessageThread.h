//
//  MessageThread.h
//  BlackList
//
//  Created by Air on 09/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageThread : NSObject
{
@public int mt_id;
    NSString *from;
    NSString *subject;
    NSMutableArray *messages;
    
}

@property (nonatomic) int mt_id;
@property (nonatomic, retain) NSString *from;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSMutableArray *messages;


@end
