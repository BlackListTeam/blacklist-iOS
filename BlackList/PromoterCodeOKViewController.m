//
//  PromoterCodeOKViewController.m
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "PromoterCodeOKViewController.h"

@interface PromoterCodeOKViewController ()

@end

@implementation PromoterCodeOKViewController

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

- (IBAction)contactaEmail:(UIButton *)sender
{
    NSString *emailString =[[NSString alloc] initWithFormat:@"mailto:?to=%@&subject=%@&body=%@",
                            [@"info@blacklistmeetings.com" stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding],
                            [@"Contacto" stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
                            [@"" stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:emailString]];
}
@end
