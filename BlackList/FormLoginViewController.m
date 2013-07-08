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
    sessionId=[jsonParser parseLogin:webData];
    if([[NSString stringWithFormat:@"%@",sessionId] isEqual: @""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[jsonParser errorMessage]
                                                       delegate:self
                                              cancelButtonTitle:@"Cerrar"
                                              otherButtonTitles:nil];
        [alert show];
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

- (IBAction)loginOK:(UIButton *)sender {
    webData = [NSMutableData data];
	[webServiceCaller login:nombre.text withPassword:password.text andDelegateTo:self];
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





/*
- (void)nombreDidBeginEditing:(UITextField *)textField {
    nombre = textField;
    
    //Add tap recognizer to scroll view, user can tap other part of scroll view to
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    [scrollField addGestureRecognizer:tapRecognizer];
    
}
- (void)nombreDidEndEditing:(UITextField *)textField {
    nombre = nil;
}*/

- (IBAction)passwordDidBeginEditing:(UITextField *)textField {
    password = textField;
    
    //Add tap recognizer to scroll view, user can tap other part of scroll view to
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    [scrollField addGestureRecognizer:tapRecognizer];
}
- (IBAction)passwordDidEndEditing:(UITextField *)sender {
    //password= nil;
}

/*
 When user tap on the scroll view, the method is called to disable the keyboard
 */
- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    [nombre resignFirstResponder];
    [password resignFirstResponder];
    [scrollField removeGestureRecognizer:tapRecognizer];
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
