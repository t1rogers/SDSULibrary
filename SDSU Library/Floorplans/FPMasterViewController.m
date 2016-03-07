//
//  FPMasterViewController.m
//  Footprint
//
//  Created by Admin jrogers on 2/9/16.
//  Copyright © 2016 Apple, Inc. All rights reserved.
//

#import "FPMasterViewController.h"
#import "LLOneViewController.h"
#import "LLTwoViewController.h"
#import "LLThreeViewController.h"
#import "LLFourViewController.h"
#import "LLFiveViewController.h"


static NSString *kTitleKey = @"title";
static NSString *kExplainKey = @"explanation";
static NSString *kViewControllerKey = @"viewController";

static NSString *kCellIdentifier = @"wayFinderCell";

@interface WayFinderTableViewCell : UITableViewCell
@end

@implementation WayFinderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [super initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:reuseIdentifier];
}

@end


#pragma mark -

@interface FPMasterViewController ()
@property (nonatomic, strong) NSMutableArray *floorPlanList;
@end


#pragma mark -

@implementation FPMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // construct the array of page descriptions we will use (each description is a dictionary)
    //
    self.floorPlanList = [NSMutableArray array];
    
    // for showing Love Library First Floor Indoor Positioning
    LLOneViewController *oneViewController =
    [[LLOneViewController alloc] init];
    [self.floorPlanList addObject:@{ kTitleKey:NSLocalizedString(@"Love Library - First Floor", @""),
                               kViewControllerKey:oneViewController } ];
    
    // for showing Love Library Second Floor Indoor Positioning
    LLTwoViewController *twoViewController =
    [[LLTwoViewController alloc] init];
    [self.floorPlanList addObject:@{ kTitleKey:NSLocalizedString(@"Love Library - Second Floor", @""),
                               kViewControllerKey:twoViewController } ];
    
    // for showing Love Library Third Floor Indoor Positioning
    LLThreeViewController *threeViewController =
    [[LLThreeViewController alloc] init];
    [self.floorPlanList addObject:@{ kTitleKey:NSLocalizedString(@"Love Library - Third Floor", @""),
                               kViewControllerKey:threeViewController } ];
    
    // for showing Love Library Fourth Floor Indoor Positioning
    LLFourViewController *fourViewController =
    [[LLFourViewController alloc] init];
    [self.floorPlanList addObject:@{ kTitleKey:NSLocalizedString(@"Love Library - Fourth Floor", @""),
                               kViewControllerKey:fourViewController } ];
    
    // for showing Love Library Fifth Floor Indoor Positioning
    LLFiveViewController *fiveViewController =
    [[LLFiveViewController alloc] init];
    [self.floorPlanList addObject:@{ kTitleKey:NSLocalizedString(@"Love Library - Fifth Floor", @""),
                               kViewControllerKey:fiveViewController } ];
    
    

    
    
    
    // register our cell ID for later when we are asked for UITableViewCells
    [self.tableView registerClass:[WayFinderTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
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
    UIViewController *targetViewController = [[self.floorPlanList objectAtIndex:indexPath.row] objectForKey:kViewControllerKey];
    [[self navigationController] pushViewController:targetViewController animated:YES];
    
}


#pragma mark - UITableViewDataSource

// tell our table how many rows it will have, in our case the size of our menuList
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.floorPlanList count];
}

// tell our table what kind of cell to use and its title for the given row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [[self.floorPlanList objectAtIndex:indexPath.row] objectForKey:kTitleKey];
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"IndoorPositionDetailView"]) {
        
        [segue.destinationViewController setTitle:@"Map Detail"];
    }
}




@end
