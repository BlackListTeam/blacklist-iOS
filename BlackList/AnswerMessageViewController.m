//
//  AnswerMessageViewController.m
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "AnswerMessageViewController.h"

@interface AnswerMessageViewController ()

@end



@implementation AnswerMessageViewController

@synthesize _messageThread;
@synthesize viewScroll;

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
    NSLog(@"%@",_messageThread.subject);
    
    CGRect de_frame = CGRectMake(7, 14, 16, 16);
    UILabel *de = [[UILabel alloc] initWithFrame:de_frame];
    de.text=@"De:";
    [de setBackgroundColor:[UIColor clearColor]];
    de.textColor=[UIColor colorWithRed:(97/255.0) green:(97/255.0) blue:(97/255.0) alpha:1];
    de.font = [UIFont fontWithName:@"Bebas Neue" size:18];
    
    
    CGRect from_frame = CGRectMake(24, 14, 248, 16);
    UILabel *from = [[UILabel alloc] initWithFrame:from_frame];
    from.text=_messageThread.from;
    [from setBackgroundColor:[UIColor clearColor]];
    from.textColor=[UIColor colorWithRed:(97/255.0) green:(97/255.0) blue:(97/255.0) alpha:1];
    from.font = [UIFont fontWithName:@"Bebas Neue" size:20];

    
    CGRect subject_frame = CGRectMake(7, 40, 300, 22);
    UILabel *subject = [[UILabel alloc] initWithFrame:subject_frame];
    subject.text=_messageThread.subject;
    [subject setBackgroundColor:[UIColor clearColor]];
    subject.textColor=[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1];
    subject.font = [UIFont fontWithName:@"Bebas Neue" size:24];
    
    
    
    
    CGRect container_frame=CGRectMake(0,0,600,-1);
    UIView *container= [[UIView alloc] initWithFrame:container_frame];
    
    container.userInteractionEnabled=true;
    self.viewScroll.contentSize = CGSizeMake(320,-1);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
