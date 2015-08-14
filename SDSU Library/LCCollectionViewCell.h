//
//  LCCollectionViewCell.h
//  SDSU Library
//
//  Created by Tyler Rogers on 8/24/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCList.h"


@interface LCCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UITextView *bodyTextView;

- (void)formatCellWithCallNumber:(LCList *)aCallNumber;



@end
