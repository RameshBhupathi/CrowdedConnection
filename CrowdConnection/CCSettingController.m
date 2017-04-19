//
//  CCSettingController.m
//  CrowdConnection
//
//  Created by WangShou on 14-5-21.
//  Copyright (c) 2014年 WangShou. All rights reserved.
//

#import "CCSettingController.h"

@interface CCSettingController ()

@end

@implementation CCSettingController

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
    if (self) {
		// Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - Keyboard Display
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	/*
    if (textField == _name) {
        [_name becomeFirstResponder];
    }
    
    else if (textField == _price) {
        [_price becomeFirstResponder];
    }
    
    else if (textField == _duration) {
        [_duration becomeFirstResponder];
    }
    
    else{
        [textField resignFirstResponder];
    }
    */
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //[_scrollView adjustOffsetToIdealIfNeeded];
}

@end
