//
//  ReservationViewController.m
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "ReservationViewController.h"
#import "Reservation.h"

@interface ReservationViewController ()

@end

NSString *sessionId;

@implementation ReservationViewController

@synthesize party = _party;
@synthesize landscapeImage;
@synthesize titleEvent;
@synthesize espacioVip;
@synthesize espacioVipLabel;
@synthesize acompanyantes;
@synthesize acompanyantesLabel;
@synthesize acompanyantesCount;
@synthesize habitaciones;
@synthesize habitacionesCount;
@synthesize habitacionesLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(!_party.vip_allowed){
        espacioVipLabel.hidden = TRUE;
        espacioVip.hidden = TRUE;
    }
    if(!_party.max_escorts){
        acompanyantesLabel.hidden = TRUE;
        acompanyantesCount.hidden = TRUE;
        acompanyantes.hidden = TRUE;
    }
    if(!_party.max_rooms){
        habitacionesLabel.hidden = TRUE;
        habitacionesCount.hidden = TRUE;
        habitaciones.hidden = TRUE;
    }
    titleEvent.font = [UIFont fontWithName:@"Bebas Neue" size:20];
    titleEvent.text = _party.name;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_party.image]];
    landscapeImage.image = [UIImage imageWithData:imageData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reservationOK:(UIButton *)sender {
    webData = [NSMutableData data];
    [webServiceCaller makeReservation: [[Reservation alloc] initWithEscorts:[acompanyantesCount.text intValue]
                                                 andVip:espacioVip.selected
                                             andRooms:[habitacionesCount.text intValue]]
                        withSessionId: sessionId andDelegateTo: self];
}

@end
