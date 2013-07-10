//
//  AnswerMessageViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageThread.h"
#import "Message.h"

@interface AnswerMessageViewController : UIViewController
{
    MessageThread * _messageThread;
}
@property (nonatomic, retain) MessageThread * _messageThread;

@property (strong, nonatomic) IBOutlet UIScrollView *viewScroll;

@end
