//
//  CodeEntranceViewController.m
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "CodeEntranceViewController.h"

@interface CodeEntranceViewController ()

@end

NSString *sessionId;

@implementation CodeEntranceViewController

@synthesize qrImg;

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
}

- (void) connectionDidFinishLoading:(NSURLConnection *) connection
{
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
        Reservation *reservation=[jsonParser parseGetCurrentReservation:webData];
        if([jsonParser authError]){
            UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FormLoginViewController"];
            [self presentViewController:controller animated:YES completion:nil ];
        }else{
            NSLog(@"%@",reservation.qr);
            if(reservation.qr!=nil){
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:reservation.qr]];
                qrImg.image = [UIImage imageWithData:imageData];
                NSLog(@"RES: %@",reservation.qr);
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
        NSLog(@"bi%ld",(long)buttonIndex);
        if(buttonIndex==0){
            webData = [NSMutableData data];
            [webServiceCaller deleteReservation:sessionId andDelegateTo:self];
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

- (IBAction)cambiarReserva:(id)sender {
}

- (IBAction)anularReserva:(id)sender {
    deleteReservation=true;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso"
                                                    message:@"Estás seguro de querer anular la reserva?"
                                                   delegate:self
                                          cancelButtonTitle:@"Si"
                                          otherButtonTitles:@"No",nil];
    [alert show];
}
@end
