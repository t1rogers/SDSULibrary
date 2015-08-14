//
//  HoursLocListViewController.m
//  SDSU Library
//
//  Created by Tyler Rogers on 8/24/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import "HoursLocListViewController.h"
#import "MainHours.h"
#import "TwoFourSevenHours.h"
#import "MediaHours.h"
#import "RefHours.h"
#import "SCUAHours.h"




@interface HoursLocListViewController ()
@property (nonatomic, retain) NSArray *locNameArray;

@end

@implementation HoursLocListViewController

@synthesize locNameArray;

// this is called when its tab is first tapped by the user
// table row constants for assigning cell titles
enum {
	kA = 0,
	kB,
    kC,
    kD,
    kE,
    kF,
    
};


- (void)viewDidLoad
{
	[super viewDidLoad];
    
    /*
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:kLatestKivaLoansURL];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
    */

	self.locNameArray = [NSArray arrayWithObjects:@"Main Library/ SCC", @"24/7 Area",
                       @"Media Center",@"Research Desk",@"Special Collections", nil];
    
    main = [[MainHours alloc] init];
    twofourseven = [[TwoFourSevenHours alloc] init];
    media = [[MediaHours alloc] init];
    reference = [[RefHours alloc] init];
    specialcoll = [[SCUAHours alloc] init];

    
}



- (void)viewDidUnload
{
	[super viewDidUnload];
    
	self.locNameArray = nil;
    
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
	return [self.locNameArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row]) {
        case kA:
            [self.navigationController pushViewController:main animated:YES];
            break;
        case kB:
            [self.navigationController pushViewController:twofourseven animated:YES];
            break;
        case kC:
            [self.navigationController pushViewController:media animated:YES];
            break;
        case kD:
            [self.navigationController pushViewController:reference animated:YES];
            break;
        case kE:
            [self.navigationController pushViewController:specialcoll animated:YES];
            break;

            
            
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kCellID = @"hoursLocationCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	}
    
	cell.textLabel.text = [self.locNameArray objectAtIndex:indexPath.row];
    
	return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"hoursDetail"]) {
        
        [segue.destinationViewController setTitle:@"This Week's Hours"];
    }
}



#pragma mark -
#pragma mark UIViewControllerRotation



@end
