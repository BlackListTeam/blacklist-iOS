//
//  PicturesEventViewController.m
//  BlackList
//
//  Created by Albert on 01/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "PicturesEventViewController.h"
#import "AsyncImageView.h"

@interface PicturesEventViewController ()

@property (nonatomic, retain) NSMutableArray *imageURLs;

@end

@implementation PicturesEventViewController


@synthesize carousel;
@synthesize imageURLs;

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    
    carousel.delegate = nil;
    carousel.dataSource = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Images" ofType:@"plist"];
    NSArray *imagePaths = [NSArray arrayWithContentsOfFile:plistPath];
    
    //remote image URLs
    NSMutableArray *URLs = [NSMutableArray array];
    for (NSString *path in imagePaths)
    {
        NSURL *URL = [NSURL URLWithString:path];
        if (URL)
        {
            [URLs addObject:URL];
        }
        else
        {
            NSLog(@"'%@' is not a valid URL", path);
        }
    }
    self.imageURLs = URLs;

    
    
    //configure carousel
    carousel.type = iCarouselTypeCoverFlow2;
    carousel.vertical = YES;
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

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    #define IMAGE_VIEW_TAG 99
    //create new view if no view is available for recycling
    if (view == nil)
    {
        NSLog(@"asfasdf %i",index);
        NSLog(@"asfasdf %@",[imageURLs objectAtIndex:index]);
        AsyncImageView *view = [[AsyncImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 200.0f)];
        view.imageURL = [imageURLs objectAtIndex:index];
		view.contentMode = UIViewContentModeCenter;
        /*label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];*/

        
        /*view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];*/
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //AsyncImageView *view = (AsyncImageView *)[view viewWithTag:IMAGE_VIEW_TAG];
	
    //cancel loading previous image for cell
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:view];
    
    //load the image
    //view.imageURL = [imageURLs objectAtIndex:index];

    
    return view;
}

@end

