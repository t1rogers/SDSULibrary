//
//  MapListCell.h
//  SDSU Library
//
//  Created by Tyler Rogers on 9/2/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapList.h"


@interface MapListCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;


- (void)formatCellWithMap:(MapList *)aMap;



@end
