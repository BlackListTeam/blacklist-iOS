//
//  promoterCodeViewController.m
//  BlackList
//
//  Created by Air on 01/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "promoterCodeViewController.h"

@interface promoterCodeViewController ()

@end

@implementation promoterCodeViewController

@synthesize promoterCode;
@synthesize scrollField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
               
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    promoterCode = nil;
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
}

- (void) connectionDidFinishLoading:(NSURLConnection *) connection
{    
     if([jsonParser parseValidatePromoterCode:webData]){
         [utils allowUserToUseApp:promoterCode.text];
         UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
         [self presentViewController:controller animated:YES completion:nil ];
     }else{
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:@"Código de promotor incorrecto"
                                                        delegate:self
                                               cancelButtonTitle:@"Cerrar"
                                               otherButtonTitles:nil];
         [alert show];
     }
}


- (IBAction)onClickOk:(UIButton *)sender
{
    webData = [NSMutableData data];
	[webServiceCaller validatePromoterCode: promoterCode.text andDelegateTo: self];
}

- (IBAction)doneEditing:(id)sender{
    [sender resignFirstResponder];
}

- (IBAction)bgTouched:(id)sender {
    [promoterCode resignFirstResponder];
}

//****************   SCROLL KEYBOARD   ***************
- (IBAction)promoterCodeDidBeginEditing:(UITextField *)sender {
    promoterCode = sender;
    
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
    CGPoint fOrigin = promoterCode.frame.origin;
    fOrigin.y -= scrollField.contentOffset.y;
    fOrigin.y += promoterCode.frame.size.height;
    if (!CGRectContainsPoint(frame, fOrigin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, promoterCode.frame.origin.y + promoterCode.frame.size.height - frame.size.height);
        [scrollField setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [scrollField setContentOffset:CGPointZero animated:YES];
}

@end


