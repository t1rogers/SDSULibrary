//
//  CallNumbersMainViewController.m
//  SDSU Library
//
//  Created by Tyler Rogers on 8/24/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import "CallNumbersMainViewController.h"
#import "LCCollectionViewController.h"

static NSString *kTitleKey = @"title";
static NSString *kExplainKey = @"explanation";
static NSString *kViewControllerKey = @"viewController";

static NSString *kCellIdentifier = @"MyIdentifier";

@interface MyTableViewCell : UITableViewCell
@end

@implementation MyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
}

@end


@interface CallNumbersMainViewController ()
@property (nonatomic, retain) NSMutableArray *cnArray;
@end

@implementation CallNumbersMainViewController

// this is called when its tab is first tapped by the user
// table row constants for assigning cell titles


- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.cnArray = [NSMutableArray array];
    
    LCCollectionViewController *lccollectionviewcontroller =
    [[LCCollectionViewController alloc] init];
	[self.cnArray addObject:@{ kTitleKey:NSLocalizedString(@"Library of Congress", @""),
                                kExplainKey:NSLocalizedString(@"Organized by Subject", @""),
                                kViewControllerKey:lccollectionviewcontroller } ];
    
    // create a custom navigation bar button and set it to always say "Back"

	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    // register our cell ID for later when we are asked for UITableViewCells
    [self.tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
}


#pragma mark - AppDelegate methods

- (void)viewWillAppear:(BOOL)animated
{
    // this UIViewController is about to re-appear, make sure we remove the current selection in our table view
	NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
	[self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
    
    // some over view controller could have changed our nav bar tint color, so reset it here
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
}


#pragma mark -
#pragma mark UITableViewDataSource



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UIViewController *targetViewController = [[self.cnArray objectAtIndex:indexPath.row] objectForKey:kViewControllerKey];
	[[self navigationController] pushViewController:targetViewController animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.cnArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.textLabel.text = [[self.cnArray objectAtIndex:indexPath.row] objectForKey:kTitleKey];
    cell.detailTextLabel.text = [[self.cnArray objectAtIndex:indexPath.row] objectForKey:kExplainKey];
    
	return cell;
}

#pragma mark -
#pragma mark UIViewControllerRotation



@end