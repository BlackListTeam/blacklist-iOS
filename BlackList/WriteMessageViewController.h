//
//  WriteMessageViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteMessageViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *textMessage;

- (IBAction)enviarMessage:(UIButton *)sender;
- (IBAction)bgTouched:(id)sender;

@end
