//
//  CCMainExampleDownloadController.m
//  CrowdConnection
//
//  Created by WangShou on 14-6-18.
//  Copyright (c) 2014年 WangShou. All rights reserved.
//

#import "CCMainExampleDownloadController.h"
#import "ASIHTTPRequest.h"

@interface CCMainExampleDownloadController ()

@end

@implementation CCMainExampleDownloadController {
	float t, tot;
}

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
	NSLog(@"receive value %@", _connects);
	[_progress setProgress:0];
	t = 0.0;
	NSString *file_url = @"http://crowdconnection.sinaapp.com/static/2014062001.sql";
	if ([_connects intValue]== 1){
		tot = 5;
		file_url = @"http://crowdconnection.sinaapp.com/static/2014062001.zip";
	}
	else {
		tot = 8;
	}
	[NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(update:)
                                   userInfo:nil
                                    repeats:YES];
	NSURL *url = [NSURL URLWithString:file_url];//[NSURL URLWithString:@"http://down.newasp.net/soft1/eclipse-standard-kepler-SR1-win32.zip"];///
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDownloadProgressDelegate:_progress];
	[request startAsynchronous];
	NSLog(@"progress Value: %f", [_progress progress]);
}

- (void)update:(NSTimer *)timer
{
	t = t + 0.1;
	_time.text = [NSString stringWithFormat:@"%.2f",t];
    if([_progress progress] >= 1.0)
    {
        [timer invalidate];
    }
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
