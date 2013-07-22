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
NSString *device_token;


@implementation FormLoginViewController

@synthesize nombre;
@synthesize password;
@synthesize scrollField;

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
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    nombre.leftView = paddingView;
    nombre.leftViewMode = UITextFieldViewModeAlways;
    nombre.rightView = paddingView;
    nombre.rightViewMode = UITextFieldViewModeAlways;
    password.leftView = paddingView;
    password.leftViewMode = UITextFieldViewModeAlways;
    password.rightView = paddingView;
    password.rightViewMode = UITextFieldViewModeAlways;
    if(![utils userAllowedToUseApp]){
        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"promoterCodeViewController"];
        [self presentViewController:controller animated:YES completion:nil ];
    }
    nombre.text=[utils retriveUserName];
    [self registerForKeyboardNotifications];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    nombre = nil;
    //password = nil;
    scrollField = nil;
    [self unregisterForKeyboardNotifications];
    
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
                                                   delegate:self
                                          cancelButtonTitle:@"Cerrar"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) connectionDidFinishLoading:(NSURLConnection *) connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    sessionId=[jsonParser parseLogin:webData];
    if([[NSString stringWithFormat:@"%@",sessionId] isEqual: @""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[jsonParser errorMessage]
                                                       delegate:self
                                              cancelButtonTitle:@"Cerrar"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        [utils saveUserName:nombre.text];
        UITabBarController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
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
    NSLog(@"Tokenlogin: %@",device_token);
	[webServiceCaller login:nombre.text withPassword:password.text andToken:device_token andDelegateTo:self];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (IBAction)tengoProblemasParaAcceder:(UIButton *)sender {
    NSString *emailString =[[NSString alloc] initWithFormat:@"mailto:?to=%@&subject=%@&body=%@",
                            [@"info@blacklistmeetings.com" stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding],
                            [@"Contacto" stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
                            [@"" stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:emailString]];
}

- (IBAction)bgTouched:(id)sender {
    [nombre resignFirstResponder];
    [password resignFirstResponder];

}

- (IBAction)doneEditing:(id)sender {
    [sender resignFirstResponder];
}

//************************ SCROLL  ************************
- (IBAction)passwordDidBeginEditing:(UITextField *)textField {
    password = textField;
    
    //Add tap recognizer to scroll view, user can tap other part of scroll view to
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    [scrollField addGestureRecognizer:tapRecognizer];
}

#pragma mark - event of keyboard relative methods
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)unregisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


- (void)keyboardWillShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect frame = self.view.frame;
    
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        frame.size.height -= kbSize.height;
        
    }else{
        frame.size.height -= kbSize.width;
    }
    CGPoint fOrigin = password.frame.origin;
    fOrigin.y -= scrollField.contentOffset.y;
    fOrigin.y += password.frame.size.height;
    if (!CGRectContainsPoint(frame, fOrigin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, password.frame.origin.y + password.frame.size.height - frame.size.height);
        [scrollField setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [scrollField setContentOffset:CGPointZero animated:YES];
}

@end
