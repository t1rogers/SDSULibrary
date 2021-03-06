//
//  SecondFloorLLViewController.h
//  SDSU Library
//
//  Created by Tyler Rogers on 8/31/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageScrollView;

@interface SecondFloorLLViewController : UIViewController {
    // The input image file
    UIImage* sourceImage;
    // output image file
    UIImage* destImage;
    // sub rect of the input image bounds that represents the
    // maximum amount of pixel data to load into mem at one time.
    CGRect sourceTile;
    // sub rect of the output image that is proportionate to the
    // size of the sourceTile.
    CGRect destTile;
    // the ratio of the size of the input image to the output image.
    float imageScale;
    // source image width and height
    CGSize sourceResolution;
    // total number of pixels in the source image
    float sourceTotalPixels;
    // total number of megabytes of uncompressed pixel data in the source image.
    float sourceTotalMB;
    // output image width and height
    CGSize destResolution;
    // the temporary container used to hold the resulting output image pixel
    // data, as it is being assembled.
    CGContextRef destContext;
    // the number of pixels to overlap tiles as they are assembled.
    float sourceSeemOverlap;
    // an image view to visualize the image as it is being pieced together
    UIImageView* progressView;
    // a scroll view to display the resulting downsized image
    ImageScrollView* scrollView;
}
// destImage property is specifically thread safe (i.e. no 'nonatomic' attribute)
// because it is accessed off the main thread.
@property (nonatomic, retain) UIImage* destImage;

-(void)downsize:(id)arg;
-(void)updateScrollView:(id)arg;
-(void)initializeScrollView:(id)arg;
-(void)createImageFromContext;

@end