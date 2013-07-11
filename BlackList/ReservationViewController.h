//
//  ReservationViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Party.h"
#import "jsonParser.h"
#import "webServiceCaller.h"
#import "utils.h"

@interface ReservationViewController : UIViewController<NSURLConnectionDelegate,UIAlertViewDelegate>
{
    @private NSMutableData *webData;
    Party * _party;
}
@property (nonatomic, retain) Party * party;
@property (strong, nonatomic) IBOutlet UIImageView *landscapeImage;
@property (strong, nonatomic) IBOutlet UILabel *titleEvent;
@property (strong, nonatomic) IBOutlet UISegmentedControl *espacioVip;
@property (strong, nonatomic) IBOutlet UIStepper *acompanyantes;
@property (strong, nonatomic) IBOutlet UIStepper *habitaciones;
@property (strong, nonatomic) IBOutlet UIImageView *espacioVipLabel;
@property (strong, nonatomic) IBOutlet UIImageView *acompanyantesLabel;
@property (strong, nonatomic) IBOutlet UIImageView *habitacionesLabel;
@property (strong, nonatomic) IBOutlet UILabel *habitacionesCount;
@property (strong, nonatomic) IBOutlet UILabel *acompanyantesCount;
- (IBAction)acompanyantesChange:(id)sender;
- (IBAction)habitacionesChange:(id)sender;

- (IBAction)reservationOK:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *contactoReservaEspecial;
@end
