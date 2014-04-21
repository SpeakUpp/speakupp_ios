//
//  QDTabBarController.m
//  QuanDiem
//
//  Created by Xuan Dung Bui on 2013/11/10.
//  Copyright (c) 2013年 QuanDiem. All rights reserved.
//

#import "QDTabBarController.h"
#import "QDAPIClient.h"

@interface QDTabBarController ()

@end

@implementation QDTabBarController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotificationCount:)
                                                 name:@"notification:new"
                                               object:nil];
    
    [[QDAPIClient sharedClient] GET:@"site/config" parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *config) {
        NSDictionary *user = config[@"user"];
        if (!user) {
            [self performSegueWithIdentifier:@"Login" sender:self];
        }
        
        
    } failure:nil];
}

- (void)receiveNotificationCount:(NSNotification*)notification {
    UIViewController *tmp = self.viewControllers[2];
    NSInteger count = [notification.object[@"newNotifications"] integerValue];
    if (count > 0) {
        tmp.tabBarItem.badgeValue = [notification.object[@"newNotifications"] stringValue];
    } else {
        tmp.tabBarItem.badgeValue = nil;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
