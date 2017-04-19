//
//  CCMainController.m
//  CrowdConnection
//
//  Created by WangShou on 14-5-21.
//  Copyright (c) 2014年 WangShou. All rights reserved.
//
#import "CCMainController.h"
#import "CCAppDelegate.h"
#import "AHKActionSheet.h"

#define DEBUG 1

static NSString *SignalIdentifier = @"SignalCell";

@interface CCMainController ()

@property (nonatomic, strong) CCAppDelegate *appDelegate;

@end

@implementation CCMainController

#pragma mark - Private Method

- (NSDictionary*) localPeerInfo
{
	NSDictionary* result = @{@"kind":[[UIDevice currentDevice] name],
							 @"signalType":@"signal_phone",
							 @"signal":@"strong",
							 @"price":@"21 RMB",
							 @"duration":@"20 mins"
							 };
	return result;
}


- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
		if (DEBUG) {
			NSLog(@"---DEBUG---CCMainController initWith Coder");
			NSLog(@"current device name is : %@",[[UIDevice currentDevice] name]);
		}
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (DEBUG) {
		NSLog(@"---DEBUG---CCMainController did load");
	}
	// Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	//manager
	_appDelegate = (CCAppDelegate *)[[UIApplication sharedApplication] delegate];
	if (_visibleSwitch.isOn) {
		[_appDelegate.manager setDiscoverInfo:[self localPeerInfo]];
		[_appDelegate.manager start];
	}
	
	//MC browser notification
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mcBrowserChanged:)
                                                 name:@"MCbrowserChanged"
                                               object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mcConnectChanged:)
                                                 name:@"MCDidChangeStateNotification"
                                               object:nil];
	//keyboard
	[self registerForKeyboardNotifications];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MC browser method
- (void) mcBrowserChanged:(NSNotification *)notification
{
	[_nearAvailabels reloadData];
}

- (void) mcConnectChanged:(NSNotification *)notification
{
	[_nearAvailabels reloadData];
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return the number of rows in the section
	if (DEBUG) {
		NSLog(@"availabels number : %d", [_appDelegate.manager browserPeersNumber]);
	}
	return [_appDelegate.manager browserPeersNumber];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CCMainCell *cell = [tableView dequeueReusableCellWithIdentifier:SignalIdentifier];
    
    if (cell == nil) {
        cell =  [[CCMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SignalIdentifier];
    }
	NSDictionary* info = [_appDelegate.manager browseredInfoAtIndex:[indexPath row]];
	cell.kindLabel.text = [info valueForKey:@"kind"];
	cell.kindIView.image = [UIImage imageNamed: [info valueForKey:@"signalType"]];
	cell.signalLabel.text = [info valueForKey:@"signal"];
	cell.priceLabel.text = [info valueForKey:@"price"];
	cell.durationLabel.text = [info valueForKey:@"duration"];
	[cell.connectButton setTag:[indexPath row]];
	[cell.connectButton addTarget:self action:@selector(connectOneNode:) forControlEvents:UIControlEventTouchUpInside];
	if ([indexPath row] == [_appDelegate.manager connectedPosition]) {
		[cell.connectButton setSelected:YES];
	}
	return cell;
	/*
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    
    cell.textLabel.text = @"test";
	return cell;
	 */
}



/*
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if (indexPath.section == 2 && indexPath.row == 0)
    {
        // perform the Geocode
        [self performStringGeocode:self];
    }
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)visibleChange:(id)sender {
	if (DEBUG) {
		NSLog(@"---DEBUG---visibleChange");
	}

	if (_visibleSwitch.isOn) {
		
		[_appDelegate.manager start];
	}
	else {
		[_appDelegate.manager stop];
	}
	[_nearAvailabels reloadData];
}

- (IBAction)priceChange:(id)sender {
}

- (IBAction)examplesShow:(id)sender {
	AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(@"Here are several examples to show how crowd connection work?", nil)];

	[actionSheet addButtonWithTitle:NSLocalizedString(@"chat", nil)
	image:[UIImage imageNamed:@"chat-75"]
	type:AHKActionSheetButtonTypeDefault
	handler:^(AHKActionSheet *as) {
		[self performSegueWithIdentifier:@"main_chat" sender:self];
	}];

	[actionSheet addButtonWithTitle:NSLocalizedString(@"download task", nil)
	image:[UIImage imageNamed:@"download_from_cloud_filled-75"]
	type:AHKActionSheetButtonTypeDefault
	handler:^(AHKActionSheet *as) {
		[self performSegueWithIdentifier:@"main_download" sender:self];
	}];

	[actionSheet addButtonWithTitle:NSLocalizedString(@"watch tv", nil)
	image:[UIImage imageNamed:@"tv_show-75"]
	type:AHKActionSheetButtonTypeDefault
	handler:^(AHKActionSheet *as) {
	NSLog(@"Share tapped");
	}];

	[actionSheet show];
	 

}

//view transfer value

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"main_download"])
    {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:[NSNumber numberWithInt:[_appDelegate.manager isConnected] ? 1 : 0] forKey:@"connects"];
    }
}

- (IBAction)connectOneNode:(id)sender {
	UIButton* btn = sender;
	if (DEBUG) {
		NSLog(@"row %d, state %u", [btn tag], [btn state]);
	}
	/*todelete
	if ([btn isSelected]) {
		[btn setSelected:false];
		isConnect = false;
	} else  if (isConnect == false){
		
		MCPeerID* invitedID = [peers objectAtIndex:[btn tag]];
		[browser invitePeer:invitedID toSession:localSession withContext:nil timeout:0];
		//if success
		[btn setSelected:true];
		isConnect = true;
		connectedTag = [btn tag];
	}
	else {
		//error, ignore, connect one node at the same time
	}
	 */
	if ([btn isSelected]) {
		[btn setSelected:false];
		//TODO disconnect
	}else{
		[_appDelegate.manager invite:[btn tag]];
		[btn setSelected:true];
	}
	
}

#pragma mark - Keyboard Display
// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWasShown:)
												 name:UIKeyboardDidShowNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillBeHidden:)
												 name:UIKeyboardWillHideNotification object:nil];
	
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
	if (DEBUG) {
		NSLog(@"---DEBUG---display keyboard shown");
	}
	NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect bkgndRect = self.sailPriceSetting.superview.frame;
    bkgndRect.size.height += kbSize.height;
    [self.scrollMainView setContentOffset:CGPointMake(0.0, self.sailPriceSetting.frame.origin.y-kbSize.height) animated:YES];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
	if (DEBUG) {
		NSLog(@"---DEBUG---display keyboard hide");
	}
	[self.scrollMainView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
}







@end
