//
//  FormLoginViewController.m
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "FormLoginViewController.h"

@interface FormLoginViewController ()

@end

NSString *sessionId;

@implementation FormLoginViewController

@synthesize nombre;
@synthesize password;

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
    if(![utils userAllowedToUseApp]){
        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"promoterCodeViewController"];
        [self presentViewController:controller animated:YES completion:nil ];
    }
    nombre.text=[utils retriveUserName];
    
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
    sessionId=[jsonParser parseLogin:webData];
    if([[NSString stringWithFormat:@"%@",sessionId] isEqual: @""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[jsonParser errorMessage]
                                                       delegate:self
                                              cancelButtonTitle:@"Cerrar"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"EventsViewController"];
        [self presentViewController:controller animated:YES completion:nil ];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginOK:(UIButton *)sender {
    webData = [NSMutableData data];
	[webServiceCaller login:nombre.text withPassword:password.text andDelegateTo:self];
}

- (IBAction)solicitarDatosAcceso:(UIButton *)sender {
}

- (IBAction)tengoProblemasParaAcceder:(UIButton *)sender {
}

- (IBAction)bgTouched:(id)sender {
    [nombre resignFirstResponder];
    [password resignFirstResponder];
}

- (IBAction)doneEditing:(id)sender {
    [sender resignFirstResponder];
}

@end
