//
//  CustomAnnotation.h
//  SDSU Library
//
//  Created by Tyler Rogers on 7/19/15.
//  Copyright (c) 2015 San Diego State University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface CustomAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readwrite) NSString *place;
@property (nonatomic, readwrite) NSString *imageName;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

+ (MKAnnotationView *)createViewAnnotationForMapView:(MKMapView *)mapView annotation:(id <MKAnnotation>)annotation;


@end


