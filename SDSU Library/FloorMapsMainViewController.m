//
//  MapsMainViewController.m
//  SDSU Library
//
//  Created by Tyler Rogers on 9/8/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//


#import "FloorMapsMainViewController.h"
#import "AllFloorsViewController.h"
#import "BasementLAViewController.h"
#import "TwoLAViewController.h"
#import "FirstFloorLLViewController.h"
#import "SecondFloorLLViewController.h"
#import "ThirdFloorLLViewController.h"
#import "FourthFloorLLViewController.h"
#import "FifthFloorLLViewController.h"
#import "TwoLAViewController.h"

static NSString *kTitleKey = @"title";
static NSString *kExplainKey = @"explanation";
static NSString *kViewControllerKey = @"viewController";

static NSString *kCellIdentifier = @"mapCell";

@interface MapTableViewCell : UITableViewCell
@end

@implementation MapTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [super initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:reuseIdentifier];
}

@end


#pragma mark -

@interface FloorMapsMainViewController ()
@property (nonatomic, strong) NSMutableArray *mapList;
@end


#pragma mark -

@implementation FloorMapsMainViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
    // construct the array of page descriptions we will use (each description is a dictionary)
	//
	self.mapList = [NSMutableArray array];
	
	// for showing various All floors overview
	AllFloorsViewController *allViewController =
    [[AllFloorsViewController alloc] init];
	[self.mapList addObject:@{ kTitleKey:NSLocalizedString(@"Library Overview", @""),
                                kViewControllerKey:allViewController } ];
    
    //Shows Basement LA map
    BasementLAViewController *basementLAViewController =
    [[BasementLAViewController alloc] init];
	[self.mapList addObject:@{ kTitleKey:NSLocalizedString(@"Basement Library Addition", @""),
                               kViewControllerKey:basementLAViewController } ];
    
    //Shows Two LA map
    OneLAViewController *oneLAViewController =
    [[OneLAViewController alloc] init];
	[self.mapList addObject:@{ kTitleKey:NSLocalizedString(@"First Floor Library Addition", @""),
                               kViewControllerKey:oneLAViewController } ];
    
    //Shows Two LA map
    TwoLAViewController *twoLAViewController =
    [[TwoLAViewController alloc] init];
	[self.mapList addObject:@{ kTitleKey:NSLocalizedString(@"Second Floor Library Addition", @""),
                               kViewControllerKey:twoLAViewController } ];
    
    //First floor love library
	FirstFloorLLViewController *oneViewController =
    [[FirstFloorLLViewController alloc] init];
    [self.mapList addObject:@{ kTitleKey:NSLocalizedString(@"First Floor Love Library", @""),
                                kViewControllerKey:oneViewController } ];
	
	// for showing various UITextFields:
	SecondFloorLLViewController *twoViewController =
    [[SecondFloorLLViewController alloc] init];
    [self.mapList addObject:@{ kTitleKey:NSLocalizedString(@"Second Floor Love Library", @""),
                                kViewControllerKey:twoViewController } ];
    
    // for showing various UITextFields:
	ThirdFloorLLViewController *threeViewController =
    [[ThirdFloorLLViewController alloc] init];
    [self.mapList addObject:@{ kTitleKey:NSLocalizedString(@"Third Floor Love Library", @""),
                               kViewControllerKey:threeViewController } ];
    
    // for showing various UITextFields:
	FourthFloorLLViewController *fourViewController =
    [[FourthFloorLLViewController alloc] init];
    [self.mapList addObject:@{ kTitleKey:NSLocalizedString(@"Fourth Floor Love Library", @""),
                               kViewControllerKey:fourViewController } ];
    
    // for showing various UITextFields:
	FifthFloorLLViewController *fiveViewController =
    [[FifthFloorLLViewController alloc] init];
    [self.mapList addObject:@{ kTitleKey:NSLocalizedString(@"Fifth Floor Love Library", @""),
                               kViewControllerKey:fiveViewController } ];
    
    
    
    // register our cell ID for later when we are asked for UITableViewCells
    [self.tableView registerClass:[MapTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
}


#pragma mark - UIViewController delegate

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
    // this UIViewController is about to re-appear, make sure we remove the current selection in our table view
	NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
	[self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
    
    // some over view controller could have changed our nav bar tint color, so reset it here
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
}


#pragma mark - UITableViewDelegate

// the table's selection has changed, switch to that item's UIViewController
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UIViewController *targetViewController = [[self.mapList objectAtIndex:indexPath.row] objectForKey:kViewControllerKey];
	[[self navigationController] pushViewController:targetViewController animated:YES];

}


#pragma mark - UITableViewDataSource

// tell our table how many rows it will have, in our case the size of our menuList
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.mapList count];
}

// tell our table what kind of cell to use and its title for the given row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.textLabel.text = [[self.mapList objectAtIndex:indexPath.row] objectForKey:kTitleKey];

	return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"MapDetailView"]) {
        
        [segue.destinationViewController setTitle:@"Map Detail"];
    }
}




@end
