//
//  InviteViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "webServiceCaller.h"
#import "jsonParser.h"

@interface InviteViewController : UIViewController
<NSURLConnectionDelegate>
{
    @private NSMutableData *webData;
    @private Boolean qrLoaded;
}

@property (strong, nonatomic) IBOutlet UIImageView *qrImg;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollField;
@property (strong, nonatomic) IBOutlet UITextField *inputEmail;
- (IBAction)inviteOK:(UIButton *)sender;

- (IBAction)editDone:(id)sender;
- (IBAction)bgTouched:(id)sender;
- (IBAction)validateEmail:(id)sender;

@end
