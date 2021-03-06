//
//  DetailsEventPrecioViewController.m
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "DetailsEventInfoViewController.h"
#import "DetailsEventSitioViewController.h"
#import "DetailsEventPrecioViewController.h"
#import "ReservationViewController.h"

@interface DetailsEventPrecioViewController ()

@end

@implementation DetailsEventPrecioViewController

@synthesize party = _party;
@synthesize landscapeImage;
@synthesize textPrice;
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
    titleEvent.font = [UIFont fontWithName:@"Bebas Neue" size:17];
    titleEvent.text = _party.name;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_party.image]];
    landscapeImage.image = [UIImage imageWithData:imageData];
    textPrice.text = _party.price_info;
    if(!_party.es_actual){
        buttonReservar.hidden = TRUE;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"precioToSitio"]) {
        DetailsEventSitioViewController *controller = (DetailsEventSitioViewController *) segue.destinationViewController;
        controller.party=_party;
    }
    if ([[segue identifier] isEqualToString:@"precioToInfo"]) {
        DetailsEventInfoViewController *controller = (DetailsEventInfoViewController *) segue.destinationViewController;
        controller.party=_party;
    }
    if ([[segue identifier] isEqualToString:@"precioToReserva"]) {
        ReservationViewController *controller = (ReservationViewController *) segue.destinationViewController;
        controller.party=_party;
    }
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
