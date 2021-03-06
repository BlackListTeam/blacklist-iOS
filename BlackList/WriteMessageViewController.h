//
//  WriteMessageViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webServiceCaller.h"
#import "jsonParser.h"

@interface WriteMessageViewController : UIViewController
<UITextViewDelegate,NSURLConnectionDelegate,UIAlertViewDelegate>
{
@private NSMutableData *webData;
    int _message_thread_id;
}

@property (nonatomic) int _message_thread_id;
@property (strong, nonatomic) IBOutlet UITextView *textMessage;

- (IBAction)enviarMessage:(UIButton *)sender;
- (IBAction)bgTouched:(id)sender;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *back;
- (IBAction)back:(id)sender;
@end
