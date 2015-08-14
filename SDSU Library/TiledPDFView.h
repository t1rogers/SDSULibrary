//
//  TiledPDFView.h
//  SDSU Library
//
//  Created by Tyler Rogers on 8/29/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TiledPDFView : UIView

- (id)initWithFrame:(CGRect)frame scale:(CGFloat)scale;
- (void)setPage:(CGPDFPageRef)newPage;

@end

