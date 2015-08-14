//
//  MapListViewController.m
//  SDSU Library
//
//  Created by Tyler Rogers on 8/29/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//



#import "MapListViewController.h"
#import "MapListCell.h"
#import "TiledPDFView.h"
#import "PDFScrollView.h"
#import "MapList.h"
#import "AllFloorsViewController.h"
#import "FirstFloorLLViewController.h"
#import "SecondFloorLLViewController.h"
#import "ThirdFloorLLViewController.h"
#import "FourthFloorLLViewController.h"
#import "FifthFloorLLViewController.h"


@interface MapListViewController ()
@end

@implementation MapListViewController

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
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    allfloors = [[AllFloorsViewController alloc] init];
    onelove = [[FirstFloorLLViewController alloc] init];
    twolove = [[SecondFloorLLViewController alloc] init];
    threelove = [[ThirdFloorLLViewController alloc] init];
    fourlove = [[FourthFloorLLViewController alloc] init];
    fivelove = [[FifthFloorLLViewController alloc] init];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    for (MapListCell *ourCell in self.collectionView.visibleCells) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:ourCell];
        [ourCell formatCellWithMap:[MapList mapForIndexPath:indexPath]];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MapListCell *ourCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    
    if (!ourCell) {
        return nil;
    }
    
    [ourCell formatCellWithMap:[MapList mapForIndexPath:indexPath]];
    
    return ourCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [MapList mapCount];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MapList *map = [MapList mapForIndexPath:indexPath];
    

for (MapListCell *ourCell in self.collectionView.visibleCells) {

    if ([map.viewControllerIdentifier  isEqual:@"AllFloorsViewController"]) {
        [self.navigationController pushViewController:allfloors animated:YES];
    }
    break;
    if ([map.viewControllerIdentifier isEqual:@"FirstFloorLLViewController"]) {
        [self.navigationController pushViewController:onelove animated:YES];

    }
    break;
    if ([map.viewControllerIdentifier isEqual:@"SecondFloorLLViewController"]) {
        [self.navigationController pushViewController:twolove animated:YES];

    }
    break;
    if ([map.viewControllerIdentifier isEqual:@"ThirdFloorLLViewController"]) {
        [self.navigationController pushViewController:threelove animated:YES];
        
    }
    break;
    if ([map.viewControllerIdentifier isEqual: @"FourthFloorLLViewController"]) {
        [self.navigationController pushViewController:fourlove animated:YES];

    }
    break;
    if ([map.viewControllerIdentifier isEqual:@"FifthFloorLLViewController"]) {
        [self.navigationController pushViewController:fivelove animated:YES];

    }
    break;
}
    
    return;
}
@end
