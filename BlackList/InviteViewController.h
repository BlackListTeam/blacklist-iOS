//
//  InviteViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InviteViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *email;
- (IBAction)inviteOK:(UIButton *)sender;

- (IBAction)editDone:(id)sender;
- (IBAction)bgTouched:(id)sender;

@end
