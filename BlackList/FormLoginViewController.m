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

@implementation FormLoginViewController

@synthesize nombre;
@synthesize password;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginOK:(UIButton *)sender {
}

- (IBAction)solicitarDatosAcceso:(UIButton *)sender {
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

@end
