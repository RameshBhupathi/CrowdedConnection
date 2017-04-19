//
//  CCMapController.h
//  CrowdConnection
//
//  Created by WangShou on 14-5-21.
//  Copyright (c) 2014年 WangShou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QMapKit.h"
#import "QAppKeyCheck.h"

@interface CCMapController : UIViewController<QMapViewDelegate,QAppKeyCheckDelegate>
{
    IBOutlet QMapView* _mapView;
}

@property(nonatomic, retain)IBOutlet QMapView* mapView;

@end
