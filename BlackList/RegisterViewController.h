//
//  RegisterViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *nombre;
@property (strong, nonatomic) IBOutlet UITextField *anyoNacimiento;

- (IBAction)registerOK:(UIButton *)sender;

@end
