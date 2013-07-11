//
//  DetailsEventInfoViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Party.h"
#import "webServiceCaller.h"
#import "jsonParser.h"
#import "Reservation.h"
#import "utils.h"

@interface DetailsEventInfoViewController : UIViewController<NSURLConnectionDelegate>
{
    @private NSMutableData *webData;
    Party * _party;
}
@property (nonatomic, retain) Party * party;
@property (strong, nonatomic) IBOutlet UIImageView *landscapeImage;
@property (strong, nonatomic) IBOutlet UITextView *textInfo;
@property (strong, nonatomic) IBOutlet UIButton *buttonReservar;
@property (strong, nonatomic) IBOutlet UILabel *titleEvent;

@end
