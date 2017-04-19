//
//  CCMainExampleDownloadController.h
//  CrowdConnection
//
//  Created by WangShou on 14-6-18.
//  Copyright (c) 2014年 WangShou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCMainExampleDownloadController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UIProgressView *progress;

@property(nonatomic,weak)NSNumber *connects;
@end
