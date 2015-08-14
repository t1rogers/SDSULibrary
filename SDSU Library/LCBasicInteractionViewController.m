//
//  TKDBasicInteractionViewController.m
//  SDSU Library
//
//  Created by Tyler Rogers on 8/24/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import "LCBasicInteractionViewController.h"

@interface LCBasicInteractionViewController () <UITextViewDelegate>
@end

@implementation LCBasicInteractionViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textView.attributedText = self.callNumber.attributedText;
}


@end
