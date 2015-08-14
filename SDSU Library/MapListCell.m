//
//  MapListCell.m
//  SDSU Library
//
//  Created by Tyler Rogers on 9/2/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import "MapListCell.h"
#import <CoreGraphics/CoreGraphics.h>

@interface MapListCell ()
@property (nonatomic, strong) MapList *map;

- (void)preferredContentSizeChanged:(NSNotification *)aNotification;
@end

@implementation MapListCell
static inline void commonInitialLayout(MapListCell *aCell)
{
    aCell.backgroundColor = [UIColor darkGrayColor];
    
    aCell.layer.cornerRadius = 5.;
    aCell.containerView.layer.cornerRadius = 2.;
    
    // calculateAndSetFonts(aCell);
    
    [[NSNotificationCenter defaultCenter] addObserver:aCell selector:@selector(preferredContentSizeChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)formatCellWithMap:(MapList *)aMap
{
    self.titleLabel.text = aMap.title;
    
    self.map = aMap;
    
    //calculateAndSetFonts(self);
}
/*
 - (void)preferredContentSizeChanged:(NSNotification *)aNotification
 {
 calculateAndSetFonts(self);
 }
 
 static inline void calculateAndSetFonts(LCCollectionViewCell *aCell)
 {
 static const CGFloat cellTitleTextScaleFactor = .85;
 static const CGFloat cellBodyTextScaleFactor = .7;
 
 NSString *cellTitleTextStyle = [aCell.titleLabel tkd_textStyle];
 UIFont *cellTitleFont = [UIFont tkd_preferredFontWithTextStyle:cellTitleTextStyle scale:cellTitleTextScaleFactor];
 
 NSString *cellBodyTextStyle = [aCell.bodyTextView tkd_textStyle];
 UIFont *cellBodyFont = [UIFont tkd_preferredFontWithTextStyle:cellBodyTextStyle scale:cellBodyTextScaleFactor];
 
 aCell.titleLabel.font = cellTitleFont;
 aCell.bodyTextView.font = cellBodyFont;
 }
 
 */

@end