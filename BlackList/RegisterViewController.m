//
//  RegisterViewController.m
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize email;
@synthesize nombre;
@synthesize anyoNacimiento;

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
    nombre.text=[utils retriveUserName];
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
}

- (void) connectionDidFinishLoading:(NSURLConnection *) connection
{
    if([jsonParser parseAddUser:webData]){
        [utils saveUserName:nombre.text];
        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PromoterCodeOKViewController"];
        [self presentViewController:controller animated:YES completion:nil ];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[jsonParser errorMessage]
                                                       delegate:self
                                              cancelButtonTitle:@"Cerrar"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)registerOK:(UIButton *)sender
{
    webData = [NSMutableData data];
    [webServiceCaller addUser: [[User alloc] initWithName:nombre.text
                                                 andEmail:email.text
                                             andBirthYear:anyoNacimiento.text]
             withPromoterCode: [utils retrivePromoterCode]
                andDelegateTo: self];
    
}

- (IBAction)doneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)bgTouched:(id)sender {
    [email resignFirstResponder];
    [nombre resignFirstResponder];
    [anyoNacimiento resignFirstResponder];
}

@end
