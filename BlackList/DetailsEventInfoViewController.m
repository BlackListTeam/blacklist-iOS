//
//  DetailsEventInfoViewController.m
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "DetailsEventInfoViewController.h"
#import "DetailsEventSitioViewController.h"
#import "DetailsEventPrecioViewController.h"
#import "ReservationViewController.h"

@interface DetailsEventInfoViewController ()

@end

@implementation DetailsEventInfoViewController

@synthesize party = _party;
@synthesize landscapeImage;
@synthesize textInfo;
@synthesize buttonReservar;
@synthesize titleEvent;

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
    textInfo.text = _party.info;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_party.image]];
    landscapeImage.image = [UIImage imageWithData:imageData];
    if(!_party.es_actual){
        buttonReservar.hidden = TRUE;
    }
    titleEvent.font = [UIFont fontWithName:@"Bebas Neue" size:20];
    titleEvent.text = _party.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"infoToSitio"]) {
        DetailsEventSitioViewController *controller = (DetailsEventSitioViewController *) segue.destinationViewController;
        controller.party=_party;
    }
    if ([[segue identifier] isEqualToString:@"infoToPrecio"]) {
        DetailsEventPrecioViewController *controller = (DetailsEventPrecioViewController *) segue.destinationViewController;
        controller.party=_party;
    }
    if ([[segue identifier] isEqualToString:@"infoToReserva"]) {
        ReservationViewController *controller = (ReservationViewController *) segue.destinationViewController;
        controller.party=_party;
    }
}

@end
