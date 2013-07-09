//
//  RegisterViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "webServiceCaller.h"
#import "jsonParser.h"
#import "User.h"
#import "utils.h"

@interface RegisterViewController : UIViewController
<NSURLConnectionDelegate>
{
    @private NSMutableData *webData;
}
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *nombre;
@property (strong, nonatomic) IBOutlet UITextField *anyoNacimiento;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollField;

- (IBAction)registerOK:(UIButton *)sender;
- (IBAction)doneEditing:(id)sender;
- (IBAction)bgTouched:(id)sender;
- (IBAction)validateEmail:(id)sender;
- (IBAction)validateAnyo:(id)sender;
@end
