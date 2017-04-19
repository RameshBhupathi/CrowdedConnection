//
//  CCMCManager.h
//  CrowdConnection
//
//  Created by WangShou on 14-6-19.
//  Copyright (c) 2014年 WangShou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface CCMCManager : NSObject<MCNearbyServiceBrowserDelegate,MCSessionDelegate>

@property (nonatomic, strong) MCPeerID *localPeerID;
@property (nonatomic, strong) MCAdvertiserAssistant *advertiser;
@property (nonatomic, strong) MCNearbyServiceBrowser *browser;
@property (nonatomic, strong) MCSession* localSession;

- (void) start;

- (BOOL) isStarted;

- (void) stop;

- (void) setDiscoverInfo:(NSDictionary*)info;

- (BOOL) isConnected;

- (NSInteger) connectedPosition;

- (NSUInteger) browserPeersNumber;

- (NSDictionary*) browseredInfoAtIndex:(NSUInteger) index;

- (void) invite:(NSInteger)index;

@end
