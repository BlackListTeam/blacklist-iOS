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

// ********* VALIDATIONS ***********


- (BOOL)validateInputEmail:(NSString *)emailStr
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email.text];
}

- (BOOL)validateInputAnyo:(NSString *)emailStr
{
    NSString *anyoRegex = @"[0-9]{4}";
    NSPredicate *anyoTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", anyoRegex];
    return [anyoTest evaluateWithObject:anyoNacimiento.text];
}

- (IBAction)validateEmail:(id)sender {
        if(![self validateInputEmail:[email text]])
        {
            // user entered invalid email address
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Escribe un mail correcto." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            
            email.text=@"";
        }
}

- (IBAction)validateAnyo:(id)sender {
    if(![self validateInputAnyo:[anyoNacimiento text]])
    {
        // user entered invalid email address
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Escribe un anyo de 4 cifras" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        anyoNacimiento.text=@"";
    }
}

@end
