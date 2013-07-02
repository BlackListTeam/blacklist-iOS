//
//  LoginViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *nombre;
@property (strong, nonatomic) IBOutlet UITextField *codigo;

- (IBAction)loginOK:(UIButton *)sender;
- (IBAction)problemasParaAcceder:(UIButton *)sender;
- (IBAction)solicitarDatos:(UIButton *)sender;
@end
