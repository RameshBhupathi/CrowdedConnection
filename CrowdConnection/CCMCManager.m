//
//  CCMCManager.m
//  CrowdConnection
//
//  Created by WangShou on 14-6-19.
//  Copyright (c) 2014年 WangShou. All rights reserved.
//

#import "CCMCManager.h"


#define DEBUG 1
static NSString * const CCServiceType = @"cc-service";

@implementation CCMCManager {
	BOOL isStart;
	NSMutableArray *peers;
	NSMutableArray *infos;
	NSMutableSet *peerSet;
	BOOL isConnect;
	NSInteger connectedIndex;
}

@synthesize localPeerID,localSession,advertiser,browser;


- (id) init
{
	self = [super init];
	if (self) {
		// MC Peer
		localPeerID = [[MCPeerID alloc] initWithDisplayName:[[UIDevice currentDevice] name]];
		// MC Session
		localSession = [[MCSession alloc] initWithPeer:localPeerID
									  securityIdentity:nil
								  encryptionPreference:MCEncryptionNone];
		localSession.delegate = self;
		//MC advertiser
		advertiser = [[MCAdvertiserAssistant alloc] initWithServiceType:CCServiceType discoveryInfo:nil session:localSession];
		//MC browser
		browser = [[MCNearbyServiceBrowser alloc] initWithPeer:localPeerID serviceType:CCServiceType];
		browser.delegate = self;
		isStart = false;
		
		//Peers
		peers = [[NSMutableArray alloc] init];
		infos = [[NSMutableArray alloc] init];
		peerSet = [[NSMutableSet alloc] init];
		isConnect = false;
		connectedIndex = -1;
	}
	
		
	return self;
}

- (void) start
{
	if (DEBUG) {
		NSLog(@"---DEBUG---manager start");
	}
	if (isStart) {
		[advertiser stop];
		[browser stopBrowsingForPeers];
	}
	[advertiser start];
	[browser startBrowsingForPeers];
	isStart = true;
	
	//initialize
	peers = [[NSMutableArray alloc] init];
	infos = [[NSMutableArray alloc] init];
	peerSet = [[NSMutableSet alloc] init];
	isConnect = false;
	connectedIndex = -1;
}

- (void) stop
{
	if (DEBUG) {
		NSLog(@"---DEBUG---manager stop");
	}
	[advertiser stop];
	[browser stopBrowsingForPeers];
	isStart = false;
	
	//initialize
	peers = [[NSMutableArray alloc] init];
	infos = [[NSMutableArray alloc] init];
	peerSet = [[NSMutableSet alloc] init];
	isConnect = false;
	connectedIndex = -1;
}

- (BOOL) isStarted
{
	return isStart;
}

- (void) setDiscoverInfo:(NSDictionary*)info
{
	if (isStart)
		[advertiser stop];
	//MC advertiser
	advertiser = [[MCAdvertiserAssistant alloc] initWithServiceType:CCServiceType discoveryInfo:info session:localSession];
	if (isStart)
		[advertiser start];
}

- (void) invite:(NSInteger)index
{
	if (isConnect == false) {
		MCPeerID* invitedID = [peers objectAtIndex:index];
		[browser invitePeer:invitedID toSession:localSession withContext:nil timeout:0];
		isConnect = true;
	}
}

- (BOOL) isConnected
{
	return isConnect;
}

- (NSInteger) connectedPosition
{
	return connectedIndex;
}

- (NSUInteger) browserPeersNumber
{
	return [peers count];
}

- (NSDictionary*) browseredInfoAtIndex:(NSUInteger) index
{
	return [infos objectAtIndex:index];
}

#pragma mark - MCNearbyService Browser Delegate method implementation
- (void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error {
	
	NSDictionary *dict = @{@"error": error,
						   };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCdidNotStartBrowsingForPeers"
                                                        object:nil
                                                      userInfo:dict];
}

- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info {
	if (DEBUG) {
		NSLog(@"---DEBUG---manager found, %@", [peerID displayName]);
	}
	
	if ([peerSet containsObject:peerID]) {
		//Do nothing
	}
	else {
		[peers addObject:peerID];
		[infos addObject:info];
		[peerSet addObject:peerID];
		NSDictionary *dict = @{@"peerID" : peerID,
							   @"info" : info,
							   };
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"MCbrowserChanged"
															object:nil
														  userInfo:dict];
	}
	
	
}

- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID {
	if (DEBUG) {
		NSLog(@"---DEBUG---manager lost");
	}
	for (NSUInteger i = 0; i < [peers count]; i++) {
		if ([peers objectAtIndex:i] == peerID) {
			if (i == connectedIndex) {
				isConnect = false;
				connectedIndex = -1;
				//TODO lost connnecting peer
			}
			[peers removeObjectAtIndex:i];
			[infos removeObjectAtIndex:i];
			[peerSet removeObject:peerID];
		}
	}
	NSDictionary *dict = @{@"peerID" : peerID,};
	[[NSNotificationCenter defaultCenter] postNotificationName:@"MCbrowserChanged"
														object:nil
													  userInfo:dict];
}

#pragma mark - MCSession Delegate method implementation
-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{
	
	//TODO
    if (state == MCSessionStateConnected) {
		NSLog(@"connected");
		if (isConnect == true && connectedIndex == -1) {
			for (NSUInteger i = 0; i < [peers count]; i++) {
				if ([peers objectAtIndex:i] == peerID) {
					connectedIndex = i;
					break;
				}
			}
		}
		
		else {
			//TODO
			//give up this connection
		}
		NSLog(@"connected %@, %d", [peerID displayName ], connectedIndex);
		NSString* content = @"hello";
		NSData *dataToSend = [content dataUsingEncoding:NSUTF8StringEncoding];
		NSArray *allPeers = session.connectedPeers;
		NSError *error;
		[session sendData:dataToSend
				  toPeers:allPeers
				 withMode:MCSessionSendDataUnreliable
					error:&error];
	}
	else if (state == MCSessionStateNotConnected) {
		NSLog(@"not connected");
	}
	else {
		//DO something
	}
	
	NSDictionary *dict = @{@"peerID": peerID,
                           @"state" : [NSNumber numberWithInt:state]
                           };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCDidChangeStateNotification"
                                                        object:nil
                                                      userInfo:dict];
}


-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{
    NSDictionary *dict = @{@"data": data,
                           @"peerID": peerID
                           };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCDidReceiveDataNotification"
                                                        object:nil
                                                      userInfo:dict];
}


-(void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress{
    
    NSDictionary *dict = @{@"resourceName"  :   resourceName,
                           @"peerID"        :   peerID,
                           @"progress"      :   progress
                           };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCDidStartReceivingResourceNotification"
                                                        object:nil
                                                      userInfo:dict];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [progress addObserver:self
                   forKeyPath:@"fractionCompleted"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    });
}


-(void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error{
    
    NSDictionary *dict = @{@"resourceName"  :   resourceName,
                           @"peerID"        :   peerID,
                           @"localURL"      :   localURL
                           };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCdidFinishReceivingResourceNotification"
                                                        object:nil
                                                      userInfo:dict];
    
}

-(void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{
    NSDictionary *dict = @{@"stream"  :   stream,
                           @"name"        :   streamName,
                           @"peerID"      :   peerID
                           };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCdidReceiveStreamNotification"
                                                        object:nil
                                                      userInfo:dict];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCReceivingProgressNotification"
                                                        object:nil
                                                      userInfo:@{@"progress": (NSProgress *)object}];
}
@end
