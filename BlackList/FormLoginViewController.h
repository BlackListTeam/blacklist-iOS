//
//  FormLoginViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormLoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *nombre;
@property (strong, nonatomic) IBOutlet UITextField *password;
- (IBAction)loginOK:(UIButton *)sender;
- (IBAction)solicitarDatosAcceso:(UIButton *)sender;
- (IBAction)tengoProblemasParaAcceder:(UIButton *)sender;
- (IBAction)bgTouched:(id)sender;
- (IBAction)doneEditing:(id)sender;
@end
