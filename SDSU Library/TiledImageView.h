//
//  TiledImageView.h
//  SDSU Library
//
//  Created by Tyler Rogers on 5/15/14.
//  Copyright (c) 2014 San Diego State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TiledImageView : UIView {
	CGFloat imageScale;
    UIImage* image;
    CGRect imageRect;
}
@property (retain) UIImage* image;

-(id)initWithFrame:(CGRect)_frame image:(UIImage*)image scale:(CGFloat)scale;

@end