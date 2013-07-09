//
//  Message.h
//  BlackList
//
//  Created by Air on 09/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
{
@public int m_id;
    int answer;
    NSString *pay_link;
    NSString *text;
}

@property (nonatomic) int m_id;
@property (nonatomic) int answer;
@property (nonatomic, retain) NSString *pay_link;
@property (nonatomic, retain) NSString *text;
@end
