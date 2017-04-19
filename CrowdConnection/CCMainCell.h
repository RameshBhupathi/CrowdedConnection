//
//  CCMainCell.h
//  CrowdConnection
//
//  Created by WangShou on 14-5-21.
//  Copyright (c) 2014年 WangShou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface CCMainCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *kindLabel;
@property (weak, nonatomic) IBOutlet UIImageView *kindIView;
@property (weak, nonatomic) IBOutlet UILabel *signalLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;

- (IBAction)connect:(id)sender;


//- (id) initWithPeerID:(MCPeerID*) peer andInfo:(NSDictionary*) info andreuserIdentifier:(NSString*) identifier;
@end
