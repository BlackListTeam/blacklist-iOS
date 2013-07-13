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

@synthesize party = _party;
@synthesize carousel;
@synthesize imageURLs;

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
    self.imageURLs = _party.gallery;
    //configure carousel
    carousel.type = iCarouselTypeCoverFlow2;
    carousel.vertical = YES;
    [self.carousel reloadData];
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

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end

