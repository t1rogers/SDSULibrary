//
//  NewBook.m
//  SDSU Library
//
//  Created by Tyler Rogers on 9/15/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import "NewBook.h"

@implementation NewBook

@synthesize title, description, link, font, contentLabel;

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    self.contentView.frame = self.bounds;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView updateConstraintsIfNeeded];
    [self.contentView layoutIfNeeded];
    
    self.contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.contentLabel.frame);
}



@end
