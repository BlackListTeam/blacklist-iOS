//
//  PicturesEventViewController.h
//  BlackList
//
//  Created by Albert on 01/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "Party.h"

@interface PicturesEventViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>{
    Party * _party;
}
@property (nonatomic, retain) Party * party;

@property (nonatomic, retain) IBOutlet iCarousel *carousel;

@end