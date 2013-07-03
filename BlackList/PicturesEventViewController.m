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

- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    /*self.imageURLs = [NSMutableArray array];
    for (int i = 0; i < 1000; i++)
    {
        [imageURLs addObject:[NSNumber numberWithInt:i]];
    }*/
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

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(AsyncImageView *)view
{
    if (view == nil) {
        view = [[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 280)] autorelease];
    }
    view.imageURL=[imageURLs objectAtIndex:index];
    
    if(view ==nil)
    {
        [[AsyncImageLoader sharedLoader]cancelLoadingImagesForTarget:view];
    }
    return view;
    
}

@end

