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



@interface promoterCodeViewController : UIViewController

<NSURLConnectionDelegate>
{
    @private NSMutableData *webData;
    IBOutlet UITextField *promoterCode;
}

- (IBAction)onClickOk:(UIButton *)sender;
@end
