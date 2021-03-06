//
//  FormLoginViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "utils.h"
#import "webServiceCaller.h"
#import "jsonParser.h"


@interface FormLoginViewController : UIViewController
<NSURLConnectionDelegate>
{
@private NSMutableData *webData;
}
@property (strong, nonatomic) IBOutlet UITextField *nombre;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollField;
- (IBAction)loginOK:(UIButton *)sender;
- (IBAction)tengoProblemasParaAcceder:(UIButton *)sender;
- (IBAction)bgTouched:(id)sender;
- (IBAction)doneEditing:(id)sender;
@end
