//
//  EventsViewController.m
//  BlackList
//
//  Created by Albert on 01/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "EventsViewController.h"
#import "AsyncImageView.h"
#import "DetailsEventInfoViewController.h"
#import "Party.h"

@interface EventsViewController ()

@property (nonatomic, retain) NSMutableArray *imageURLs;
@property (nonatomic, retain) NSMutableArray *parties;

@end

NSString *sessionId;
@implementation EventsViewController

@synthesize carousel;
@synthesize imageURLs;
@synthesize parties;
@synthesize titleEvent;
@synthesize carouselLoaded;
int id_actual;

- (void)awakeFromNib
{
    
    webData = [NSMutableData data];
    [webServiceCaller getPartyCovers: sessionId andDelegateTo:self];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
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
    if(!carouselLoaded){
        parties = [jsonParser parseGetPartyCovers:webData];
        if([parties count] == 0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Información"
                                                            message:@"Aún no existe ninguna fiesta. Vuelve pronto para saber cuando será la próxima."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Cerrar"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else{
            [self actualParty];
            NSMutableArray *URLs = [NSMutableArray array];
            for (Party *party in parties)
            {
                NSURL *URL = [NSURL URLWithString:party.cover];
                if (URL)
                {
                    [URLs addObject:URL];
                }
                else
                {
                    NSLog(@"'%@' is not a valid URL", party.cover);
                }
            }
            self.imageURLs = URLs;
            [self.carousel reloadData];
        }
        webData = [NSMutableData data];
        [webServiceCaller getNewMessages:sessionId andDelegateTo:self];
    }else{
        int new_messages=[jsonParser parseGetNewMessages:webData];
        if([jsonParser authError]){
            UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FormLoginViewController"];
            [self presentViewController:controller animated:YES completion:nil ];
        }else if(new_messages>0){
            [[[[[self tabBarController] tabBar] items]
              objectAtIndex:1] setBadgeValue:[NSString stringWithFormat:@"%d", new_messages]];
        }
        
    }
    carouselLoaded=true;
}

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    carousel.delegate = nil;
    carousel.dataSource = nil;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //configure carousel
    carouselLoaded=false;
    titleEvent.font = [UIFont fontWithName:@"Bebas Neue" size:13];
    titleEvent.text = @"EVENTOS";
    carousel.type = iCarouselTypeCoverFlow2;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    //free up memory by releasing subviews
    self.carousel = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [imageURLs count];
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    Party *party_aux=[parties objectAtIndex: carousel.currentItemIndex];
    if (party_aux.party_id==id_actual){
        titleEvent.text = @"PRÓXIMO EVENTO";
    }
    else if([party_aux.date compare:[NSDate date]] == NSOrderedAscending){
        titleEvent.text = @"EVENTO PASADO";
    }
    else if([party_aux.date compare:[NSDate date]] == NSOrderedDescending){
        titleEvent.text = @"EVENTO FUTURO";
    }
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(AsyncImageView *)view
{
    if (view == nil) {
        view = [[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)] autorelease];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(0.0f, 0.0f, 200.0f, 200.0f);
        button.tag = index;
		[button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
    view.imageURL=[imageURLs objectAtIndex:index];
    Party *aux=[parties objectAtIndex:index];
    if(aux.party_id==id_actual)
    {
        [self.carousel scrollToItemAtIndex: index animated: YES];
    }
    if(view ==nil)
    {
        [[AsyncImageLoader sharedLoader]cancelLoadingImagesForTarget:view];
    }
    return view;
}

- (void)actualParty
{
    id_actual=0;
    for (Party *party in parties)
    {
        //Si hoy es antes que la date de la party, cogemos el id de la party anterior
        if(!([party.date compare:[NSDate date]] == NSOrderedAscending) && id_actual == 0){
            id_actual = party.party_id;
            party.es_actual = TRUE;
        }
    }
}

#pragma mark -
#pragma mark Button tap event

- (void)buttonTapped:(UIButton *)sender
{
    UIButton *button = (UIButton *)sender;
    DetailsEventInfoViewController* detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsEventInfoViewController"];
    detailViewController.party=[parties objectAtIndex:button.tag];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
