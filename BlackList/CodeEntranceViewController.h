//
//  CodeEntranceViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "webServiceCaller.h"
#import "jsonParser.h"
#import "Reservation.h"

@interface CodeEntranceViewController : UIViewController
<NSURLConnectionDelegate,UIAlertViewDelegate>
{
@private NSMutableData *webData;
@private Boolean deleteReservation;
}

@property (strong, nonatomic) IBOutlet UIImageView *qrImg;
@property (strong, nonatomic) IBOutlet UILabel *infoReservation;
@property (strong, nonatomic) IBOutlet UILabel *infoParty;
- (IBAction)anularReserva:(id)sender;


- (IBAction)back:(id)sender;
@end
