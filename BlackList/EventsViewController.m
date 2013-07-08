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
int id_actual;

- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen

    webData = [NSMutableData data];
    [webServiceCaller getPartyCovers: sessionId andDelegateTo:self];
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
    parties = [jsonParser parseGetPartyCovers:webData];
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
    
    /*if(){
     else{
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
     message:@"Código de promotor incorrecto"
     delegate:self
     cancelButtonTitle:@"Cerrar"
     otherButtonTitles:nil];
     [alert show];
     }*/ 
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
    NSLog(@"ID ACTUAL %i",id_actual);
    if(aux.party_id==id_actual)
    {
        NSLog(@"DINS");
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
        NSLog(@"DIns de la funcio actual Party %d",[party.date compare:[NSDate date]] == NSOrderedAscending);
        NSLog(@"DIns de la funcio actual Party %@",[NSDate date]);
        NSLog(@"DIns de la funcio actual Party %@", party.date);
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

@end
