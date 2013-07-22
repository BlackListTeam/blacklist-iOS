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
@synthesize payUrl;

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
    
    
    
    CGRect date_frame = CGRectMake(172, 10, 123, 14);
    UILabel *date = [[UILabel alloc] initWithFrame:date_frame];
    date.text=[utils prettyDate:msj.date];
    [date setBackgroundColor:[UIColor clearColor]];
    date.textColor=[UIColor colorWithRed:(34/255.0) green:(34/255.0) blue:(34/255.0) alpha:1];
    date.font = [UIFont fontWithName:@"Bebas Neue" size:16];
    date.textAlignment = NSTextAlignmentRight;
    
    
    UILabel *pay1;
    CGRect container_frame=CGRectMake(7,0,300,74+message_frame.size.height+7);
    
    if(![[NSString stringWithFormat:@"%@",msj.pay_link] isEqual: @""]){
        UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(pay:)];
        tapGesture3.numberOfTapsRequired = 1;
        CGRect pay1_frame = CGRectMake(0, 74+message_frame.size.height+7, 286, 20);
        pay1 = [[UILabel alloc] initWithFrame:pay1_frame];
        pay1.userInteractionEnabled = YES;
        pay1.text=@"PAGAR";
        [pay1 addGestureRecognizer:tapGesture3];
        [pay1 setBackgroundColor:[UIColor clearColor]];
        pay1.textColor=[UIColor colorWithRed:(0/255.0) green:(131/255.0) blue:(88/255.0) alpha:1];
        pay1.font = [UIFont fontWithName:@"Bebas Neue" size:20];
        pay1.textAlignment = NSTextAlignmentRight;
        payUrl=msj.pay_link;
        
        container_frame=CGRectMake(7,0,300,74+message_frame.size.height+7+20+7);
    }

    
    
    
    
    
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
    [container addSubview:date];
    if(![[NSString stringWithFormat:@"%@",msj.pay_link] isEqual: @""]){
        [container addSubview:pay1];
    }
    
    [self.viewScroll addSubview:container];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(reply:)];
    tapGesture.numberOfTapsRequired = 1;
    CGRect reply_frame = CGRectMake(120, 380, 80, 20);
    UILabel *reply = [[UILabel alloc] initWithFrame:reply_frame];
    reply.userInteractionEnabled = YES;
    reply.text=@"Contestar";
    [reply addGestureRecognizer:tapGesture];
    [reply setBackgroundColor:[UIColor clearColor]];
    reply.textColor=[UIColor colorWithRed:(0/255.0) green:(131/255.0) blue:(88/255.0) alpha:1];
    reply.font = [UIFont fontWithName:@"Bebas Neue" size:20];
    reply.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:reply];
    
    int next_y=container_frame.size.height+7;
    Boolean first_item=true;
    for(Message *m in _messageThread.messages){
        if(first_item){
            first_item=false;
            continue;
        }
        CGRect m_date_frame = CGRectMake(7, 12, 266, 12);
        UILabel *m_date = [[UILabel alloc] initWithFrame:m_date_frame];
        m_date.text=[utils prettyDate:m.date];
        [m_date setBackgroundColor:[UIColor clearColor]];
        m_date.textColor=[UIColor colorWithRed:(34/255.0) green:(34/255.0) blue:(34/255.0) alpha:1];
        m_date.font = [UIFont fontWithName:@"Bebas Neue" size:16];
        
        
        
        CGSize s2;
        s2.width = 286;
        s2.height = 10000;
        CGRect text_frame = CGRectMake(7, 34, 236, [m.text sizeWithFont:[UIFont
                                                                              fontWithName:@"Bebas Neue"
                                                                              size:20]
                                                           constrainedToSize: s2].height);
        UILabel *m_text = [[UILabel alloc] initWithFrame:text_frame];
        m_text.text=m.text;
        [m_text setBackgroundColor:[UIColor clearColor]];
        m_text.textColor=[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1];
        m_text.font = [UIFont fontWithName:@"Bebas Neue" size:20];
        //[m_text sizeToFit];
        m_text.numberOfLines = 0;
        
        CGRect wrapper_frame;
        if(m.answer){
            wrapper_frame=CGRectMake(57,next_y,250,34+text_frame.size.height+7);
        }else{
            wrapper_frame=CGRectMake(7,next_y,250,34+text_frame.size.height+7);
        }
        
        UILabel *pay;
        
        if(![[NSString stringWithFormat:@"%@",m.pay_link] isEqual: @""]){
            UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(pay:)];
            tapGesture2.numberOfTapsRequired = 1;
            CGRect pay_frame = CGRectMake(0, 34+text_frame.size.height+7, 243, 20);
            pay = [[UILabel alloc] initWithFrame:pay_frame];
            pay.userInteractionEnabled = YES;
            pay.text=@"PAGAR";
            [pay addGestureRecognizer:tapGesture2];
            [pay setBackgroundColor:[UIColor clearColor]];
            pay.textColor=[UIColor colorWithRed:(0/255.0) green:(131/255.0) blue:(88/255.0) alpha:1];
            pay.font = [UIFont fontWithName:@"Bebas Neue" size:20];
            pay.textAlignment = NSTextAlignmentRight;
            if(m.answer){
                wrapper_frame=CGRectMake(57,next_y,250,34+text_frame.size.height+20+15);
            }else{
                wrapper_frame=CGRectMake(7,next_y,250,34+text_frame.size.height+20+15);
            }
            payUrl=m.pay_link;
        }
        
        UIView *wrapper= [[UIView alloc] initWithFrame:wrapper_frame];
        wrapper.backgroundColor=[UIColor blackColor];
        
        
        
        
        [wrapper addSubview:m_date];
        [wrapper addSubview:m_text];
        if(![[NSString stringWithFormat:@"%@",m.pay_link] isEqual: @""]){
            [wrapper addSubview:pay];
        }
        
        [self.viewScroll addSubview:wrapper];
        next_y=next_y+wrapper_frame.size.height+7;
    }
    
    self.viewScroll.contentSize = CGSizeMake(320,next_y+12);
    
    [self.viewScroll scrollRectToVisible:CGRectMake(0, 0, 320, next_y+12) animated:YES];
}

- (void) pay:(UIGestureRecognizer *)sender
{
    [[UIApplication sharedApplication]
     openURL:[NSURL URLWithString:payUrl]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) reply:(UIGestureRecognizer *)sender
{
    WriteMessageViewController* writeMessageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WriteMessageViewController"];
    writeMessageViewController._message_thread_id=_messageThread.mt_id;
    [self.navigationController pushViewController:writeMessageViewController
                                         animated:YES];
    
}

@end
