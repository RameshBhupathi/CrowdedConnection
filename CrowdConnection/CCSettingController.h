//
//  CCSettingController.h
//  CrowdConnection
//
//  Created by WangShou on 14-5-21.
//  Copyright (c) 2014年 WangShou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
@interface CCSettingController : UIViewController

@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *price;
@property (strong, nonatomic) IBOutlet UITextField *duration;
@end
