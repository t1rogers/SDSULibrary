//
//  MapViewController.m
//  SDSU Library
//
//  Created by Tyler Rogers on 7/19/15.
//  Copyright (c) 2015 San Diego State University. All rights reserved.
//

#import "MapViewController.h"
#import "CustomAnnotation.h"        // annotation for the Love Library
      // annotation for the Love Library

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *campusMap;
@property (nonatomic, strong) NSMutableArray *mapAnnotations;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, readonly) MKUserLocation *userLocation;


@end


#pragma mark -

@implementation MapViewController

- (void)gotoDefaultLocation
{
    
    // start off by default in San Diego State University
    
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 32.774937;
    newRegion.center.longitude = -117.071128;
    newRegion.span.latitudeDelta = 0.0112872;
    newRegion.span.longitudeDelta = 0.0109863;
    
    [self.campusMap setRegion:newRegion animated:YES];

    [self.campusMap setShowsUserLocation:YES];

    // You have coordinates


    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //or maybe you would do the call above in the code path that sets the annotations array
}


/*
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}
*/


- (IBAction)mapSatelliteSegmentControlTapped:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            self.campusMap.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.campusMap.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.campusMap.mapType = MKMapTypeHybrid;
            break;
            
        default:
            break;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // accuracy (CLLocationAccuracy)
    CLLocationAccuracy desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.desiredAccuracy = desiredAccuracy;
    
    // create out annotations array (in this example only 3)
    self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:1];

    MKUserLocation *userLocation = [[MKUserLocation alloc] init];
    [self.mapAnnotations addObject:userLocation];
    
     //Start tracking user's location.  Taken from Footprint.
    self.locationManager = [[CLLocationManager alloc] init];
    [self.campusMap setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
    
    [self gotoDefaultLocation];
    
    // user tapped "Tea Gardon" button in the bottom toolbar
    [self gotoByAnnotationClass:[CustomAnnotation class]];
    
    [self allAction:self];
    
   
    
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    self.campusMap.userTrackingMode = MKUserTrackingModeFollowWithHeading;
}

- (IBAction)allAction:(id)sender
{
    // user tapped "All" button in the bottom toolbar
    
    // remove any annotations that exist
    [self.campusMap removeAnnotations:self.campusMap.annotations];
    
    // add all 3 annotations
    [self.campusMap addAnnotations:self.mapAnnotations];
    
    [self gotoDefaultLocation];
}



/// Request authorization if needed.
- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView {
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            // Ask the user for permission to use location.
            [self.locationManager requestWhenInUseAuthorization];
            break;
            
        case kCLAuthorizationStatusDenied:
            NSLog(@"Please authorize location services for this SDSU Library under Settings > Privacy.");
            break;
            
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusRestricted:
            // Nothing to do.
            break;
    }
}


#pragma mark - Button Actions

- (void)gotoByAnnotationClass:(Class)annotationClass
{
    // user tapped "City" button in the bottom toolbar
    for (id annotation in self.mapAnnotations)
    {
        if ([annotation isKindOfClass:annotationClass])
        {
            // remove any annotations that exist
            [self.campusMap removeAnnotations:self.campusMap.annotations];
            // add just the city annotation
            [self.campusMap addAnnotation:annotation];
            
            [self gotoDefaultLocation];
        }
    }
}

// user tapped the disclosure button in the bridge callout
//


- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *returnedAnnotationView = nil;
    
    if ([annotation isKindOfClass:[CustomAnnotation class]])  // for Japanese Tea Garden
        {
            returnedAnnotationView = [CustomAnnotation createViewAnnotationForMapView:self.campusMap annotation:annotation];
        }
    
    
    return returnedAnnotationView;
}

/// Produce each type of annotation view that might exist in our MapView.
- (MKAnnotationView *)campusMap:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    /*
     For now, all we have are some quick and dirty pins for viewing debug
     annotations.
     To learn more about showing annotations, see "Annotating Maps" doc
     */
    if ([annotation.title isEqualToString:@"red"]) {
        MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc] init];
        pinView.pinTintColor = [UIColor redColor];
        pinView.canShowCallout = YES;
        return pinView;
    }
    
    if ([annotation.title isEqualToString:@"green"]) {
        MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc] init];
        pinView.pinTintColor = [UIColor greenColor];
        pinView.canShowCallout = YES;
        return pinView;
    }
    

    
    return nil;
}



-(IBAction)chooseLocation:(id)sender

{
    
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Choose a Location Please"
                                                                   message:@"Take a tour of the campus!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
                                                          
    UIAlertAction* adamsHumanitiesAction = [UIAlertAction actionWithTitle:@"Adams Humanities (AH)" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * adamsHumanitiesAction) {
                                                            
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
  
                                                                 // annotation for Adams Humanities
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 //load new name and image.
                                                                 item.place = @"Adams Humanities (AH)";
                                                                 item.imageName = @"AdamsHumanities";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.774015, -117.071385);
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                             }];
    
    UIAlertAction* administrationAction = [UIAlertAction actionWithTitle:@"Administration (AD)" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * administrationAction) {

                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                     
                                                                 // annotation for Administration
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 //load new name and image.
                                                                 item.place = @"Administration (AD)";
                                                                 item.imageName = @"Administration";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.775724, -117.070967);
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                             }];
    
    UIAlertAction* ALIAction = [UIAlertAction actionWithTitle:@"American Language Institute (ALI)" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * ALIAction) {

                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 
                                                                 // annotation for Administration
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 //load new name and image.
                                                                 item.place = @"American Language Institute (ALI)";
                                                                 item.imageName = @"GatewayCenter";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.7771333, -117.0743);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                            }];
    
    
    UIAlertAction* aquaplexAction = [UIAlertAction actionWithTitle:@"Aquaplex (POOL)" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * aquaplexAction) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 
                                                                 // annotation for Aquaplex
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Aquaplex (POOL)";
                                                                 item.imageName = @"AquaPlex";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.774136, -117.08006);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 
                                                             }];
    
    UIAlertAction* arenaMeetingCenterAction = [UIAlertAction actionWithTitle:@"Arena Meeting Center (AMC)" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * arenaMeetingCenterAction) {
                                                               
                                                               self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                               [self.mapAnnotations removeAllObjects];
                                                               [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                               
                                                               // annotation for Arena Meeting Center
                                                               CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                               item.place = @"Arena Meeting Center (AMC)";
                                                               item.imageName = @"HepnerHall";
                                                               item.coordinate = CLLocationCoordinate2DMake(32.774136, -117.08006);
                                                               
                                                               MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                               you.title = @"green";
                                                               you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                               
                                                               // user tapped "Art Gallery" button in the bottom toolbar
                                                               [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                               [self.mapAnnotations addObject:item];
                                                               [self.mapAnnotations addObject:you];
                                                               [self.campusMap addAnnotations:self.mapAnnotations];
                                                               [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                               
                                                               [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                               
                                                               
                                                           }];

    
    
    UIAlertAction* artAction = [UIAlertAction actionWithTitle:@"Art (ART N/S)" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Art (ART N/S)";
                                                                 item.imageName = @"ArtSouth";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.77779, -117.072118);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 
                                                             }];
    UIAlertAction* artGalleryAction = [UIAlertAction actionWithTitle:@"Art Gallery" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Art Gallery";
                                                                 item.imageName = @"ArtGallery";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.778126, -117.071793);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 
                                                             }];
    UIAlertAction* artsandLettersAction = [UIAlertAction actionWithTitle:@"Arts and Letters (AL)" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Arts and Letters (AL)";
                                                                 
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.777488, -117.073188);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green"; 
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 
                                                             }];

    UIAlertAction* ASUAction = [UIAlertAction actionWithTitle:@"Aztec Athletic Center (AZAT)" style:UIAlertActionStyleDefault
                                                                    handler:^(UIAlertAction * action) {
                                                                        
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                        
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Aztec Athletic Center (AZAT)";
                                                                 item.imageName = @"AztecAthleticCenter";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.774006, -117.076262);
                                                                        
                                                                        MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                        you.title = @"green";
                                                                        you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                        
                                                                        // user tapped "Art Gallery" button in the bottom toolbar
                                                                        [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                        [self.mapAnnotations addObject:item];
                                                                        [self.mapAnnotations addObject:you];
                                                                        [self.campusMap addAnnotations:self.mapAnnotations];
                                                                        [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                        
                                                                        [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                        
                                                                    }];
    
    
    UIAlertAction* aztecMesaModularsAction = [UIAlertAction actionWithTitle:@"Aztec Mesa Modulars (AMSA)" style:UIAlertActionStyleDefault
                                                                    handler:^(UIAlertAction * action) {
                                                                        
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                        
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Aztec Mesa Modulars (AMSA)";
                                                                 //no image for this yet.
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.774513, -117.073475);
                                                                        
                                                                        MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                        you.title = @"green";
                                                                        you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                        
                                                                        // user tapped "Art Gallery" button in the bottom toolbar
                                                                        [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                        [self.mapAnnotations addObject:item];
                                                                        [self.mapAnnotations addObject:you];
                                                                        [self.campusMap addAnnotations:self.mapAnnotations];
                                                                        [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                        
                                                                        [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                        
                                                                }];
    
    UIAlertAction* ARCAction = [UIAlertAction actionWithTitle:@"Aztec Recreation Center (ARC)" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Aztec Recreation Center (ARC)";
                                                                 item.imageName = @"AztecRecreationCenter";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.776315, -117.076262);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                             }];


    UIAlertAction* bioscienceCenterAction = [UIAlertAction actionWithTitle:@"Aztec Student Union" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Student Union";
                                                                 item.imageName = @"ASU";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.773870, -117.069830);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                             }];
    UIAlertAction* blicksArtSuppliesAction = [UIAlertAction actionWithTitle:@"Blicks Art Supplies" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Blicks Art Supplies";
                                                                 item.imageName = @"BlicksArt";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.77802, -117.072075);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                             }];
    UIAlertAction* bookstoreAction = [UIAlertAction actionWithTitle:@"Bookstore (BOOK)" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Bookstore (BOOK)";
                                                                 item.imageName = @"BookStore";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.775496, -117.070215);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                             }];
    UIAlertAction* calpulliAction = [UIAlertAction actionWithTitle:@"Calpulli Center (CLP)" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Calpulli Center (CLP)";
                                                                 item.imageName = @"Calpulli";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.772598, -117.073472);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                             }];
    UIAlertAction* chapultapecAction = [UIAlertAction actionWithTitle:@"Chapultapec Residence Hall (CHAP)" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Chapultapec Residence Hall (CHAP)";
                                                                 item.imageName = @"Chapultapec";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.775503, -117.078917);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                             }];
    UIAlertAction* chemSciLabAction = [UIAlertAction actionWithTitle:@"Chemical Sciences Laboratory" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Chemical Sciences Laboratory";
                                                                 item.imageName = @"ChemSciLab";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.776523, -117.068682);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                             }];
    UIAlertAction* childrenCenterAction = [UIAlertAction actionWithTitle:@"Children's Center" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Children's Center";
                                                                 item.imageName = @"ChildrensCenter";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.773717, -117.066042);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                             }];
    
    UIAlertAction* cholulaAction = [UIAlertAction actionWithTitle:@"Cholula Hall" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Cholula Hall";
                                                                 item.imageName = @"HepnerHall";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.775503, -117.078917);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                             }];
    
    UIAlertAction* collegeSquareAction = [UIAlertAction actionWithTitle:@"College Square (CSQ)" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                              [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                              [self.mapAnnotations removeAllObjects];
                                                              
                                                              // annotation for Hepner Hall
                                                              CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                              item.place = @"College Square (CSQ)";
                                                              
                                                              item.coordinate = CLLocationCoordinate2DMake(32.771426, -117.06984);
                                                              
                                                              MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                              you.title = @"green";
                                                              you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                              
                                                              // user tapped "Art Gallery" button in the bottom toolbar
                                                              [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                              [self.mapAnnotations addObject:item];
                                                              [self.mapAnnotations addObject:you];
                                                              [self.campusMap addAnnotations:self.mapAnnotations];
                                                              [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                              
                                                              [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                              
                                                          }];
    
    UIAlertAction* communicationAction = [UIAlertAction actionWithTitle:@"Communications (COM)" style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * action) {
                                                                    
                                                                    self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                    [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                    [self.mapAnnotations removeAllObjects];
                                                                    
                                                                    // annotation for Hepner Hall
                                                                    CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                    item.place = @"Communications (COM)";
                                                                    item.imageName = @"Communication";
                                                                    item.coordinate = CLLocationCoordinate2DMake(32.77627, -117.072608);
                                                                    
                                                                    MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                    you.title = @"green";
                                                                    you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                    
                                                                    // user tapped "Art Gallery" button in the bottom toolbar
                                                                    [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                    [self.mapAnnotations addObject:item];
                                                                    [self.mapAnnotations addObject:you];
                                                                    [self.campusMap addAnnotations:self.mapAnnotations];
                                                                    [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                    
                                                                    [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                    
                                                                }];
    
    UIAlertAction* cuicalliSuitesAction = [UIAlertAction actionWithTitle:@"Cross Cultural Center (ASU Rm 250)" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                              [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                              [self.mapAnnotations removeAllObjects];
                                                              
                                                              // annotation for Hepner Hall
                                                              CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                              item.place = @"Cross Cultural Center";
                                                              //no image yet
                                                              item.coordinate = CLLocationCoordinate2DMake(32.77405, -117.0697);
                                                              
                                                              MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                              you.title = @"green";
                                                              you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                              
                                                              // user tapped "Art Gallery" button in the bottom toolbar
                                                              [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                              [self.mapAnnotations addObject:item];
                                                              [self.mapAnnotations addObject:you];
                                                              [self.campusMap addAnnotations:self.mapAnnotations];
                                                              [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                              
                                                              [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                              
                                                          }];

    
    
    UIAlertAction* dramaticArtsAction = [UIAlertAction actionWithTitle:@"Dramatic Arts" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                               
                                                               self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                               [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                               [self.mapAnnotations removeAllObjects];
                                                               
                                                               // annotation for Love Library
                                                               CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                               item.place = @"Dramatic Arts";
                                                               item.imageName = @"TheatreArts";
                                                               item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                               
                                                               [self.mapAnnotations addObject:item];
                                                               
                                                               MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                               you.title = @"green";
                                                               you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                               
                                                               // user tapped "Art Gallery" button in the bottom toolbar
                                                               [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                               [self.mapAnnotations addObject:item];
                                                               [self.mapAnnotations addObject:you];
                                                               [self.campusMap addAnnotations:self.mapAnnotations];
                                                               [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                               
                                                               [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                               
                                                               
                                                               
                                                           }];
    
    UIAlertAction* eastCommonAction = [UIAlertAction actionWithTitle:@"East Commons" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Love Library
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"East Commons";
                                                                 item.imageName = @"EastCommons";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                             }];
    
    UIAlertAction* educationAction = [UIAlertAction actionWithTitle:@"Education" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Love Library
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Education";
                                                                 item.imageName = @"EastCommons";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.775377, -117.069597);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                             }];
    
    UIAlertAction* eduBusAdminAction = [UIAlertAction actionWithTitle:@"Education & Business Administration" style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                
                                                                self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                [self.mapAnnotations removeAllObjects];
                                                                
                                                                // annotation for Love Library
                                                                CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                item.place = @"Education & Business Administration";
                                                                item.imageName = @"EduBusAdmin";
                                                                item.coordinate = CLLocationCoordinate2DMake(32.775546, -117.068387);
                                                                
                                                                MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                you.title = @"green";
                                                                you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                
                                                                // user tapped "Art Gallery" button in the bottom toolbar
                                                                [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                [self.mapAnnotations addObject:item];
                                                                [self.mapAnnotations addObject:you];
                                                                [self.campusMap addAnnotations:self.mapAnnotations];
                                                                [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                
                                                                [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                
                                                            }];
    
    

    UIAlertAction* folwerAthleticCenterAction = [UIAlertAction actionWithTitle:@"Engineering" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                                  self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                  [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                  [self.mapAnnotations removeAllObjects];
                                                                  
                                                                  // annotation for Love Library
                                                                  CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                  item.place = @"Engineering";
                                                                  item.imageName = @"HardyTower";
                                                                  item.coordinate = CLLocationCoordinate2DMake(32.777012, -117.072257);
                                                                  
                                                                  MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                  you.title = @"green";
                                                                  you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                  
                                                                  // user tapped "Art Gallery" button in the bottom toolbar
                                                                  [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                  [self.mapAnnotations addObject:item];
                                                                  [self.mapAnnotations addObject:you];
                                                                  [self.campusMap addAnnotations:self.mapAnnotations];
                                                                  [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                  
                                                                  [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                  
                                                                  
                                                                  
                                                              }];
    
    
    UIAlertAction* engineeringAction = [UIAlertAction actionWithTitle:@"Engineering" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                                  self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                  [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                  [self.mapAnnotations removeAllObjects];
                                                                  
                                                                  // annotation for Love Library
                                                                  CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                  item.place = @"Engineering";
                                                                  item.imageName = @"EngineeringLab";
                                                                  item.coordinate = CLLocationCoordinate2DMake(32.777269, -117.070009);
                                                                  
                                                                  MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                  you.title = @"green";
                                                                  you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                  
                                                                  // user tapped "Art Gallery" button in the bottom toolbar
                                                                  [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                  [self.mapAnnotations addObject:item];
                                                                  [self.mapAnnotations addObject:you];
                                                                  [self.campusMap addAnnotations:self.mapAnnotations];
                                                                  [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                  
                                                                  [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                  
                                                                  
                                                              }];
    
    UIAlertAction* engineeringLabAction = [UIAlertAction actionWithTitle:@"Engineering Lab" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                                                                     
                                                                     self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                     [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                     [self.mapAnnotations removeAllObjects];
                                                                     
                                                                     // annotation for Love Library
                                                                     CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                     item.place = @"Engineering Lab";
                                                                     item.imageName = @"EngineeringLab";
                                                                     item.coordinate = CLLocationCoordinate2DMake(32.777269, -117.070009);
                                                                     
                                                                     MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                     you.title = @"green";
                                                                     you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                     
                                                                     // user tapped "Art Gallery" button in the bottom toolbar
                                                                     [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                     [self.mapAnnotations addObject:item];
                                                                     [self.mapAnnotations addObject:you];
                                                                     [self.campusMap addAnnotations:self.mapAnnotations];
                                                                     [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                     
                                                                     [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                     
                                                                     
                                                                 }];
    
    UIAlertAction* exerciseNutritionSciAction = [UIAlertAction actionWithTitle:@"Exercise and Nutritional Sciences" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action) {
                                                                   
                                                                   self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                   [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                   [self.mapAnnotations removeAllObjects];
                                                                   
                                                                   // annotation for ife Sciences
                                                                   CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                   item.place = @"ENS";
                                                                   item.imageName = @"ENSr";
                                                                   item.coordinate = CLLocationCoordinate2DMake(32.774673, -117.073241);
                                                                   
                                                                   MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                   you.title = @"green";
                                                                   you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                   
                                                                   // user tapped "Art Gallery" button in the bottom toolbar
                                                                   [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                   [self.mapAnnotations addObject:item];
                                                                   [self.mapAnnotations addObject:you];
                                                                   [self.campusMap addAnnotations:self.mapAnnotations];
                                                                   [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                   
                                                                   [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                   
                                                                   
                                                                   
                                                               }];
    
    
    

    

    UIAlertAction* fowlerAthleticCenterAction = [UIAlertAction actionWithTitle:@"Fowler Athletic Center" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                              self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                              [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                              [self.mapAnnotations removeAllObjects];
                                                                   
                                                              // annotation for Love Library
                                                              CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                              item.place = @"Fowler";
                                                              item.imageName = @"Fowler";
                                                              item.coordinate = CLLocationCoordinate2DMake(32.773453, -117.076334);
                                                                  
                                                                  MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                  you.title = @"green";
                                                                  you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                  
                                                                  // user tapped "Art Gallery" button in the bottom toolbar
                                                                  [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                  [self.mapAnnotations addObject:item];
                                                                  [self.mapAnnotations addObject:you];
                                                                  [self.campusMap addAnnotations:self.mapAnnotations];
                                                                  [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                  
                                                                  [_campusMap showAnnotations:_mapAnnotations animated:YES];
   
                                                         }];
    
    UIAlertAction* gatewayCenterAction = [UIAlertAction actionWithTitle:@"Gateway Center" style:UIAlertActionStyleDefault
                                                                     handler:^(UIAlertAction * action) {
                                                                         
                                                                         self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                         [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                         [self.mapAnnotations removeAllObjects];
                                                                         
                                                                         // annotation for Love Library
                                                                         CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                         item.place = @"Gateway/KPBS";
                                                                         item.imageName = @"GatewayCenter";
                                                                         item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                         
                                                                         MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                         you.title = @"green";
                                                                         you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                         
                                                                         // user tapped "Art Gallery" button in the bottom toolbar
                                                                         [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                         [self.mapAnnotations addObject:item];
                                                                         [self.mapAnnotations addObject:you];
                                                                         [self.campusMap addAnnotations:self.mapAnnotations];
                                                                         [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                         
                                                                         [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                         
                                                                     }];
    
    UIAlertAction* geographyAnnexAction = [UIAlertAction actionWithTitle:@"Geography Annex" style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * action) {
                                                                    
                                                                    self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                    [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                    [self.mapAnnotations removeAllObjects];
                                                                    
                                                                    // annotation for Love Library
                                                                    CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                    item.place = @"Geography Annex";
                                                                    item.imageName = @"GatewayCenter";
                                                                    item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                    
                                                                    MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                    you.title = @"green";
                                                                    you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                    
                                                                    // user tapped "Art Gallery" button in the bottom toolbar
                                                                    [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                    [self.mapAnnotations addObject:item];
                                                                    [self.mapAnnotations addObject:you];
                                                                    [self.campusMap addAnnotations:self.mapAnnotations];
                                                                    [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                    
                                                                    [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                    
                                                                }];
    
    UIAlertAction* geographyAction = [UIAlertAction actionWithTitle:@"Geog/Math/CompSci" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                                                                     
                                                                     self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                     [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                     [self.mapAnnotations removeAllObjects];
                                                                     
                                                                     // annotation for Love Library
                                                                     CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                     item.place = @"Geog/Math/CompSci";
                                                                     item.imageName = @"CompSci";
                                                                     item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                     
                                                                     MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                     you.title = @"green";
                                                                     you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                     
                                                                     // user tapped "Art Gallery" button in the bottom toolbar
                                                                     [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                     [self.mapAnnotations addObject:item];
                                                                     [self.mapAnnotations addObject:you];
                                                                     [self.campusMap addAnnotations:self.mapAnnotations];
                                                                     [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                     
                                                                     [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                     
                                                                 }];
    
    UIAlertAction* hardyTowerAction = [UIAlertAction actionWithTitle:@"Hardy Tower" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                                                                     
                                                                     self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                     [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                     [self.mapAnnotations removeAllObjects];
                                                                     
                                                                     // annotation for Love Library
                                                                     CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                     item.place = @"Hardy Tower";
                                                                     item.imageName = @"HardyTower";
                                                                     item.coordinate = CLLocationCoordinate2DMake(32.777012, -117.072257);
                                                                     
                                                                     MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                     you.title = @"green";
                                                                     you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                     
                                                                     // user tapped "Art Gallery" button in the bottom toolbar
                                                                     [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                     [self.mapAnnotations addObject:item];
                                                                     [self.mapAnnotations addObject:you];
                                                                     [self.campusMap addAnnotations:self.mapAnnotations];
                                                                     [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                     
                                                                     [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                     
                                                                 }];
    UIAlertAction* hepnerHallAction = [UIAlertAction actionWithTitle:@"Hepner Hall" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Love Library
                                                                 CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                 item.place = @"Hepner Hall";
                                                                 item.imageName = @"HepnerHall";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                             }];
    
    
    
    UIAlertAction* houseAdminAction = [UIAlertAction actionWithTitle:@"Housing Administration / Residential Education" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                                  self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                  [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                  [self.mapAnnotations removeAllObjects];
                                                                  
                                                                  // annotation for Love Library
                                                                  CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                  item.place = @"Housing Administration / Residential Education";
                                                                  item.imageName = @"OAT";
                                                                  item.coordinate = CLLocationCoordinate2DMake(32.770921, -117.069207);
                                                                  
                                                                  MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                  you.title = @"green";
                                                                  you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                  
                                                                  // user tapped "Art Gallery" button in the bottom toolbar
                                                                  [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                  [self.mapAnnotations addObject:item];
                                                                  [self.mapAnnotations addObject:you];
                                                                  [self.campusMap addAnnotations:self.mapAnnotations];
                                                                  [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                  
                                                                  [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                  
                                                                  
                                                                  
                                                              }];
    
    UIAlertAction* industrialTechnologyAction = [UIAlertAction actionWithTitle:@"Industrial Technology" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Love Library
                                                                 CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                 item.place = @"Industrial Technology";
                                                                 item.imageName = @"IndustrialTechnology";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.776775, -117.069572);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 
                                                                 
                                                             }];
    
    UIAlertAction* internationalStudentCenterAction = [UIAlertAction actionWithTitle:@"International Student Center" style:UIAlertActionStyleDefault
                                                                       handler:^(UIAlertAction * action) {
                                                                           
                                                                           self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                           [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                           [self.mapAnnotations removeAllObjects];
                                                                           
                                                                           // annotation for Love Library
                                                                           CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                           item.place = @"International Student Center";
                                                                           item.imageName = @"IndustrialTechnology";
                                                                           item.coordinate = CLLocationCoordinate2DMake(32.776775, -117.069572);
                                                                           
                                                                           MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                           you.title = @"green";
                                                                           you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                           
                                                                           // user tapped "Art Gallery" button in the bottom toolbar
                                                                           [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                           [self.mapAnnotations addObject:item];
                                                                           [self.mapAnnotations addObject:you];
                                                                           [self.campusMap addAnnotations:self.mapAnnotations];
                                                                           [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                           
                                                                           [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                           
                                                                           
                                                                           
                                                                           
                                                                       }];
    

    
    
    UIAlertAction* kpbsAction = [UIAlertAction actionWithTitle:@"KPBS Building" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {
                                                                       
                                                                       self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                       [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                       [self.mapAnnotations removeAllObjects];
                                                                       
                                                                       // annotation for Love Library
                                                                       CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                       item.place = @"KPBS";
                                                                       item.imageName = @"KPBS";
                                                                       item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                       
                                                                       
                                                                       MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                       you.title = @"green";
                                                                       you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                       
                                                                       // user tapped "Art Gallery" button in the bottom toolbar
                                                                       [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                       [self.mapAnnotations addObject:item];
                                                                       [self.mapAnnotations addObject:you];
                                                                       [self.campusMap addAnnotations:self.mapAnnotations];
                                                                       [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                       
                                                                       [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                       
                                                                       
                                                                       
                                                                       
                                                                   }];
    

    
    UIAlertAction* libraryBookDropAction = [UIAlertAction actionWithTitle:@"Library Book Drops" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      
                                                                      self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                      [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                      [self.mapAnnotations removeAllObjects];
                                                                     
                                                                      MKPointAnnotation *bookDropOne = [[MKPointAnnotation alloc] init];
                                                                      bookDropOne.title = @"Drive Up";
                                                                      bookDropOne.coordinate = CLLocationCoordinate2DMake(32.772535, -117.072174);
                                                                      
                                                                      MKPointAnnotation *bookDropTwo = [[MKPointAnnotation alloc] init];
                                                                      bookDropTwo.title = @"Walk Up";
                                                                      bookDropTwo.coordinate = CLLocationCoordinate2DMake(32.775199, -117.070127);
                                                                      
                                                                      
                                                                      MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                      you.title = @"green";
                                                                      you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                      
                                                                      // user tapped "Art Gallery" button in the bottom toolbar
                                                                      [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                      [self.mapAnnotations addObject:bookDropOne];
                                                                      [self.mapAnnotations addObject:bookDropTwo];
                                                                      [self.mapAnnotations addObject:you];
                                                                      [self.campusMap addAnnotations:self.mapAnnotations];
                                                                      [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                      
                                                                      [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                      
                                                                      
                                                                  }];
    
    
    UIAlertAction* lifeSciencesAction = [UIAlertAction actionWithTitle:@"Life Sciences Building" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           
                                                           self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                           [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                           [self.mapAnnotations removeAllObjects];
                                                           
                                                           // annotation for Love Library
                                                           CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                           item.place = @"Life Sciences Building";
                                                           item.imageName = @"LifeSciences";
                                                           item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                           
                                                           
                                                           MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                           you.title = @"green";
                                                           you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                           
                                                           // user tapped "Art Gallery" button in the bottom toolbar
                                                           [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                           [self.mapAnnotations addObject:item];
                                                           [self.mapAnnotations addObject:you];
                                                           [self.campusMap addAnnotations:self.mapAnnotations];
                                                           [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                           
                                                           [_campusMap showAnnotations:_mapAnnotations animated:YES];

                                                           
                                                       }];
    
    UIAlertAction* littleTheaterAction = [UIAlertAction actionWithTitle:@"Little Theater" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action) {
                                                                   
                                                                   self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                   [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                   [self.mapAnnotations removeAllObjects];
                                                                   
                                                                   // annotation for Love Library
                                                                   CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                   item.place = @"Little Theater";
                                                                   item.imageName = @"LittleTheatre";
                                                                   item.coordinate = CLLocationCoordinate2DMake(32.776595, -117.07211);
                                                                   
                                                                   
                                                                   MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                   you.title = @"green";
                                                                   you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                   
                                                                   // user tapped "Art Gallery" button in the bottom toolbar
                                                                   [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                   [self.mapAnnotations addObject:item];
                                                                   [self.mapAnnotations addObject:you];
                                                                   [self.campusMap addAnnotations:self.mapAnnotations];
                                                                   [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                   
                                                                   [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                   
                                                                   
                                                               }];
    
    UIAlertAction* loveLibraryAction = [UIAlertAction actionWithTitle:@"Love Library" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action) {
                                                                   
                                                                   self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                   [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                   [self.mapAnnotations removeAllObjects];
                                                                   
                                                                   // annotation for Love Library
                                                                   CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                   item.place = @"Love Library";
                                                                   item.imageName = @"LoveLibrary";
                                                                   item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                   
                                                                   
                                                                   MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                   you.title = @"green";
                                                                   you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                   
                                                                   // user tapped "Art Gallery" button in the bottom toolbar
                                                                   [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                   [self.mapAnnotations addObject:item];
                                                                   [self.mapAnnotations addObject:you];
                                                                   [self.campusMap addAnnotations:self.mapAnnotations];
                                                                   [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                   
                                                                   [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                   
                                                                   
                                                                   
                                                                   
                                                               }];
    
    UIAlertAction* manchesterHallAction = [UIAlertAction actionWithTitle:@"Manchester Hall" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                                  self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                  [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                  [self.mapAnnotations removeAllObjects];
                                                                  
                                                                  // annotation for Love Library
                                                                  CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                  item.place = @"Manchester Hall";
                                                                  item.imageName = @"ManchesterHall";
                                                                  item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                  
                                                                  
                                                                  MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                  you.title = @"green";
                                                                  you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                  
                                                                  // user tapped "Art Gallery" button in the bottom toolbar
                                                                  [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                  [self.mapAnnotations addObject:item];
                                                                  [self.mapAnnotations addObject:you];
                                                                  [self.campusMap addAnnotations:self.mapAnnotations];
                                                                  [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                  
                                                                  [_campusMap showAnnotations:_mapAnnotations animated:YES];

                                                                  
                                                              }];
    

    
    
    UIAlertAction* mayaResidenceHallAction = [UIAlertAction actionWithTitle:@"Maya Residence Hall" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                                  self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                  [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                  [self.mapAnnotations removeAllObjects];
                                                                  
                                                                  // annotation for Love Library
                                                                  CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                  item.place = @"Maya Residence Hall";
                                                                  item.imageName = @"GatewayCenter";
                                                                  item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                  
                                                                  MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                  you.title = @"green";
                                                                  you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                  
                                                                  // user tapped "Art Gallery" button in the bottom toolbar
                                                                  [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                  [self.mapAnnotations addObject:item];
                                                                  [self.mapAnnotations addObject:you];
                                                                  [self.campusMap addAnnotations:self.mapAnnotations];
                                                                  [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                  
                                                                  [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                  
                                                                  
                                                              }];
    
    
    UIAlertAction* nasatirHallAction = [UIAlertAction actionWithTitle:@"NasatirHall" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                                                                     
                                                                     self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                     [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                     [self.mapAnnotations removeAllObjects];
                                                                     
                                                                     // annotation for Love Library
                                                                     CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                     item.place = @"Nasatir Hall";
                                                                     item.imageName = @"NasatirHall";
                                                                     item.coordinate = CLLocationCoordinate2DMake(32.777116, -117.07348);
                                                                     
                                                                     MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                     you.title = @"green";
                                                                     you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                     
                                                                     // user tapped "Art Gallery" button in the bottom toolbar
                                                                     [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                     [self.mapAnnotations addObject:item];
                                                                     [self.mapAnnotations addObject:you];
                                                                     [self.campusMap addAnnotations:self.mapAnnotations];
                                                                     [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                     
                                                                     [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                     
                                                                     
                                                                 }];
    
    UIAlertAction* northEducationAction = [UIAlertAction actionWithTitle:@"North Education (NE)" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                                  self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                  [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                  [self.mapAnnotations removeAllObjects];
                                                                  
                                                                  // annotation for Love Library
                                                                  CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                  item.place = @"North Education";
                                                                  item.imageName = @"NorthEducation";
                                                                  item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                  
                                                                  MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                  you.title = @"green";
                                                                  you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                  
                                                                  // user tapped "Art Gallery" button in the bottom toolbar
                                                                  [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                  [self.mapAnnotations addObject:item];
                                                                  [self.mapAnnotations addObject:you];
                                                                  [self.campusMap addAnnotations:self.mapAnnotations];
                                                                  [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                  
                                                                  [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                  
                                                                  
                                                              }];

    UIAlertAction* olmecaResHallAction = [UIAlertAction actionWithTitle:@"Olmeca Residence Hall" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          
                                                          self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                          [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                          [self.mapAnnotations removeAllObjects];
                                                          
                                                          // annotation for Love Library
                                                          CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                          item.place = @"Olmeca Residence Hall";
                                                          item.imageName = @"OlmecaHall";
                                                          item.coordinate = CLLocationCoordinate2DMake(32.772053, -117.06844);
                                                          
                                                          MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                          you.title = @"green";
                                                          you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                          
                                                          // user tapped "Art Gallery" button in the bottom toolbar
                                                          [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                          [self.mapAnnotations addObject:item];
                                                          [self.mapAnnotations addObject:you];
                                                          [self.campusMap addAnnotations:self.mapAnnotations];
                                                          [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                          
                                                          [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                          
                                                          
                                                      }];
    
    
    UIAlertAction* oatAction = [UIAlertAction actionWithTitle:@"Open Air Theatre" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                                                                     
                                                                     self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                     [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                     [self.mapAnnotations removeAllObjects];
                                                                     
                                                                     // annotation for Love Library
                                                                     CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                     item.place = @"Open Air Theatre";
                                                                     item.imageName = @"OAT";
                                                                     item.coordinate = CLLocationCoordinate2DMake(332.77415, -117.0713);
                                                                     
                                                                     MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                     you.title = @"green";
                                                                     you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                     
                                                                     // user tapped "Art Gallery" button in the bottom toolbar
                                                                     [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                     [self.mapAnnotations addObject:item];
                                                                     [self.mapAnnotations addObject:you];
                                                                     [self.campusMap addAnnotations:self.mapAnnotations];
                                                                     [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                     
                                                                     [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                     
                                                                     
                                                                 }];
    

                                                     
    UIAlertAction* physicalSciencesAction = [UIAlertAction actionWithTitle:@"Parking Information" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          
                                                          self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                          [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                          [self.mapAnnotations removeAllObjects];
                                                          
                                                          // annotation for Love Library
                                                          CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                          item.place = @"Parking Information";
                                                          item.imageName = @"OAT";
                                                          item.coordinate = CLLocationCoordinate2DMake(332.77415, -117.0713);
                                                          
                                                          MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                          you.title = @"green";
                                                          you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                          
                                                          // user tapped "Art Gallery" button in the bottom toolbar
                                                          [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                          [self.mapAnnotations addObject:item];
                                                          [self.mapAnnotations addObject:you];
                                                          [self.campusMap addAnnotations:self.mapAnnotations];
                                                          [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                          
                                                          [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                          
                                                          
                                                      }];
    
    UIAlertAction* parmaAlumniAction = [UIAlertAction actionWithTitle:@"Parma Payne Goodall Alumni Center" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {
                                                                       
                                                                       self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                       [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                       [self.mapAnnotations removeAllObjects];
                                                                       
                                                                       // annotation for Love Library
                                                                       CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                       item.place = @"Open Air Theatre";
                                                                       item.imageName = @"OAT";
                                                                       item.coordinate = CLLocationCoordinate2DMake(332.77415, -117.0713);
                                                                       
                                                                       MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                       you.title = @"green";
                                                                       you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                       
                                                                       // user tapped "Art Gallery" button in the bottom toolbar
                                                                       [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                       [self.mapAnnotations addObject:item];
                                                                       [self.mapAnnotations addObject:you];
                                                                       [self.campusMap addAnnotations:self.mapAnnotations];
                                                                       [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                       
                                                                       [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                       
                                                                       
                                                                   }];
    
    UIAlertAction* petersonGymAction = [UIAlertAction actionWithTitle:@"Peterson Gym" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                                  self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                  [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                  [self.mapAnnotations removeAllObjects];
                                                                  
                                                                  // annotation for Love Library
                                                                  CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                  item.place = @"Peterson Gym";
                                                                  item.imageName = @"PetersonGym";
                                                                  item.coordinate = CLLocationCoordinate2DMake(32.774006, -117.076262);
                                                                  
                                                                  MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                  you.title = @"green";
                                                                  you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                  
                                                                  // user tapped "Art Gallery" button in the bottom toolbar
                                                                  [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                  [self.mapAnnotations addObject:item];
                                                                  [self.mapAnnotations addObject:you];
                                                                  [self.campusMap addAnnotations:self.mapAnnotations];
                                                                  [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                  
                                                                  [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                  
                                                                  
                                                              }];
    


    
    UIAlertAction* physicsAstroAction = [UIAlertAction actionWithTitle:@"Physics/Astronomy" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {
                                                                       
                                                                       self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                       [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                       [self.mapAnnotations removeAllObjects];
                                                                       
                                                                       // annotation for Love Library
                                                                       CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                       item.place = @"Physics / Astronomy Building";
                                                                       item.imageName = @"PhysicsAstronomy";
                                                                       item.coordinate = CLLocationCoordinate2DMake(32.776268, -117.070858);
                                                                       
                                                                       MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                       you.title = @"green";
                                                                       you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                       
                                                                       // user tapped "Art Gallery" button in the bottom toolbar
                                                                       [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                       [self.mapAnnotations addObject:item];
                                                                       [self.mapAnnotations addObject:you];
                                                                       [self.campusMap addAnnotations:self.mapAnnotations];
                                                                       [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                       
                                                                       [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                       
                                                                       
                                                                   }];

    

    
    UIAlertAction* profStudiesFineArtsAction = [UIAlertAction actionWithTitle:@"Professional Studies and Fine Arts" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Love Library
                                                                 CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                 item.place = @"Professional Studies & Fine Arts";
                                                                 item.imageName = @"PFSA";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.776987, -117.072515);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 
                                                             }];
    
    UIAlertAction* prospectiveStudentCenterAction = [UIAlertAction actionWithTitle:@"Prospective Student Center" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {
                                                                          
                                                                          self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                          [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                          [self.mapAnnotations removeAllObjects];
                                                                          
                                                                          // annotation for Love Library
                                                                          CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                          item.place = @"Prospective Student Center";
                                                                          item.imageName = @"AztecSculpture";
                                                                          item.coordinate = CLLocationCoordinate2DMake(32.774655, -117.069685);
                                                                          
                                                                          MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                          you.title = @"green";
                                                                          you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                          
                                                                          // user tapped "Art Gallery" button in the bottom toolbar
                                                                          [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                          [self.mapAnnotations addObject:item];
                                                                          [self.mapAnnotations addObject:you];
                                                                          [self.campusMap addAnnotations:self.mapAnnotations];
                                                                          [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                          
                                                                          [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                          
                                                                          
                                                                      }];
    
    UIAlertAction* publicSafetyAction = [UIAlertAction actionWithTitle:@"Public Safety" style:UIAlertActionStyleDefault
                                                                           handler:^(UIAlertAction * action) {
                                                                               
                                                                               self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                               [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                               [self.mapAnnotations removeAllObjects];
                                                                               
                                                                               // annotation for Love Library
                                                                               CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                               item.place = @"Public Safety";
                                                                               item.imageName = @"PublicSafety";
                                                                               item.coordinate = CLLocationCoordinate2DMake(32.774642, -117.076433);
                                                                               
                                                                               MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                               you.title = @"green";
                                                                               you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                               
                                                                               // user tapped "Art Gallery" button in the bottom toolbar
                                                                               [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                               [self.mapAnnotations addObject:item];
                                                                               [self.mapAnnotations addObject:you];
                                                                               [self.campusMap addAnnotations:self.mapAnnotations];
                                                                               [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                               
                                                                               [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                               
                                                                               
                                                                           }];
    
    UIAlertAction* scrippsCottageAction = [UIAlertAction actionWithTitle:@"Scripps Cottage" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action) {
                                                                   
                                                                   self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                   [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                   [self.mapAnnotations removeAllObjects];
                                                                   
                                                                   // annotation for Love Library
                                                                   CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                   item.place = @"Scripps Cottage";
                                                                   item.imageName = @"ScrippsCottage";
                                                                   item.coordinate = CLLocationCoordinate2DMake(32.775688, -117.072973);
                                                                   
                                                                   MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                   you.title = @"green";
                                                                   you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                   
                                                                   // user tapped "Art Gallery" button in the bottom toolbar
                                                                   [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                   [self.mapAnnotations addObject:item];
                                                                   [self.mapAnnotations addObject:you];
                                                                   [self.campusMap addAnnotations:self.mapAnnotations];
                                                                   [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                   
                                                                   [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                   
                                                                   
                                                               }];
    
    UIAlertAction* speechLangAction = [UIAlertAction actionWithTitle:@"Speech, Language and Hearing" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                                                                     
                                                                     self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                     [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                     [self.mapAnnotations removeAllObjects];
                                                                     
                                                                     // annotation for Love Library
                                                                     CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                     item.place = @"Speech, Language and Hearing";
                                                                     item.imageName = @"SpeechLangHear";
                                                                     item.coordinate = CLLocationCoordinate2DMake(32.772183, -117.071745);
                                                                     
                                                                     MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                     you.title = @"green";
                                                                     you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                     
                                                                     // user tapped "Art Gallery" button in the bottom toolbar
                                                                     [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                     [self.mapAnnotations addObject:item];
                                                                     [self.mapAnnotations addObject:you];
                                                                     [self.campusMap addAnnotations:self.mapAnnotations];
                                                                     [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                     
                                                                     [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                     
                                                                     
                                                                 }];
    
    
    UIAlertAction* stormHallWestAction = [UIAlertAction actionWithTitle:@"Storm Hall West" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Love Library
                                                                 CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                 item.place = @"Viejas Arena";
                                                                 item.imageName = @"ViejasArena";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.773645, -117.07543);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 
                                                             }];
    
    UIAlertAction* studentServicesAction = [UIAlertAction actionWithTitle:@"Student Services" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Love Library
                                                                 CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                 item.place = @"Viejas Arena";
                                                                 item.imageName = @"ViejasArena";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.773645, -117.07543);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                             }];
    
    
    UIAlertAction* transitCenterAction = [UIAlertAction actionWithTitle:@"Transit Center" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                                                                     
                                                                     self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                     [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                     [self.mapAnnotations removeAllObjects];
                                                                     
                                                                     // annotation for Love Library
                                                                     CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                     item.place = @"Viejas Arena";
                                                                     item.imageName = @"ViejasArena";
                                                                     item.coordinate = CLLocationCoordinate2DMake(32.773645, -117.07543);
                                                                     
                                                                     MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                     you.title = @"green";
                                                                     you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                     
                                                                     // user tapped "Art Gallery" button in the bottom toolbar
                                                                     [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                     [self.mapAnnotations addObject:item];
                                                                     [self.mapAnnotations addObject:you];
                                                                     [self.campusMap addAnnotations:self.mapAnnotations];
                                                                     [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                     
                                                                     [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                     
                                                                     
                                                                 }];
    
    UIAlertAction* tulaCommunityAction = [UIAlertAction actionWithTitle:@"Tula Community Center" style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * action) {
                                                                    
                                                                    self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                    [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                    [self.mapAnnotations removeAllObjects];
                                                                    
                                                                    // annotation for Love Library
                                                                    CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                    item.place = @"Viejas Arena";
                                                                    item.imageName = @"ViejasArena";
                                                                    item.coordinate = CLLocationCoordinate2DMake(32.773645, -117.07543);
                                                                    
                                                                    MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                    you.title = @"green";
                                                                    you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                    
                                                                    // user tapped "Art Gallery" button in the bottom toolbar
                                                                    [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                    [self.mapAnnotations addObject:item];
                                                                    [self.mapAnnotations addObject:you];
                                                                    [self.campusMap addAnnotations:self.mapAnnotations];
                                                                    [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                    
                                                                    [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                    
                                                                    
                                                                }];
    
    UIAlertAction* universityTowerAction = [UIAlertAction actionWithTitle:@"University Tower Residence Hall" style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * action) {
                                                                    
                                                                    self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                    [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                    [self.mapAnnotations removeAllObjects];
                                                                    
                                                                    // annotation for Love Library
                                                                    CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                    item.place = @"University Towers";
                                                                    item.imageName = @"UniversityTowers";
                                                                    item.coordinate = CLLocationCoordinate2DMake(32.770587, -117.075205);
                                                                    
                                                                    MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                    you.title = @"green";
                                                                    you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                    
                                                                    // user tapped "Art Gallery" button in the bottom toolbar
                                                                    [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                    [self.mapAnnotations addObject:item];
                                                                    [self.mapAnnotations addObject:you];
                                                                    [self.campusMap addAnnotations:self.mapAnnotations];
                                                                    [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                    
                                                                    [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                    
                                                                    
                                                                }];
    
    UIAlertAction* viejasArenaAction = [UIAlertAction actionWithTitle:@"Viejas Arena" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      
                                                                      self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                      [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                      [self.mapAnnotations removeAllObjects];
                                                                      
                                                                      // annotation for Love Library
                                                                      CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                      item.place = @"Viejas Arena";
                                                                      item.imageName = @"ViejasArena";
                                                                      item.coordinate = CLLocationCoordinate2DMake(32.773645, -117.07543);
                                                                      
                                                                      MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                      you.title = @"green";
                                                                      you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                      
                                                                      // user tapped "Art Gallery" button in the bottom toolbar
                                                                      [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                      [self.mapAnnotations addObject:item];
                                                                      [self.mapAnnotations addObject:you];
                                                                      [self.campusMap addAnnotations:self.mapAnnotations];
                                                                      [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                      
                                                                      [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                      
                                                                      
                                                                  }];
    
    UIAlertAction* villaAlvaradoAction = [UIAlertAction actionWithTitle:@"Villa Alvarado Residence Hall" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      
                                                                      self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                      [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                      [self.mapAnnotations removeAllObjects];
                                                                      
                                                                      // annotation for Love Library
                                                                      CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                      item.place = @"Villa Alvarado Res. Hall";
                                                                      // no image
                                                                      item.coordinate = CLLocationCoordinate2DMake(32.773645, -117.07543);
                                                                      
                                                                      MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                      you.title = @"green";
                                                                      you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                      
                                                                      // user tapped "Art Gallery" button in the bottom toolbar
                                                                      [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                      [self.mapAnnotations addObject:item];
                                                                      [self.mapAnnotations addObject:you];
                                                                      [self.campusMap addAnnotations:self.mapAnnotations];
                                                                      [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                      
                                                                      [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                      
                                                                      
                                                                  }];
    
    UIAlertAction* westCommonAction = [UIAlertAction actionWithTitle:@"West Commons (WC)" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Love Library
                                                                 CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                 item.place = @"West Commons (WC)";
                                                                 item.imageName = @"WestCommons";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.776227, -117.073437);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 
                                                             }];
    
    UIAlertAction* zuraResHallAction = [UIAlertAction actionWithTitle:@"Zura Residence Hall" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Love Library
                                                                 CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                 item.place = @"Zura Hall";
                                                                 item.imageName = @"ZuraHall";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.776227, -117.073437);
                                                                 
                                                                 MKPointAnnotation *you = [[MKPointAnnotation alloc] init];
                                                                 you.title = @"green";
                                                                 you.coordinate = CLLocationCoordinate2DMake(_campusMap.userLocation.coordinate.latitude, _campusMap.userLocation.coordinate.longitude);
                                                                 
                                                                 // user tapped "Art Gallery" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.mapAnnotations addObject:you];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 [_campusMap showAnnotations:_mapAnnotations animated:YES];
                                                                 
                                                                 
                                                             }];
    
    
    [alert addAction:administrationAction];
    [alert addAction:adamsHumanitiesAction];
    [alert addAction:ALIAction];
    [alert addAction:aquaplexAction];
    [alert addAction:arenaMeetingCenterAction];
    [alert addAction:artAction];
    [alert addAction:artGalleryAction];
    [alert addAction:artsandLettersAction];
    [alert addAction:fowlerAthleticCenterAction];
    [alert addAction:aztecMesaModularsAction];
    [alert addAction:ARCAction];
    [alert addAction:ASUAction];
    [alert addAction:bioscienceCenterAction];
    [alert addAction:blicksArtSuppliesAction];
    [alert addAction:bookstoreAction];
    [alert addAction:calpulliAction];
    [alert addAction:chapultapecAction];
    [alert addAction:chemSciLabAction];
    [alert addAction:childrenCenterAction];
    [alert addAction:cholulaAction];
    [alert addAction:collegeSquareAction];
    [alert addAction:communicationAction];
    [alert addAction:cuicalliSuitesAction];
    [alert addAction:dramaticArtsAction];
    [alert addAction:educationAction];
    [alert addAction:eduBusAdminAction];
    [alert addAction:engineeringLabAction];
    [alert addAction:eastCommonAction];
    [alert addAction:engineeringAction];
    [alert addAction:exerciseNutritionSciAction];
    [alert addAction:folwerAthleticCenterAction];
    [alert addAction:gatewayCenterAction];
    [alert addAction:geographyAction];
    [alert addAction:geographyAnnexAction];
    [alert addAction:hardyTowerAction];
    [alert addAction:hepnerHallAction];
    [alert addAction:houseAdminAction];
    [alert addAction:industrialTechnologyAction];
    [alert addAction:internationalStudentCenterAction];
    [alert addAction:kpbsAction];
    [alert addAction:libraryBookDropAction];
    [alert addAction:lifeSciencesAction];
    [alert addAction:littleTheaterAction];
    [alert addAction:loveLibraryAction];
    [alert addAction:mayaResidenceHallAction];
    [alert addAction:manchesterHallAction];
    [alert addAction:northEducationAction];
    [alert addAction:nasatirHallAction];
    [alert addAction:oatAction];
    [alert addAction:olmecaResHallAction];
    [alert addAction:parmaAlumniAction];
    [alert addAction:petersonGymAction];
    [alert addAction:physicalSciencesAction];
    [alert addAction:physicsAstroAction];
    [alert addAction:profStudiesFineArtsAction];
    [alert addAction:prospectiveStudentCenterAction];
    [alert addAction:publicSafetyAction];
    [alert addAction:scrippsCottageAction];
    [alert addAction:speechLangAction];
    [alert addAction:stormHallWestAction];
    [alert addAction:studentServicesAction];
    [alert addAction:transitCenterAction];
    [alert addAction:tulaCommunityAction];
    [alert addAction:universityTowerAction];
    [alert addAction:viejasArenaAction];
    [alert addAction:villaAlvaradoAction];
    [alert addAction:westCommonAction];
    [alert addAction:zuraResHallAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)selfAction:(id)sender
{
    // user tapped "Tea Gardon" button in the bottom toolbar
    [self gotoByAnnotationClass:[CustomAnnotation class]];
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s:%d %@", __func__, __LINE__, error);
}

static NSString *DescriptionOfCLAuthorizationStatus(CLAuthorizationStatus st)
{
    switch (st)
    {
        case kCLAuthorizationStatusNotDetermined:
            return @"kCLAuthorizationStatusNotDetermined";
        case kCLAuthorizationStatusRestricted:
            return @"kCLAuthorizationStatusRestricted";
        case kCLAuthorizationStatusDenied:
            return @"kCLAuthorizationStatusDenied";
            //case kCLAuthorizationStatusAuthorized: is the same as
            //kCLAuthorizationStatusAuthorizedAlways
        case kCLAuthorizationStatusAuthorizedAlways:
            return @"kCLAuthorizationStatusAuthorizedAlways";
            
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            return @"kCLAuthorizationStatusAuthorizedWhenInUse";
    }
    return [NSString stringWithFormat:@"Unknown CLAuthorizationStatus value: %d", st];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"%s:%d %@", __func__, __LINE__, DescriptionOfCLAuthorizationStatus(status));
}



@end
