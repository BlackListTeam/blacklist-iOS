//
//  CodeEntranceViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeEntranceViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *email;

- (IBAction)inviteCode:(UIButton *)sender;

@end
