//
//  CodeEntranceViewController.m
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "CodeEntranceViewController.h"
#import "ReservationViewController.h"

@interface CodeEntranceViewController ()

@end

NSString *sessionId;
Reservation *reservation;

@implementation CodeEntranceViewController

@synthesize qrImg;
@synthesize infoReservation;
@synthesize infoParty;

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
    
	// Do any additional setup after loading the view.
    deleteReservation=false;
    infoReservation.font = [UIFont fontWithName:@"Bebas Neue" size:17];
    infoParty.font = [UIFont fontWithName:@"Bebas Neue" size:20];
}

- (void) viewDidAppear:(BOOL) animated
{
    webData = [NSMutableData data];
	[webServiceCaller getCurrentReservation:sessionId andDelegateTo:self];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
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
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if(deleteReservation){
        Boolean deleted=[jsonParser parseDeleteReservation:webData];
        if([jsonParser authError]){
            UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FormLoginViewController"];
            [self presentViewController:controller animated:YES completion:nil ];
        }else{
            if(deleted){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atención"
                                                                message:@"Reserva anulada correctamente"
                                                               delegate:self
                                                      cancelButtonTitle:@"Ver Fiestas"
                                                      otherButtonTitles:nil];
                [alert show];

            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:[jsonParser errorMessage]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Cerrar"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
    }else{
        reservation=[jsonParser parseGetCurrentReservation:webData];
        if([jsonParser authError]){
            UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FormLoginViewController"];
            [self presentViewController:controller animated:YES completion:nil ];
        }else{
            if(reservation.qr!=nil){
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:reservation.qr]];
                qrImg.image = [UIImage imageWithData:imageData];
                NSLog(@"Image QR %@",reservation.qr);
                
                infoReservation.text = @"";
                infoParty.text = reservation.party_name;
                NSLog(@"VIP %d",reservation.vip);
                NSLog(@"Rooms %d",reservation.rooms);
                NSLog(@"Escorts %d",reservation.escorts);
                if(reservation.vip>0){
                    infoReservation.text = [infoReservation.text stringByAppendingString: @"VIP"];
                }
                if(reservation.rooms>0){
                    if(![infoReservation.text isEqualToString:@""]){
                        infoReservation.text = [infoReservation.text stringByAppendingString: @" | "];
                    }
                        infoReservation.text = [infoReservation.text stringByAppendingString: @"HABITACIONES: "];
                        infoReservation.text = [infoReservation.text stringByAppendingString: [NSString stringWithFormat:@"%d", reservation.rooms]];
                }
                if(reservation.escorts>0){
                    if(![infoReservation.text isEqualToString:@""]){
                        infoReservation.text = [infoReservation.text stringByAppendingString: @" | "];
                    }
                    infoReservation.text = [infoReservation.text stringByAppendingString: @"ACOMPAÑANTES: "];
                    infoReservation.text = [infoReservation.text stringByAppendingString: [NSString stringWithFormat:@"%d", reservation.escorts]];
                }
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso"
                                                                message:[jsonParser errorMessage]
                                                               delegate:self
                                                      cancelButtonTitle:@"Ver Fiestas"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
    }
    deleteReservation=false;
    
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(deleteReservation){
        if(buttonIndex==0){
            webData = [NSMutableData data];
            [webServiceCaller deleteReservation:sessionId andDelegateTo:self];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }else{
            deleteReservation=false;
        }
    }else{
        UITabBarController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
        [self presentViewController:controller animated:YES completion:nil ];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (IBAction)cambiarReserva:(id)sender {
    ReservationViewController* reservationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ReservationViewController"];
    reservationViewController.reservation=reservation;
    [self.navigationController pushViewController:reservationViewController animated:YES];
}*/

- (IBAction)anularReserva:(id)sender {
    deleteReservation=true;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso"
                                                    message:@"Estás seguro de querer anular la reserva?"
                                                   delegate:self
                                          cancelButtonTitle:@"Si"
                                          otherButtonTitles:@"No",nil];
    [alert show];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
