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
    
    CGRect de_frame = CGRectMake(7, 12, 20, 18);
    UILabel *de = [[UILabel alloc] initWithFrame:de_frame];
    de.text=@"De:";
    [de setBackgroundColor:[UIColor clearColor]];
    de.textColor=[UIColor colorWithRed:(97/255.0) green:(97/255.0) blue:(97/255.0) alpha:1];
    de.font = [UIFont fontWithName:@"Bebas Neue" size:18];
    
    
    CGRect from_frame = CGRectMake(26, 12, 248, 16);
    UILabel *from = [[UILabel alloc] initWithFrame:from_frame];
    from.text=_messageThread.from;
    [from setBackgroundColor:[UIColor clearColor]];
    from.textColor=[UIColor colorWithRed:(97/255.0) green:(97/255.0) blue:(97/255.0) alpha:1];
    from.font = [UIFont fontWithName:@"Bebas Neue" size:20];

    
    CGRect subject_frame = CGRectMake(7, 36, 286, 22);
    UILabel *subject = [[UILabel alloc] initWithFrame:subject_frame];
    subject.text=_messageThread.subject;
    [subject setBackgroundColor:[UIColor clearColor]];
    subject.textColor=[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1];
    subject.font = [UIFont fontWithName:@"Bebas Neue" size:24];
    
    
    Message *msj = [_messageThread.messages objectAtIndex:0];
    CGSize s;
    s.width = 300;
    s.height = 10000;
    CGRect message_frame = CGRectMake(7, 74, 286, [msj.text sizeWithFont:[UIFont
                                                                          fontWithName:@"Bebas Neue"
                                                                          size:20]
                                                       constrainedToSize: s].height);
    UILabel *message = [[UILabel alloc] initWithFrame:message_frame];
    message.text=msj.text;
    [message setBackgroundColor:[UIColor clearColor]];
    message.textColor=[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1];
    message.font = [UIFont fontWithName:@"Bebas Neue" size:20];
    //[message sizeToFit];
    message.numberOfLines = 0;
    
    
    CGRect container_frame=CGRectMake(0,0,300,74+message_frame.size.height+7);
    UIView *container= [[UIView alloc] initWithFrame:container_frame];
    container.backgroundColor=[UIColor blackColor];
    //container.userInteractionEnabled=true;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(7, 64, 286, 2)];
    lineView.backgroundColor = [UIColor colorWithRed:(61/255.0) green:(61/255.0) blue:(61/255.0) alpha:1];
    [container addSubview:lineView];
    
    
    [container addSubview:de];
    [container addSubview:from];
    [container addSubview:subject];
    [container addSubview:message];
    [self.viewScroll addSubview:container];
    
    
    
    
    
    self.viewScroll.contentSize = CGSizeMake(320,900);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
