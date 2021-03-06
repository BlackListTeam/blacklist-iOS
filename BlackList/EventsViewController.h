//
//  EventsViewController.h
//  BlackList
//
//  Created by Albert on 01/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "jsonParser.h"
#import "webServiceCaller.h"

@interface EventsViewController : UIViewController <iCarouselDataSource, iCarouselDelegate, NSURLConnectionDelegate>
{
    @private NSMutableData *webData;
    Boolean carouselLoaded;
}
@property (nonatomic, retain) IBOutlet iCarousel *carousel;
@property (strong, nonatomic) IBOutlet UILabel *titleEvent;
@property (nonatomic) Boolean carouselLoaded;

- (IBAction)back:(id)sender;
@end
