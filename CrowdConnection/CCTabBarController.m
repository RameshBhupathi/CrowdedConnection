//
//  CCTabBarController.m
//  CrowdConnection
//
//  Created by WangShou on 14-6-11.
//  Copyright (c) 2014年 WangShou. All rights reserved.
//

#import "CCTabBarController.h"

@interface CCTabBarController ()

@end

@implementation CCTabBarController

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
	/*
	UITabBarItem* nearBar = [self.tabBar.items objectAtIndex:0];
	[nearBar setFinishedSelectedImage:[UIImage imageNamed:nil] withFinishedUnselectedImage:[UIImage imageNamed:@"bar_near"]];
	UITabBarItem* accountBar = [self.tabBar.items objectAtIndex:1];
	[accountBar setFinishedSelectedImage:[UIImage imageNamed:nil] withFinishedUnselectedImage:[UIImage imageNamed:@"bar_account"]];
	UITabBarItem* settingBar = [self.tabBar.items objectAtIndex:2];
	[settingBar setFinishedSelectedImage:[UIImage imageNamed:nil] withFinishedUnselectedImage:[UIImage imageNamed:@"bar_setting"]];
	UITabBarItem* mapBar = [self.tabBar.items objectAtIndex:3];
	[mapBar setFinishedSelectedImage:[UIImage imageNamed:nil] withFinishedUnselectedImage:[UIImage imageNamed:@"bar_map"]];
	 */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
