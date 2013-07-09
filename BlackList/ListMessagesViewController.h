//
//  ListMessagesViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webServiceCaller.h"
#import "jsonParser.h"

@interface ListMessagesViewController : UIViewController
<NSURLConnectionDelegate>
{
@private NSMutableData *webData;
}
@property (strong, nonatomic) IBOutlet UIScrollView *viewScroll;
@property (nonatomic, retain) NSMutableArray *messages;


@end
