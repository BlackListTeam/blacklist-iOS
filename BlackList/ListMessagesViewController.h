//
//  ListMessagesViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webServiceCaller.h"
#import "jsonParser.h"
#import "AnswerMessageViewController.h"

@interface ListMessagesViewController : UIViewController
<NSURLConnectionDelegate,UIAlertViewDelegate>
{
@private NSMutableData *webData;
    Boolean deleteMsg;
    int indexClicked;
}
@property (strong, nonatomic) IBOutlet UIScrollView *viewScroll;
@property (nonatomic, retain) NSMutableArray *messages;
@property (nonatomic) Boolean deleteMsg;
@property (nonatomic) int indexClicked;


- (IBAction)back:(id)sender;

@end
