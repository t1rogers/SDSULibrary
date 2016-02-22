//
//  FPMasterViewController.m
//  Footprint
//
//  Created by Admin jrogers on 2/9/16.
//  Copyright © 2016 Apple, Inc. All rights reserved.
//

#import "FPMasterViewController.h"


@interface FPMasterViewController ()
@property (nonatomic, retain) NSArray *titleArray;
@end

@implementation FPMasterViewController

@synthesize subLevel, titleArray;

// this is called when its tab is first tapped by the user
// table row constants for assigning cell titles
enum {
    kA = 0,
    kB,
    kC,
    kD,
    kE
};


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleArray = [NSArray arrayWithObjects:@"Love Library - First Floor", @"Love Library - Second Floor", @"Love Library - Third Floor", @"Love Library - Fourth Floor", @"Love Library - Fifth Floor", nil];
    
    ll1ViewController = [[LLOneViewController alloc] init];
    ll2ViewController = [[LLTwoViewController alloc] init];
    ll3ViewController = [[LLThreeViewController alloc] init];
    ll4ViewController = [[LLFourViewController alloc] init];
    ll5ViewController = [[LLFiveViewController alloc] init];
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.titleArray = nil;
    
}



#pragma mark - AppDelegate methods

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // this UIViewController is about to re-appear, make sure we remove the current selection in our table view
    NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:tableSelection animated:YES];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titleArray count];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row]) {
        case kA:
            [self.navigationController pushViewController:ll1ViewController animated:YES];
            break;
        case kB:
            [self.navigationController pushViewController:ll2ViewController animated:YES];
            break;
        case kC:
            [self.navigationController pushViewController:ll3ViewController animated:YES];
            break;
            
            
            
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"NewBooksView"]) {
        
        // Get reference to the destination view controller
        //  WeekView *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        // [vc setMyObjectHere:object];
        [segue.destinationViewController setTitle:@"New Books"];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellID = @"SubjectCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    
    
    return cell;
}





#pragma mark -
#pragma mark UIViewControllerRotation



@end