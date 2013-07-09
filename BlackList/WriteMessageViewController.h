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
}
@property (strong, nonatomic) IBOutlet UITextView *textMessage;

- (IBAction)descartarText:(id)sender;
- (IBAction)enviarMessage:(UIButton *)sender;
- (IBAction)bgTouched:(id)sender;
@end
