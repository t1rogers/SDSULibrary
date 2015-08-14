//
//  SCUAHours.m
//  SDSU Library
//
//  Created by Tyler Rogers on 8/24/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import "SCUAHours.h"
#import "Day.h"


@implementation SCUAHours



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    xmlParser = nil;
    xmlParser = [[HoursXMLParser alloc] loadXMLByURL:@"http://library.sdsu.edu/guides/rss/hours_scua.rss"];
    
    
    UIEdgeInsets inset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.contentInset = inset;
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[xmlParser days] count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *CellIdentifier = @"HourCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil) {
        cell = [[ UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Day *currentDay = [[xmlParser days] objectAtIndex:indexPath.row];
	
	CGRect dayFrame = CGRectMake(32, 2, 170, 25);
	UILabel *contentLabel = [[UILabel alloc] initWithFrame:dayFrame];
	contentLabel.numberOfLines = 2;
	contentLabel.font = [UIFont systemFontOfSize:18];
	contentLabel.text = [currentDay day];
	[cell.contentView addSubview:contentLabel];
	
	CGRect hoursFrame = CGRectMake(32, 25, 350, 25);
	UILabel *hoursLabel = [[UILabel alloc] initWithFrame:hoursFrame];
	hoursLabel.font = [UIFont systemFontOfSize:16];
	hoursLabel.text = [currentDay hours];
	[cell.contentView addSubview:hoursLabel];
    
	
	
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 55;
}

#pragma mark -
#pragma mark Table view delegate
\


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
