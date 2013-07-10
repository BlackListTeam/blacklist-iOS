//
//  DetailsEventSitioViewController.m
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "DetailsEventSitioViewController.h"
#import "DetailsEventInfoViewController.h"
#import "DetailsEventSitioViewController.h"
#import "DetailsEventPrecioViewController.h"
#import "ReservationViewController.h"
#import "PicturesEventViewController.h"

@interface DetailsEventSitioViewController ()

@end

@implementation DetailsEventSitioViewController

@synthesize party = _party;
@synthesize landscapeImage;
@synthesize locationText;
@synthesize buttonReservar;
@synthesize countdown;
@synthesize buttonMap;
@synthesize buttonMapOnly;
@synthesize buttonPictures;
@synthesize days;
@synthesize minutes;
@synthesize hours;
@synthesize mapa;
@synthesize titleEvent;
@synthesize blackLine;

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
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_party.image]];
    landscapeImage.image = [UIImage imageWithData:imageData];
    locationText.text = _party.place_text;
    NSLog(@"Lol %@",_party.location_date);
    if(!_party.es_actual){
        buttonReservar.hidden = TRUE;
    }
    if ([_party.gallery count] == 0 && ([_party.location_date compare:[NSDate date]] == NSOrderedDescending)){
        //Countdown
        NSLog(@"1 ");
        [self buttonsOff];
        [self countdownReload];
    }
    else if ([_party.gallery count] == 0 && ([_party.location_date compare:[NSDate date]] == NSOrderedAscending)){
        NSLog(@"2 ");
        //Nomes Icones de mapes
        [self countdownOff];
        [self buttonsOff];
        blackLine.hidden = YES;
        buttonMapOnly.hidden = FALSE;
        [self.buttonMapOnly addTarget:self
                           action:@selector(showMap:)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    else if ([_party.gallery count] > 0 && ([_party.location_date compare:[NSDate date]] == NSOrderedDescending)){
        NSLog(@"3 ");
        [self countdownOff];
        [self.buttonMap addTarget:self
                           action:@selector(showCountdown:)
                 forControlEvents:UIControlEventTouchUpInside];
        //Dos Icones però al click del location va cap a 
    }
    else if ([_party.gallery count] > 0 && ([_party.location_date compare:[NSDate date]] == NSOrderedAscending)){
        //Dos Icones
        NSLog(@"4 ");
        [self countdownOff];
        [self.buttonMap addTarget:self
                           action:@selector(showMap:)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    titleEvent.font = [UIFont fontWithName:@"Bebas Neue" size:20];
    titleEvent.text = _party.name;
}

- (void)showCountdown:(UIButton *)sender
{
    buttonMap.hidden = TRUE;
    buttonPictures.hidden = TRUE;
    locationText.hidden = TRUE;
    countdown.hidden = FALSE;
    minutes.hidden = FALSE;
    days.hidden = FALSE;
    hours.hidden = FALSE;
    //[self countdownReload];
}

- (void)showMap:(UIButton *)sender
{
    buttonMap.hidden = TRUE;
    buttonPictures.hidden = TRUE;
    locationText.hidden = TRUE;
    countdown.hidden = TRUE;
    minutes.hidden = TRUE;
    days.hidden = TRUE;
    hours.hidden = TRUE;
    mapa.hidden = FALSE;
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = _party.latitude;
    zoomLocation.longitude= _party.longitude;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 2000, 2000);
    MKPointAnnotation *mark = [[MKPointAnnotation alloc] init];
    mark.coordinate = zoomLocation;
    mark.title = _party.name;
    [mapa addAnnotation:mark];
    [mapa setRegion:viewRegion animated:YES];
}

- (void)countdownOff
{
    countdown.hidden = TRUE;
    minutes.hidden = TRUE;
    days.hidden = TRUE;
    hours.hidden = TRUE;
}

- (void)buttonsOff
{
    buttonMap.hidden = TRUE;
    buttonPictures.hidden = TRUE;
    locationText.hidden = TRUE;
}

- (void)countdownReload
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSDateComponents *components = [gregorian components:unitFlags fromDate:[NSDate date] toDate:_party.location_date options:0];    
    
    days.text = [NSString stringWithFormat:@"%d", [components day]];
    hours.text = [NSString stringWithFormat:@"%d", [components hour]];
    minutes.text = [NSString stringWithFormat:@"%d", [components minute]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"sitioToInfo"]) {
        DetailsEventInfoViewController *controller = (DetailsEventInfoViewController *) segue.destinationViewController;
        controller.party=_party;
    }
    if ([[segue identifier] isEqualToString:@"sitioToPrecio"]) {
        DetailsEventPrecioViewController *controller = (DetailsEventPrecioViewController *) segue.destinationViewController;
        controller.party=_party;
    }
    if ([[segue identifier] isEqualToString:@"sitioToReserva"]) {
        ReservationViewController *controller = (ReservationViewController *) segue.destinationViewController;
        controller.party=_party;
    }
    if ([[segue identifier] isEqualToString:@"sitioToGallery"]) {
        PicturesEventViewController *controller = (PicturesEventViewController *) segue.destinationViewController;
        controller.party=_party;
    }
}

@end
