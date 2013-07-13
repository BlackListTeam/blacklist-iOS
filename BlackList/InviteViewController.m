//
//  InviteViewController.m
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "InviteViewController.h"

@interface InviteViewController ()

@end

NSString *sessionId;

@implementation InviteViewController
@synthesize inputEmail;
@synthesize qrImg;
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
    webData = [NSMutableData data];
    qrLoaded=false;
	[webServiceCaller getUserQr:sessionId andDelegateTo:self];
    [self registerForKeyboardNotifications];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    inputEmail = nil;
    scrollField = nil;
    [self unregisterForKeyboardNotifications];
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
    if(!qrLoaded){
        NSString *qr=[jsonParser parseGetUserQr:webData];
        if([[NSString stringWithFormat:@"%@",qr] isEqual: @""]){
           /* UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[jsonParser errorMessage]
                                                           delegate:self
                                                  cancelButtonTitle:@"Cerrar"
                                                  otherButtonTitles:nil];
            [alert show];*/
            UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FormLoginViewController"];
            [self presentViewController:controller animated:YES completion:nil ];
        }else{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:qr]];
            qrImg.image = [UIImage imageWithData:imageData];
        }
        qrLoaded=true;
    }else{
        if([jsonParser parseSendInvitation:webData]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invitación enviada"
                                                            message:[jsonParser errorMessage]
                                                           delegate:self
                                                  cancelButtonTitle:@"Cerrar"
                                                  otherButtonTitles:nil];
            [alert show];
        }else if(![jsonParser authError]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[jsonParser errorMessage]
                                                           delegate:self
                                                  cancelButtonTitle:@"Cerrar"
                                                  otherButtonTitles:nil];
            [alert show];
        }else{
            UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FormLoginViewController"];
            [self presentViewController:controller animated:YES completion:nil ];
        }
    }
}

- (IBAction)inviteOK:(UIButton *)sender {
    NSLog(@"Input text %@",inputEmail.text);
    webData = [NSMutableData data];
	[webServiceCaller sendInvitation:inputEmail.text withSessionId:sessionId andDelegateTo:self];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (IBAction)editDone:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)bgTouched:(id)sender {
    [inputEmail resignFirstResponder];
}

//************ VALIDATIONS *************

- (BOOL)validateInputEmail:(NSString *)emailStr
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:inputEmail.text];
}

- (IBAction)validateEmail:(id)sender {
    if(![self validateInputEmail:[inputEmail text]])
    {
        // user entered invalid email address
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Escribe un mail correcto." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        inputEmail.text=@"";
    }
}


//****************   SCROLL KEYBOARD   ***************

- (IBAction)emailDidBeginEditing:(UITextField *)sender {
    inputEmail = sender;
    
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
    CGPoint fOrigin = inputEmail.frame.origin;
    fOrigin.y -= scrollField.contentOffset.y;
    fOrigin.y += inputEmail.frame.size.height;
    if (!CGRectContainsPoint(frame, fOrigin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, inputEmail.frame.origin.y + inputEmail.frame.size.height - frame.size.height);
        [scrollField setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [scrollField setContentOffset:CGPointZero animated:YES];
}

@end

