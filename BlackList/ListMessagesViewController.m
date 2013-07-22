//
//  ListMessagesViewController.m
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "ListMessagesViewController.h"

@interface ListMessagesViewController ()

@end

NSString *sessionId;


@implementation ListMessagesViewController

@synthesize messages;
@synthesize viewScroll;
@synthesize deleteMsg;
@synthesize indexClicked;


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
    //viewScroll.userInteractionEnabled=YES;
    indexClicked=-1;
    deleteMsg=false;
    webData = [NSMutableData data];
    [webServiceCaller getMessages:sessionId andDelegateTo:self];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [webServiceCaller readMessages:sessionId andDelegateTo:nil];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[[[[self tabBarController] tabBar] items]
      objectAtIndex:1] setBadgeValue:nil];
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
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error de conexión"
                                                    message:@"No ha sido posible conectarse con los servidores de Blacklist"
                                                   delegate:nil
                                          cancelButtonTitle:@"Cerrar"
                                          otherButtonTitles:nil];
    [alert show];
}



- (void) connectionDidFinishLoading:(NSURLConnection *) connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if(deleteMsg){
        Boolean deleted = [jsonParser parseDeleteMessage:webData];
        if([jsonParser authError]){
            UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FormLoginViewController"];
            [self presentViewController:controller animated:YES completion:nil ];
        }else{
            if(deleted){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje borrado correctamente"
                                                                message:nil
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
                deleteMsg=false;
                webData = [NSMutableData data];
                [webServiceCaller getMessages:sessionId andDelegateTo:self];
                [alert show];
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:[jsonParser errorMessage]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Cerrar"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }

    }else{
        messages = [jsonParser parseGetMessages:webData];
        if([messages count] == 0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Información"
                                                            message:@"No tienes ningún mensaje."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Cerrar"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        if([jsonParser authError]){
            UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FormLoginViewController"];
            [self presentViewController:controller animated:YES completion:nil ];
        }else{
            
            for(UIView *subview in [viewScroll subviews]) {
                [subview removeFromSuperview];
            }
            
            int yo=0;
            int yd=85;
            int i=0;
            
            for(MessageThread *messageThread in messages){
                
                UIImage *bkg = [UIImage imageNamed:@"15.de_.png"];
                UIImageView *container= [[UIImageView alloc] initWithImage:bkg];
                CGRect container_frame=CGRectMake(4,yo+(yd*i),313,82);
                container.frame=container_frame;
                container.userInteractionEnabled=true;
                
                
                UIImage *tras_img = [UIImage imageNamed:@"15.buttonTras.png"];
                CGRect trash_frame = CGRectMake(280, 2, 31, 32);
                UIButton *trash = [UIButton buttonWithType:UIButtonTypeCustom];
                trash.frame = trash_frame;
                trash.userInteractionEnabled=YES;
                [trash setImage:tras_img forState:UIControlStateNormal];
                [trash addTarget:self action:@selector(trashClicked:) forControlEvents:UIControlEventTouchUpInside];
                [trash setTag:i];
                [container addSubview:trash];
                
                
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                             action:@selector(labelTapped:)];
                tapGesture.numberOfTapsRequired = 1;
                CGRect from_frame = CGRectMake(24, 14, 248, 16);
                UILabel *from = [[UILabel alloc] initWithFrame:from_frame];
                from.userInteractionEnabled = YES;
                from.text=messageThread.from;
                [from addGestureRecognizer:tapGesture];
                [from setTag:i];
                [from setBackgroundColor:[UIColor clearColor]];
                from.textColor=[UIColor colorWithRed:(97/255.0) green:(97/255.0) blue:(97/255.0) alpha:1];
                from.font = [UIFont fontWithName:@"Bebas Neue" size:20];
                [container addSubview:from];
                
                
                UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(labelTapped:)];
                tapGesture2.numberOfTapsRequired = 1;
                CGRect subject_frame = CGRectMake(7, 40, 300, 22);
                UILabel *subject = [[UILabel alloc] initWithFrame:subject_frame];
                subject.userInteractionEnabled = YES;
                subject.text=messageThread.subject;
                [subject addGestureRecognizer:tapGesture2];
                [subject setTag:i];
                [subject setBackgroundColor:[UIColor clearColor]];
                subject.textColor=[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1];
                subject.font = [UIFont fontWithName:@"Bebas Neue" size:24];
                [container addSubview:subject];
                
                [self.viewScroll addSubview:container];
                i++;
            }
            self.viewScroll.contentSize = CGSizeMake(320,i*85+3);
        }
    }
    
    
    deleteMsg=false;
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        deleteMsg=true;
        webData = [NSMutableData data];
        [webServiceCaller deleteMessage: [[messages objectAtIndex:indexClicked] mt_id]
                          withSessionId:sessionId
                          andDelegateTo:self];
    }
}

-(void) trashClicked: (id) sender
{
    UIButton *aux=sender;
    indexClicked=aux.tag;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atención"
                                                    message:@"Estás seguro de querer borrar el mensaje"
                                                   delegate:self
                                          cancelButtonTitle:@"Si"
                                          otherButtonTitles:@"No",nil];
    [alert show];
}


-(void) labelTapped:(UIGestureRecognizer *)sender
{
    UILabel *aux=(UILabel *)sender.view;
    
    AnswerMessageViewController* answerMessageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AnswerMessageViewController"];
    answerMessageViewController._messageThread=[messages objectAtIndex:aux.tag];
    [self.navigationController pushViewController:answerMessageViewController
                                         animated:YES];
    
}



- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
