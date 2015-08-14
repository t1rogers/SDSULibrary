//
//  LCListViewController.m
//  SDSU Library
//
//  Created by Tyler Rogers on 8/24/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import "LCCollectionViewController.h"
#import "LCCollectionViewCell.h"
#import "LCTextViewController.h"
#import "LCList.h"
#import "LCBasicInteractionViewController.h"

@interface LCCollectionViewController ()
@end

@implementation LCCollectionViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    for (LCCollectionViewCell *ourCell in self.collectionView.visibleCells) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:ourCell];
        [ourCell formatCellWithCallNumber:[LCList callNumberForIndexPath:indexPath]];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LCCollectionViewCell *ourCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    
    if (!ourCell) {
        return nil;
    }
    
    [ourCell formatCellWithCallNumber:[LCList callNumberForIndexPath:indexPath]];
    
    return ourCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [LCList callNumberCount];
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LCBasicInteractionViewController *newViewController = nil;
    
    LCList *callNumber = [LCList callNumberForIndexPath:indexPath];

    newViewController = [self.storyboard instantiateViewControllerWithIdentifier:callNumber.viewControllerIdentifier];
    
    newViewController.title = callNumber.title;
    newViewController.callNumber = callNumber;

    [self.navigationController showViewController:newViewController sender:self];


    return;
}






@end
