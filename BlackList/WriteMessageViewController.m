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
@synthesize _message_thread_id;

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
    textMessage.text=@"Escribe aquí tu mensaje.\nTe contestaremos tan rápido como sea posible";
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
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    Boolean added;
    if(_message_thread_id == nil){
        added=[jsonParser parseAddMessage:webData];
    }else{
        added=[jsonParser parseReplyMessage:webData];
    }
     
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
        textMessage.text=@"Escribe aquí tu mensaje.\nTe contestaremos tan rápido como sea posible";
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[jsonParser errorMessage]
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


- (IBAction)enviarMessage:(UIButton *)sender {
    if([textMessage.text isEqual: @"Escribe aquí tu mensaje.\nTe contestaremos tan rápido como sea posible"] || [textMessage.text isEqual: @""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso"
                                                        message:@"Escribe un mensaje"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }else if(_message_thread_id == nil){
        webData = [NSMutableData data];
        [webServiceCaller addMessage:textMessage.text
                       withSessionId:sessionId
                       andDelegateTo:self];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }else{
        webData = [NSMutableData data];
        [webServiceCaller replyMessage:textMessage.text
                     inMessageStreamId:_message_thread_id
                         withSessionId:sessionId
                         andDelegateTo:self];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"text: %@",textView.text);
    if([textView.text isEqual: @"Escribe aquí tu mensaje.\nTe contestaremos tan rápido como sea posible"]){
        textView.text=@"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if([textView.text isEqual: @""]){
        textView.text=@"Escribe aquí tu mensaje.\nTe contestaremos tan rápido como sea posible";
    }
}

- (IBAction)bgTouched:(id)sender {
    [textMessage resignFirstResponder];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
