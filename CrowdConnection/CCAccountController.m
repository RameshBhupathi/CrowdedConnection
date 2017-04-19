//
//  CCAccountController.m
//  CrowdConnection
//
//  Created by WangShou on 14-5-21.
//  Copyright (c) 2014年 WangShou. All rights reserved.
//

#import "CCAccountController.h"
#import "CCAppDelegate.h"
#import "WMGaugeView.h"
#import "KWPopoverView.h"


#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface CCAccountController ()

@property (strong, nonatomic) IBOutlet WMGaugeView *speedupGauge;
@property (strong, nonatomic) IBOutlet WMGaugeView *budgetGauge;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@property (nonatomic, strong) CCAppDelegate *appDelegate;

@property (strong, nonatomic) IBOutlet UILabel *speedText;
@end

@implementation CCAccountController

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
	
	_appDelegate = (CCAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	//speed up gauge
	_speedupGauge.maxValue = 100.0;
    _speedupGauge.scaleDivisions = 10;
    _speedupGauge.scaleSubdivisions = 5;
    _speedupGauge.scaleStartAngle = 30;
    _speedupGauge.scaleEndAngle = 280;
    _speedupGauge.innerBackgroundStyle = WMGaugeViewInnerBackgroundStyleFlat;
    _speedupGauge.showScaleShadow = NO;
    _speedupGauge.scaleFont = [UIFont fontWithName:@"AvenirNext-UltraLight" size:0.065];
    _speedupGauge.scalesubdivisionsaligment = WMGaugeViewSubdivisionsAlignmentCenter;
    _speedupGauge.scaleSubdivisionsWidth = 0.002;
    _speedupGauge.scaleSubdivisionsLength = 0.04;
    _speedupGauge.scaleDivisionsWidth = 0.007;
    _speedupGauge.scaleDivisionsLength = 0.07;
    _speedupGauge.needleStyle = WMGaugeViewNeedleStyleFlatThin;
    _speedupGauge.needleWidth = 0.012;
    _speedupGauge.needleHeight = 0.4;
    _speedupGauge.needleScrewStyle = WMGaugeViewNeedleScrewStylePlain;
    _speedupGauge.needleScrewRadius = 0.05;
	
	//budget gauge
	_budgetGauge.maxValue = 240.0;
    _budgetGauge.showRangeLabels = YES;
    _budgetGauge.rangeValues = @[ @50,                  @90,                @130,               @240.0              ];
    _budgetGauge.rangeColors = @[ RGB(232, 111, 33),    RGB(232, 231, 33),  RGB(27, 202, 33),   RGB(231, 32, 43)    ];
    _budgetGauge.rangeLabels = @[ @"VERY LOW",          @"LOW",             @"OK",              @"OVER FILL"        ];
    _budgetGauge.unitOfMeasurement = @"budget";
    _budgetGauge.showUnitOfMeasurement = YES;
	
	//content View
	_contentView.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - view event

- (void)viewDidAppear:(BOOL)animated
{
	NSLog(@"did appear");
	[super viewDidAppear:animated];
	_budgetGauge.value = 0.0;
	_speedupGauge.value	= 0.0;
	_speedText.text = @"0%";
	[NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(gaugeUpdateTimer:)
                                   userInfo:nil
                                    repeats:NO];
	_indicator.hidden = YES;
}


-(void)gaugeUpdateTimer:(NSTimer *)timer
{
	if ([_appDelegate.manager isConnected]) {
		_speedupGauge.value	= 73.0;
		_speedText.text = @"73%";
		
	}else {
		_speedupGauge.value	= 0.0;
		_speedText.text = @"0%";
	}
	_budgetGauge.value = 20.0;
}


- (void)viewWillDisappear:(BOOL)animated
{
	
	NSLog(@"will disappear");
	_budgetGauge.value = 0.0;
	_speedupGauge.value	= 0.0;
	[super viewWillDisappear:animated];
	
}
- (IBAction)popContent:(id)sender forEvent:(UIEvent *)event {
	_indicator.hidden = NO;
	[_indicator startAnimating];
	[NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(indicatesimulate:)
                                   userInfo:nil
                                    repeats:NO];
	
}

- (void) indicatesimulate:(NSTimer*)timer
{
	[_indicator stopAnimating];
	_indicator.hidden = YES;
	_contentView.hidden = ! _contentView.hidden;
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
