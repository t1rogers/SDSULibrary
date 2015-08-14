//
//  SearchButton.m
//  SDSU Library
//
//  Created by Tyler Rogers on 3/15/15.
//  Copyright (c) 2015 San Diego State University. All rights reserved.
//

#import "SearchButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation SearchButton



static inline void commonInitialLayout(SearchButton *searchButton) {
    
    searchButton.layer.cornerRadius = 10; // this value vary as per your desire
    searchButton.backgroundColor = [UIColor whiteColor];
    searchButton.clipsToBounds = YES;
    searchButton.layer.masksToBounds = YES;

}


- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]) == nil) {
        return nil;
    }
    
    //commonInitialLayout(self);
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    commonInitialLayout(self);
}

@end
