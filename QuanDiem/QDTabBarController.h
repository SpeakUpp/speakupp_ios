//
//  QDTabBarController.h
//  QuanDiem
//
//  Created by Xuan Dung Bui on 2013/11/10.
//  Copyright (c) 2013年 QuanDiem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QDTabBarController : UITabBarController<UIActionSheetDelegate>

@property (readonly, nonatomic) NSArray *categories;

@end
