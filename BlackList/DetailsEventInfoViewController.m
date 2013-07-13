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

NSString *sessionId;

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

- (void) viewDidAppear:(BOOL) animated
{
    webData = [NSMutableData data];
	[webServiceCaller getCurrentReservation:sessionId andDelegateTo:self];
}

-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *) response
{
    [webData setLength: 0];
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *) data
{
    [webData appendData:data];
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *) error
{
    NSLog(@"Error in webservice communication");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error de conexión"
                                                    message:@"No ha sido posible conectarse con los servidores de Blacklist"
                                                   delegate:nil
                                          cancelButtonTitle:@"Cerrar"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) connectionDidFinishLoading:(NSURLConnection *) connection
{
        Reservation *reservation=[jsonParser parseGetCurrentReservation:webData];
        if([jsonParser authError]){
            UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FormLoginViewController"];
            [self presentViewController:controller animated:YES completion:nil ];
        }else{
            if(reservation.qr!=nil){
                _party.es_actual=FALSE;
                buttonReservar.hidden = TRUE;
            }
            else if(_party.es_actual){
                buttonReservar.hidden = FALSE;
            }
        }    
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
