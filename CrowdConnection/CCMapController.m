//
//  CCMapController.m
//  CrowdConnection
//
//  Created by WangShou on 14-5-21.
//  Copyright (c) 2014年 WangShou. All rights reserved.
//

#import "CCMapController.h"

@interface CCMapController ()
@end


@implementation CCMapController {
	QAppKeyCheck* appKeyCheck;
}
@synthesize mapView = _mapView;

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
    //Qmap check
	QAppKeyCheck* check = [[QAppKeyCheck alloc] init];
	[check start:@"T4PBZ-4JY3J-CJZFL-KLK3Y-6K6A7-ECBOY" withDelegate:self];
	appKeyCheck = check;
	//Qmap view
	_mapView.delegate = self;
    //[_mapView setShowsUserLocation:YES];
	
	//wifi samples
	[self addWifiWithLa:40.006300 andLo:116.327147 andRSSI:100 andTitle:@"TsingHua" andDiscription:@"听涛园：清华最难吃的食堂"];
	[self addWifiWithLa:40.002405 andLo:116.327791 andRSSI:150 andTitle:@"TsingHua" andDiscription:@"四教"];
	[self addWifiWithLa:39.997276 andLo:116.331160 andRSSI:200 andTitle:@"FIT1-1512" andDiscription:@"密码:123456"];
	[self addWifiWithLa:40.009538 andLo:116.329916 andRSSI:100 andTitle:@"IVI" andDiscription:@"无密码，ipv6实验网络"];
	//user samples
	[self addWifiWithLa:40.008026 andLo:116.330345 andRSSI:20 andTitle:@"user" andDiscription:@"学生，将会在学校呆一天，一直开启共享"];
	//zoom
	CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(40.006300,116.327147);
	[self.mapView setCenterCoordinate:coords];
	QCoordinateRegion region = QCoordinateRegionMake(coords, QCoordinateSpanMake(0.01,0.01));
	[self.mapView setRegion:region];
	
	[NSTimer scheduledTimerWithTimeInterval:5.0
									 target:self
								   selector:@selector(userAnnotationUpdate:)
								   userInfo:nil
									repeats:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.mapView = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private wifi and user
- (void) addWifiWithLa:(CLLocationDegrees)la andLo:(CLLocationDegrees)lo andRSSI:(double)rssi andTitle:(NSString*)title andDiscription:(NSString*)discription
{
	QPointAnnotation* annotation = [[QPointAnnotation alloc]init];
	CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(la,lo);
    [annotation setCoordinate:coor];
    [annotation setTitle:title];
    [annotation setSubtitle:discription];
    [self.mapView addAnnotation:annotation];
	if ([title isEqualToString:@"user"]) {
		//DO Nothing
	}else {
		QCircle* circle = [QCircle circleWithCenterCoordinate:coor
                                                   radius:rssi];
		[self.mapView addOverlay:circle];
	}
}

- (void) userAnnotationUpdate: (NSTimer*)timmer
{
	NSArray *anns = [self.mapView annotations];
	for (QPointAnnotation *an in anns) {
		if ([[an title] isEqualToString:@"user"]) {
			double la = an.coordinate.latitude + (rand() % 100)* 0.00001;
			double lo = an.coordinate.longitude + (rand() % 100)* 0.00001;
			[an setCoordinate:CLLocationCoordinate2DMake(la,lo)];
		}
	}
	[self.mapView setNeedsDisplay];
}

#pragma mark - QMap check
- (void)showAlertView:(NSString*)title widthMessage:(NSString*)message
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView sizeToFit];
	[alertView show];
}

- (void)notifyAppKeyCheckResult:(QErrorCode)errCode
{
    NSLog(@"errcode = %d",errCode);
    printf("ILOve you!");
    
    if (errCode == QErrorNone) {
        NSLog(@"恭喜您，APPKey验证通过！");
		
		//CGRect rect = [self.view frame];
		//mapView = [[QMapView alloc] initWithFrame:rect];
		//[self.view addSubview:mapView];
    }
    else if(errCode == QNetError)
    {
        [self showAlertView:@"AppKey验证结果" widthMessage:@"网络好像不太给力耶！请检查下网络是否畅通?"];
    }
    else if(errCode == QAppKeyCheckFail)
    {
        [self showAlertView:@"AppKey验证结果" widthMessage:@"您的APPKEY好像是有问题喔，请检查下APPKEY是否正确？"];
    }
}

#pragma mark - QMap Location
- (void)mapViewWillStartLocatingUser:(QMapView *)mapView
{
    NSLog(@"location start");
	
}
- (void)mapViewDidStopLocatingUser:(QMapView *)mapView
{
    NSLog(@"location stop");
}

- (void)mapView:(QMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
	NSLog(@"userlocation error, %@", error);
}


- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation
{
	NSLog(@"userlocation chanage lo=%f,lat= %f",
		  [userLocation location].coordinate.longitude,
		  [userLocation location].coordinate.latitude);
}

#pragma mark - QMap Anonation
- (QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id <QAnnotation>)annotation
{
	if ([annotation isKindOfClass:[QPointAnnotation class]]) {
        static NSString* reuseIdentifier = @"annotation";
        /*
        QPinAnnotationView* newAnnotation = (QPinAnnotationView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
        
        if (nil == newAnnotation) {
            newAnnotation = [[QPinAnnotationView alloc]
							 initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        }
        
		newAnnotation.pinColor = QPinAnnotationColorYellow;
		newAnnotation.animatesDrop = YES;
        newAnnotation.canShowCallout = YES;
		*/
		QAnnotationView* newAnnotation = (QAnnotationView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
		if (nil == newAnnotation) {
			newAnnotation = [[QAnnotationView alloc]
							 initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
		}
		if ([[annotation title] isEqualToString:@"user"]	) {
			newAnnotation.image = [UIImage imageNamed:@"iphone_copyrighted-32"];
		}
		else {
			newAnnotation.image = [UIImage imageNamed:@"wifi-32"];
		}
        newAnnotation.canShowCallout = YES;
		return newAnnotation;
	}
	return nil;
}

#pragma mark - QMap Circle
- (QOverlayView *)mapView:(QMapView *)mapView viewForOverlay:(id <QOverlay>)overlay
{
    if ([overlay isKindOfClass:[QCircle class]]) {
        
        QCircleView* circleView = [[QCircleView alloc] initWithCircle:overlay];
        circleView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.5];
		circleView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
		circleView.lineWidth = 2.0;
        
        return circleView;
    }
    
    return nil;
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
