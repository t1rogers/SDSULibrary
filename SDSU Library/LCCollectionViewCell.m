//
//  LCCollectionViewCell.m
//  SDSU Library
//
//  Created by Tyler Rogers on 8/24/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import "LCCollectionViewCell.h"
#import <CoreGraphics/CoreGraphics.h>

@interface LCCollectionViewCell ()
@property (nonatomic, strong) LCList *callNumber;


@end

@implementation LCCollectionViewCell
static inline void commonInitialLayout(LCCollectionViewCell *aCell)
{
    aCell.backgroundColor = [UIColor darkGrayColor];
    aCell.layer.cornerRadius = 5.;
    aCell.containerView.layer.cornerRadius = 2.;
    aCell.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    

}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]) == nil) {
        return nil;
    }
    
    commonInitialLayout(self);
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    commonInitialLayout(self);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)formatCellWithCallNumber:(LCList *)aCallNumber
{
    self.titleLabel.text = aCallNumber.title;
    self.bodyTextView.attributedText = aCallNumber.attributedText;
    
    self.callNumber = aCallNumber;

}




@end

