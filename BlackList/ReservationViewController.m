//
//  ReservationViewController.m
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "ReservationViewController.h"
#import "CodeEntranceViewController.h"

@interface ReservationViewController ()

@end

NSString *sessionId;

@implementation ReservationViewController

@synthesize party = _party;
//@synthesize reservation = _reservation;
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

- (void)viewDidAppear:(BOOL)animated
{
    if(_party.max_escorts == 0){
        [habitacionesLabel setFrame:CGRectMake(12,195,habitaciones.frame.size.width,habitaciones.frame.size.height)];
        habitaciones.frame= CGRectMake(174,195,habitaciones.frame.size.width,habitaciones.frame.size.height);
        habitacionesCount.frame= CGRectMake(266,197,habitacionesCount.frame.size.width,habitacionesCount.frame.size.height);
        espacioVipLabel.frame= CGRectMake(-34,238,espacioVipLabel.frame.size.width,espacioVipLabel.frame.size.height);
        espacioVip.frame= CGRectMake(174,237,espacioVip.frame.size.width,espacioVip.frame.size.height);
    }
    else{
        acompanyantesLabel.hidden = FALSE;
        acompanyantesCount.hidden = FALSE;
        acompanyantes.hidden = FALSE;
    }
    if(_party.max_rooms == 0){
        espacioVipLabel.frame= CGRectMake(-34,238,espacioVipLabel.frame.size.width,espacioVipLabel.frame.size.height);
        espacioVip.frame= CGRectMake(174,237,espacioVip.frame.size.width,espacioVip.frame.size.height);
    }
    else{
        habitacionesLabel.hidden = FALSE;
        habitacionesCount.hidden = FALSE;
        habitaciones.hidden = FALSE;
    }
    if(_party.vip_allowed){
        espacioVipLabel.hidden = FALSE;
        espacioVip.hidden = FALSE;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
     
     CODI PER EDITAR RESERVA
     
     if(_reservation!=nil){
        
        habitacionesCount.text = [NSString stringWithFormat:@"%d", _reservation.rooms];
        acompanyantesCount.text = [NSString stringWithFormat:@"%d", _reservation.rooms];
        switch (_reservation.vip)
        {       case 0:
                espacioVip.selectedSegmentIndex = 1;
                break;
            case 1:
                espacioVip.selectedSegmentIndex = 0;
                break;
            default:
                espacioVip.selectedSegmentIndex = 0;
                break;
        }        
    }
    else{
        
    }*/
    
    titleEvent.font = [UIFont fontWithName:@"Bebas Neue" size:18];
    titleEvent.text = _party.name;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_party.image]];
    landscapeImage.image = [UIImage imageWithData:imageData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
    Boolean reservated = [jsonParser parseMakeReservation:webData];
    if ([jsonParser authError]){
        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FormLoginViewController"];
        [self presentViewController:controller animated:YES completion:nil ];
    }
    else{
        if(reservated){
            [self.tabBarController setSelectedIndex:2];
            CodeEntranceViewController* codeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CodeEntranceViewController"];
            [self.navigationController pushViewController:codeViewController animated:YES];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[jsonParser errorMessage]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Cerrar"
                                                  otherButtonTitles:nil];
            [alert show];
        }

    }
    }

- (IBAction)acompanyantesChange:(id)sender {
    
    UIStepper *stepper = (UIStepper *) sender;
    
    stepper.maximumValue = _party.max_escorts;
    stepper.minimumValue = 0;
    
    double value = stepper.value;
    
    [acompanyantesCount setText:[NSString stringWithFormat:@"%d", (int)value]];
}

- (IBAction)habitacionesChange:(id)sender {
    UIStepper *stepper = (UIStepper *) sender;
    
    stepper.maximumValue = _party.max_rooms;
    stepper.minimumValue = 0;
    
    double value = stepper.value;
    
    [habitacionesCount setText:[NSString stringWithFormat:@"%d", (int)value]];
}

- (IBAction)contactoReservaEspecial:(id)sender {
    NSString *emailString =[[NSString alloc] initWithFormat:@"mailto:?to=%@&subject=%@&body=%@",
                            [@"info@blacklistmeetings.com" stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding],
                            [@"Contacto Para Reserva Especial" stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
                            [@"" stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:emailString]];
}

- (IBAction)reservationOK:(UIButton *)sender {
    webData = [NSMutableData data];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Recuerda que las reservas hechas que no sean anuladas 48h antes de la fiestas se tienen en cuenta como válidas.\n Si un miembro no es responsable en el uso de este servicio, puede ser penalizado con la imposibilidad de realizar futuras reservas y/o inactivación completa de su App \n Este servicio es necesario para el buen funcionamiento de las fiestas y se debe usar responsablemente con afán de colaboración"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancelar"
                                          otherButtonTitles:@"Reservar",nil];
    [alert show];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        if(buttonIndex==1){
            int vip = 0;
            switch (espacioVip.selectedSegmentIndex)
            {case 0:
                    vip = 1;
                    break;
                case 1:
                    vip = 0;
                    break;
                default:
                    vip = 0;
                    break;
            }
            webData = [NSMutableData data];
            [webServiceCaller makeReservation: [[Reservation alloc] initWithEscorts:[acompanyantesCount.text intValue]
                                                                             andVip: vip
                                                                           andRooms:[habitacionesCount.text intValue]]
                                withSessionId: sessionId andDelegateTo: self];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
}

-(void)willPresentAlertView:(UIAlertView *)alertView{
    
    UILabel *title = [alertView valueForKey:@"_titleLabel"];
    title.font = [UIFont fontWithName:@"Arial" size:15];
    [title setTextColor:[UIColor whiteColor]];

      }

@end
