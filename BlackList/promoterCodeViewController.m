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
    [jsonParser parseAddUser:webData];
    NSLog(@"%@",[jsonParser errorMessage]);
    
    /*   if([jsonParser parseValidatePromoterCode:webData]){
     NSLog(@"OK");
     
     
     }else{
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
     message:@"Código de promotor incorrecto"
     delegate:self
     cancelButtonTitle:@"Cerrar"
     otherButtonTitles:nil];
     [alert show];
     }*/
}

- (IBAction)onClickOk:(UIButton *)sender {
    webData = [NSMutableData data];
    
	//[webServiceCaller validatePromoterCode: promoterCode.text andDelegateTo: self];
    [webServiceCaller addUser: [[User alloc] initWithName:@"Andreu Reca"
                                                 andEmail:@"test@testfromApp.com"
                                             andBirthYear:@"1986"]
             withPromoterCode:@"TEST1234"
                andDelegateTo: self];}

- (IBAction)doneEditing:(id)sender{
    [sender resignFirstResponder];
}

- (IBAction)bgTouched:(id)sender {
    [promoterCode resignFirstResponder];
}

@end
