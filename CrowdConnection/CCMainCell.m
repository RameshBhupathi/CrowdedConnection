//
//  CCMainCell.m
//  CrowdConnection
//
//  Created by WangShou on 14-5-21.
//  Copyright (c) 2014年 WangShou. All rights reserved.
//

#import "CCMainCell.h"

@implementation CCMainCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
 - (void)awakeFromNib
 {
 // Initialization code
 }
 - (void)setSelected:(BOOL)selected animated:(BOOL)animated
 {
 [super setSelected:selected animated:animated];
 
 // Configure the view for the selected state
 }
 #pragma mark 设置Cell的边框宽度
 - (void)setFrame:(CGRect)frame {
 [super setFrame:frame];
 }


//TO delete
/*
- (id) initWithPeerID:(MCPeerID*) peer andInfo:(NSDictionary*) info andreuserIdentifier:(NSString*) identifier
{
	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if (self) {
        // Initialization code
		self.kindLabel.text = [info valueForKey:@"kind"];
		self.kindIView.image = [UIImage imageNamed: [info valueForKey:@"signalType"]];
		self.signalLabel.text = [info valueForKey:@"signal"];
		self.priceLabel.text = [info valueForKey:@"price"];
		NSLog(@"fuck!!!!!%@, %@", [info valueForKey:@"price"], self.priceLabel.text);
		self.durationLabel.text = [info valueForKey:@"duration"];
    }
    return self;
}
 */

#pragma mark conenct action
- (IBAction)connect:(id)sender {
	
}
@end
