//
//  DetailsEventSitioViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Party.h"

@interface DetailsEventSitioViewController : UIViewController{
    Party * _party;
}
@property (nonatomic, retain) Party * party;
@property (strong, nonatomic) IBOutlet UIImageView *landscapeImage;
@property (strong, nonatomic) IBOutlet UITextView *locationText;
@property (strong, nonatomic) IBOutlet UIButton *buttonReservar;
@property (strong, nonatomic) IBOutlet UIImageView *countdown;
@property (strong, nonatomic) IBOutlet UIButton *buttonMap;
@property (strong, nonatomic) IBOutlet UIButton *buttonPictures;
@property (strong, nonatomic) IBOutlet UILabel *days;
@property (strong, nonatomic) IBOutlet UILabel *hours;
@property (strong, nonatomic) IBOutlet UILabel *minutes;
@property (strong, nonatomic) IBOutlet MKMapView *mapa;
@property (strong, nonatomic) IBOutlet UILabel *titleEvent;
@property (strong, nonatomic) IBOutlet UIButton *buttonMapOnly;
@property (strong, nonatomic) IBOutlet UIView *blackLine;
@property (weak, nonatomic) IBOutlet UILabel *dias;
@property (weak, nonatomic) IBOutlet UILabel *horas;
@property (weak, nonatomic) IBOutlet UILabel *minutos;

- (IBAction)back:(id)sender;
@end
