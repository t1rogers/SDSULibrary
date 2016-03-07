//
//  LLFourViewController.h
//  Footprint
//
//  Created by Admin jrogers on 2/9/16.
//  Copyright © 2016 Apple, Inc. All rights reserved.
//

@import UIKit;

/**
 Primary view controller for what is displayed by the application.
 
 In this class we configure an \c MKMapView to display a floorplan, recieve
 location updates to determine floor number, as well as provide a few helpful
 debugging annotations.
 
 We will also show how to highlight a region that you have defined in PDF
 coordinates but not Latitude & Longitude.
 */
@interface LLFourViewController : UIViewController
@end