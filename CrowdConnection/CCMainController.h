//
//  CCMainController.h
//  CrowdConnection
//
//  Created by WangShou on 14-5-21.
//  Copyright (c) 2014年 WangShou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCMainCell.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface CCMainController : UIViewController<UITableViewDelegate,UITableViewDataSource, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollMainView;

@property (weak, nonatomic) IBOutlet UITableView *nearAvailabels;
@property (weak, nonatomic) IBOutlet UISwitch *visibleSwitch;
@property (weak, nonatomic) IBOutlet UITextField *sailPriceSetting;

- (IBAction)visibleChange:(id)sender;

- (IBAction)priceChange:(id)sender;
- (IBAction)examplesShow:(id)sender;


@end
