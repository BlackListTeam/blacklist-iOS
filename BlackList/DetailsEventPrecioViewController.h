//
//  DetailsEventPrecioViewController.h
//  BlackList
//
//  Created by Albert on 02/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Party.h"

@interface DetailsEventPrecioViewController : UIViewController{
    Party * _party;
}
@property (nonatomic, retain) Party * party;
@property (strong, nonatomic) IBOutlet UIImageView *landscapeImage;

@end
