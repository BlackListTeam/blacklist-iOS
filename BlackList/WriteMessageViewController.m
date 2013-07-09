//
//  WriteMessageViewController.m
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "WriteMessageViewController.h"

@interface WriteMessageViewController ()

@end

NSString *sessionId;

@implementation WriteMessageViewController

@synthesize textMessage;

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
    textMessage.delegate=self;
	// Do any additional setup after loading the view.
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error de conexión"
                                                    message:@"No ha sido posible conectarse con los servidores de Blacklist"
                                                   delegate:nil
                                          cancelButtonTitle:@"Cerrar"
                                          otherButtonTitles:nil];
    [alert show];
}
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ListMessagesViewController"];
    [self.navigationController pushViewController:controller animated:YES ];
}


- (void) connectionDidFinishLoading:(NSURLConnection *) connection
{
    
    Boolean added=[jsonParser parseAddMessage:webData];
    if([jsonParser authError]){
        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FormLoginViewController"];
        [self presentViewController:controller animated:YES completion:nil ];
    }else if(added){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso"
                                                        message:@"Mensaje envíado correctamente"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
        textMessage.text=@"Escribe un mensaje...";
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[jsonParser errorMessage]
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)descartarText:(id)sender {
}

- (IBAction)enviarMessage:(UIButton *)sender {
    if([textMessage.text isEqual: @"Escribe un mensaje..."] || [textMessage.text isEqual: @""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso"
                                                        message:@"Escribe un mensaje"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        webData = [NSMutableData data];
        [webServiceCaller addMessage:textMessage.text withSessionId:sessionId andDelegateTo:self];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqual: @"Escribe un mensaje..."]){
        textView.text=@"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if([textView.text isEqual: @""]){
        textView.text=@"Escribe un mensaje...";
    }
}

- (IBAction)bgTouched:(id)sender {
    [textMessage resignFirstResponder];
}
@end
