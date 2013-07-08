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

@synthesize email;
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
    webData = [NSMutableData data];
	[webServiceCaller sendInvitation:email.text withSessionId:sessionId andDelegateTo:self];
}

- (IBAction)editDone:(id)sender {
    [email resignFirstResponder];
}

- (IBAction)bgTouched:(id)sender {
    [sender resignFirstResponder];
}

//************ VALIDATIONS *************

- (BOOL)validateInputEmail:(NSString *)emailStr
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email.text];
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


//****************   SCROLL KEYBOARD   ***************

- (IBAction)emailDidBeginEditing:(UITextField *)textField {
    email = textField;
    
    //Add tap recognizer to scroll view, user can tap other part of scroll view to
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    [scrollField addGestureRecognizer:tapRecognizer];
}
- (IBAction)emailDidEndEditing:(UITextField *)sender {
    email= nil;
}

/*
 When user tap on the scroll view, the method is called to disable the keyboard
 */
- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    [email resignFirstResponder];
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
    CGPoint fOrigin = email.frame.origin;
    fOrigin.y -= scrollField.contentOffset.y;
    fOrigin.y += email.frame.size.height;
    if (!CGRectContainsPoint(frame, fOrigin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, email.frame.origin.y + email.frame.size.height - frame.size.height);
        [scrollField setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [scrollField setContentOffset:CGPointZero animated:YES];
}

@end
