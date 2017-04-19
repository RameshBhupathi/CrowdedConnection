//
//  CCAppDelegate.h
//  CrowdConnection
//
//  Created by WangShou on 14-5-21.
//  Copyright (c) 2014年 WangShou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCMCManager.h"

@interface CCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CCMCManager* manager;
@end
