//
//  TabBarController.m
//  BlackList
//
//  Created by Albert on 12/07/13.
//  Copyright (c) 2013 AndreuRM. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

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
	// Do any additional setup after loading the view.
    /*self.tabBar.tintColor = [UIColor clearColor];
    self.tabBar.shadowImage = nil;*/
    
    UITabBarItem *tabBarItem = [[self.tabBar items] objectAtIndex:0];
    [tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"0.homeS.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"0.home.png"]];
    UITabBarItem *tabBarItem1 = [[self.tabBar items] objectAtIndex:1];
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"0.messageS.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"0.message.png"]];
    UITabBarItem *tabBarItem2 = [[self.tabBar items] objectAtIndex:2];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"0.codeS.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"0.code.png"]];
    UITabBarItem *tabBarItem3 = [[self.tabBar items] objectAtIndex:3];
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"0.inviteS.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"0.invite.png"]];
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"menu"];
    self.tabBar.selectedImageTintColor = nil;
    self.tabBar.selectionIndicatorImage = [[UIImage alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
