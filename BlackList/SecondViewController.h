//
//  SecondViewController.h
//  BlackList
//
//  Created by Albert on 20/06/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface SecondViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, retain) IBOutlet iCarousel *carousel;


@end
