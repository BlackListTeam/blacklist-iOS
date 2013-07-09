//
//  promoterCodeViewController.h
//  BlackList
//
//  Created by Air on 01/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "webServiceCaller.h"
#import "jsonParser.h"
#import "User.h"
#import "utils.h"


@interface promoterCodeViewController : UIViewController

<NSURLConnectionDelegate>
{
    @private NSMutableData *webData;
    IBOutlet UITextField *promoterCode;
}

@property (nonatomic,retain) UITextField *promoterCode;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollField;

- (IBAction)onClickOk:(UIButton *)sender;
- (IBAction)doneEditing:(id)sender;
- (IBAction)bgTouched:(id)sender;

@end


