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
//@property(nonatomic, readonly) MKUserLocation *userLocation;


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
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}


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
    //[self.campusMap setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
    
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
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                

                                                                 
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
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 
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
                                                                 item.imageName = @"HepnerHall";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.7771333, -117.0743);
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 
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
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 
                                                                 
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
                                                               
                                                               // user tapped "Tea Gardon" button in the bottom toolbar
                                                               [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                               [self.mapAnnotations addObject:item];
                                                               [self.campusMap addAnnotations:self.mapAnnotations];
                                                               
                                                               
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
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 
                                                                 
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
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 item = nil;
                                                                 
                                                             }];
    UIAlertAction* artsandLettersAction = [UIAlertAction actionWithTitle:@"Arts and Letters (AL)" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Arts and Letters (AL)";
                                                                 item.imageName = @"HepnerHall";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.777488, -117.073188);
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 item = nil;
                                                                 
                                                             }];

    UIAlertAction* aztecAthleticCenterAction = [UIAlertAction actionWithTitle:@"Aztec Athletic Center (AZAT)" style:UIAlertActionStyleDefault
                                                                    handler:^(UIAlertAction * action) {
                                                                        
                                                                        self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                        [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                        [self.mapAnnotations removeAllObjects];
                                                                        
                                                                        // annotation for Hepner Hall
                                                                        CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                        item.place = @"Aztec Athletic Center (AZAT)";
                                                                        item.imageName = @"HepnerHall";
                                                                        item.coordinate = CLLocationCoordinate2DMake(32.774006, -117.076262);
                                                                        
                                                                        // user tapped "Tea Gardon" button in the bottom toolbar
                                                                        [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                        [self.mapAnnotations addObject:item];
                                                                        [self.campusMap addAnnotations:self.mapAnnotations];
                                                                        item = nil;
                                                                        
                                                                    }];
    
    
    UIAlertAction* aztecMesaModularsAction = [UIAlertAction actionWithTitle:@"Aztec Mesa Modulars (AMSA)" style:UIAlertActionStyleDefault
                                                                    handler:^(UIAlertAction * action) {
                                                                        
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                        
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Aztec Mesa Modulars (AMSA)";
                                                                 item.imageName = @"HepnerHall";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.774513, -117.073475);
                                                                        
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 item = nil;
                                                                        
                                                                }];
    
    UIAlertAction* ARCAction = [UIAlertAction actionWithTitle:@"Aztec Recreation Center (ARC)" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Aztec Recreation Center (ARC)";
                                                                 item.imageName = @"HepnerHall";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.776315, -117.076262);
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 item = nil;
                                                                 
                                                             }];

    UIAlertAction* bioscienceCenterAction = [UIAlertAction actionWithTitle:@"Bioscience Center" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Bioscience Center";
                                                                 item.imageName = @"HepnerHall";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.778083, -117.071257);
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 item = nil;
                                                                 
                                                             }];
    UIAlertAction* blicksArtSuppliesAction = [UIAlertAction actionWithTitle:@"Blicks Art Supplies" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Hepner Hall";
                                                                 item.imageName = @"HepnerHall";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.77802, -117.072075);
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 item = nil;
                                                                 
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
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 item = nil;
                                                                 
                                                             }];
    UIAlertAction* calpulliAction = [UIAlertAction actionWithTitle:@"Calpulli Center (CLP)" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Calpulli Center (CLP)";
                                                                 item.imageName = @"HepnerHall";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.772598, -117.073472);
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 item = nil;
                                                                 
                                                             }];
    UIAlertAction* chapultapecAction = [UIAlertAction actionWithTitle:@"Chapultapec Residence Hall (CHAP)" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Chapultapec Residence Hall (CHAP)";
                                                                 item.imageName = @"HepnerHall";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.775503, -117.078917);
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 item = nil;
                                                                 
                                                             }];
    UIAlertAction* chemSciLabAction = [UIAlertAction actionWithTitle:@"Chemical Sciences Laboratory" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Chemical Sciences Laboratory";
                                                                 item.imageName = @"HepnerHall";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.776523, -117.068682);
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 item = nil;
                                                                 
                                                             }];
    UIAlertAction* childrenCenterAction = [UIAlertAction actionWithTitle:@"Children's Center" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 // annotation for Hepner Hall
                                                                 CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                 item.place = @"Children's Center";
                                                                 item.imageName = @"HepnerHall";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.773717, -117.066042);
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 item = nil;
                                                                 
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
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 item = nil;
                                                                 
                                                             }];
    
    UIAlertAction* collegeSquareAction = [UIAlertAction actionWithTitle:@"College Square (CSQ)" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                              [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                              [self.mapAnnotations removeAllObjects];
                                                              
                                                              // annotation for Hepner Hall
                                                              CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                              item.place = @"College Square (CSQ)";
                                                              item.imageName = @"HepnerHall";
                                                              item.coordinate = CLLocationCoordinate2DMake(32.771426, -117.06984);
                                                              
                                                              // user tapped "Tea Gardon" button in the bottom toolbar
                                                              [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                              [self.mapAnnotations addObject:item];
                                                              [self.campusMap addAnnotations:self.mapAnnotations];
                                                              item = nil;
                                                              
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
                                                                    
                                                                    // user tapped "Tea Gardon" button in the bottom toolbar
                                                                    [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                    [self.mapAnnotations addObject:item];
                                                                    [self.campusMap addAnnotations:self.mapAnnotations];
                                                                    item = nil;
                                                                    
                                                                }];
    
    UIAlertAction* cuicalliSuitesAction = [UIAlertAction actionWithTitle:@"Cross Cultural Center (Aztec Student Union Rm 250)" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                              [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                              [self.mapAnnotations removeAllObjects];
                                                              
                                                              // annotation for Hepner Hall
                                                              CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                              item.place = @"Cholula Hall";
                                                              item.imageName = @"HepnerHall";
                                                              item.coordinate = CLLocationCoordinate2DMake(32.77405, -117.0697);
                                                              
                                                              // user tapped "Tea Gardon" button in the bottom toolbar
                                                              [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                              [self.mapAnnotations addObject:item];
                                                              [self.campusMap addAnnotations:self.mapAnnotations];
                                                              item = nil;
                                                              
                                                          }];
    
    UIAlertAction* departmentofPublicSafetyAction = [UIAlertAction actionWithTitle:@"Department of Public Safety" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action) {
                                                                   
                                                                   self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                   [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                   [self.mapAnnotations removeAllObjects];
                                                                   
                                                                   // annotation for Love Library
                                                                   CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                   item.place = @"Department of Public Safety";
                                                                   item.imageName = @"GatewayCenter";
                                                                   item.coordinate = CLLocationCoordinate2DMake(32.774727, -117.07646);
                                                                   
                                                                   [self.mapAnnotations addObject:item];
                                                                   
                                                                   // user tapped "Tea Gardon" button in the bottom toolbar
                                                                   [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                   
                                                                   
                                                                   
                                                               }];
    
    
    UIAlertAction* dramaticArtsAction = [UIAlertAction actionWithTitle:@"Dramatic Arts" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                               
                                                               self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                               [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                               [self.mapAnnotations removeAllObjects];
                                                               
                                                               // annotation for Love Library
                                                               CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                               item.place = @"Gateway/KPBS";
                                                               item.imageName = @"GatewayCenter";
                                                               item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                               
                                                               [self.mapAnnotations addObject:item];
                                                               
                                                               // user tapped "Tea Gardon" button in the bottom toolbar
                                                               [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                               
                                                               
                                                               
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
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 
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
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 
                                                             }];
    
    UIAlertAction* eduBusAdminAction = [UIAlertAction actionWithTitle:@"Education & Business Administration" style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                
                                                                self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                [self.mapAnnotations removeAllObjects];
                                                                
                                                                // annotation for Love Library
                                                                CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                item.place = @"Education & Business Administration";
                                                                item.imageName = @"EastCommons";
                                                                item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                
                                                                // user tapped "Tea Gardon" button in the bottom toolbar
                                                                [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                [self.mapAnnotations addObject:item];
                                                                [self.campusMap addAnnotations:self.mapAnnotations];
                                                                
                                                            }];
    
    

    UIAlertAction* folwerAthleticCenterAction = [UIAlertAction actionWithTitle:@"Engineering" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                                  self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                  [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                  [self.mapAnnotations removeAllObjects];
                                                                  
                                                                  // annotation for Love Library
                                                                  CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                  item.place = @"Fowler Athletic Center";
                                                                  item.imageName = @"HardyTower";
                                                                  item.coordinate = CLLocationCoordinate2DMake(32.777012, -117.072257);
                                                                  
                                                                  // user tapped "Tea Gardon" button in the bottom toolbar
                                                                  [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                  [self.mapAnnotations addObject:item];
                                                                  [self.campusMap addAnnotations:self.mapAnnotations];
                                                                  
                                                                  
                                                                  
                                                              }];
    
    
    UIAlertAction* engineeringAction = [UIAlertAction actionWithTitle:@"Engineering Lab" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                                  self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                  [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                  [self.mapAnnotations removeAllObjects];
                                                                  
                                                                  // annotation for Love Library
                                                                  CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                  item.place = @"KPBS Building";
                                                                  item.imageName = @"KPBS";
                                                                  item.coordinate = CLLocationCoordinate2DMake(32.77194, -117.072169);
                                                                  
                                                                  // user tapped "Tea Gardon" button in the bottom toolbar
                                                                  [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                  [self.mapAnnotations addObject:item];
                                                                  [self.campusMap addAnnotations:self.mapAnnotations];
                                                                  
                                                                  
                                                              }];
    
    UIAlertAction* engineeringLabAction = [UIAlertAction actionWithTitle:@"Engineering Lab" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                                                                     
                                                                     self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                     [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                     [self.mapAnnotations removeAllObjects];
                                                                     
                                                                     // annotation for Love Library
                                                                     CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                     item.place = @"KPBS Building";
                                                                     item.imageName = @"KPBS";
                                                                     item.coordinate = CLLocationCoordinate2DMake(32.77194, -117.072169);
                                                                     
                                                                     // user tapped "Tea Gardon" button in the bottom toolbar
                                                                     [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                     [self.mapAnnotations addObject:item];
                                                                     [self.campusMap addAnnotations:self.mapAnnotations];
                                                                     
                                                                     
                                                                 }];
    
    UIAlertAction* exerciseNutritionSciAction = [UIAlertAction actionWithTitle:@"Exercise and Nutritional Sciences" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action) {
                                                                   
                                                                   self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                   [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                   [self.mapAnnotations removeAllObjects];
                                                                   
                                                                   // annotation for ife Sciences
                                                                   CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                   item.place = @"Gateway/KPBS";
                                                                   item.imageName = @"GatewayCenter";
                                                                   item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                   
                                                                   // user tapped "Tea Gardon" button in the bottom toolbar
                                                                   [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                   [self.mapAnnotations addObject:item];
                                                                   [self.campusMap addAnnotations:self.mapAnnotations];;
                                                                   
                                                                   
                                                                   
                                                               }];
    
    
    
    UIAlertAction* exerciseNutritionSciAnnexAction = [UIAlertAction actionWithTitle:@"Exercise and Nutritional Sciences Annex" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                        
                                                              self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                              [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                              [self.mapAnnotations removeAllObjects];
                                                              
                                                              // annotation for Love Library
                                                              CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                              item.place = @"Love Library";
                                                              item.imageName = @"LoveLibrary";
                                                              item.coordinate = CLLocationCoordinate2DMake(32.774937, -117.071128);
                                                              
                                                              // user tapped "Tea Gardon" button in the bottom toolbar
                                                              [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                              [self.mapAnnotations addObject:item];
                                                              [self.campusMap addAnnotations:self.mapAnnotations];
                                                              
                                                             

                                                          }];
    

    

    UIAlertAction* facilitiesServicesAction = [UIAlertAction actionWithTitle:@"Facilities Services" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                              self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                              [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                              [self.mapAnnotations removeAllObjects];
                                                                   
                                                              // annotation for Love Library
                                                              CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                              item.place = @"Gateway/KPBS";
                                                              item.imageName = @"GatewayCenter";
                                                              item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                  
                                                              // user tapped "Tea Gardon" button in the bottom toolbar
                                                              [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                              [self.mapAnnotations addObject:item];
                                                              [self.campusMap addAnnotations:self.mapAnnotations];
   
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
                                                                         
                                                                         // user tapped "Tea Gardon" button in the bottom toolbar
                                                                         [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                         [self.mapAnnotations addObject:item];
                                                                         [self.campusMap addAnnotations:self.mapAnnotations];
                                                                         
                                                                     }];
    
    UIAlertAction* geographyAnnexAction = [UIAlertAction actionWithTitle:@"Geography Annex" style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * action) {
                                                                    
                                                                    self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                    [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                    [self.mapAnnotations removeAllObjects];
                                                                    
                                                                    // annotation for Love Library
                                                                    CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                    item.place = @"Gateway/KPBS";
                                                                    item.imageName = @"GatewayCenter";
                                                                    item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                    
                                                                    // user tapped "Tea Gardon" button in the bottom toolbar
                                                                    [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                    [self.mapAnnotations addObject:item];
                                                                    [self.campusMap addAnnotations:self.mapAnnotations];
                                                                    
                                                                }];
    
    UIAlertAction* geographyAction = [UIAlertAction actionWithTitle:@"Geography/Mathematics/Computer Science" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                                                                     
                                                                     self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                     [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                     [self.mapAnnotations removeAllObjects];
                                                                     
                                                                     // annotation for Love Library
                                                                     CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                     item.place = @"Gateway/KPBS";
                                                                     item.imageName = @"GatewayCenter";
                                                                     item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                     
                                                                     // user tapped "Tea Gardon" button in the bottom toolbar
                                                                     [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                     [self.mapAnnotations addObject:item];
                                                                     [self.campusMap addAnnotations:self.mapAnnotations];
                                                                     
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
                                                                     
                                                                     // user tapped "Tea Gardon" button in the bottom toolbar
                                                                     [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                     [self.mapAnnotations addObject:item];
                                                                     [self.campusMap addAnnotations:self.mapAnnotations];
                                                                     
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
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 
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
                                                                  
                                                                  // user tapped "Tea Gardon" button in the bottom toolbar
                                                                  [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                  [self.mapAnnotations addObject:item];
                                                                  [self.campusMap addAnnotations:self.mapAnnotations];
                                                                  
                                                                  
                                                                  
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
                                                                 
                                                                 // user tapped "Tea Gardon" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 
                                                                 
                                                                 
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
                                                                           
                                                                           // user tapped "Tea Gardon" button in the bottom toolbar
                                                                           [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                           [self.mapAnnotations addObject:item];
                                                                           [self.campusMap addAnnotations:self.mapAnnotations];
                                                                           
                                                                           
                                                                           
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
                                                                       
                                                                       
                                                                       // user tapped "Tea Gardon" button in the bottom toolbar
                                                                       [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                       [self.mapAnnotations addObject:item];
                                                                       [self.campusMap addAnnotations:self.mapAnnotations];
                                                                       
                                                                       
                                                                       
                                                                       
                                                                   }];
    
    UIAlertAction* libraryAdditionAction = [UIAlertAction actionWithTitle:@"Library Addition" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action) {
                                                                   
                                                                   self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                   [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                   [self.mapAnnotations removeAllObjects];
                                                                   
                                                                   // annotation for Love Library
                                                                   CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                   item.place = @"Life Sciences Building";
                                                                   item.imageName = @"GatewayCenter";
                                                                   item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                   
                                                                   
                                                                   // user tapped "Tea Gardon" button in the bottom toolbar
                                                                   [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                   [self.mapAnnotations addObject:item];
                                                                   [self.campusMap addAnnotations:self.mapAnnotations];

                                                                   
                                                               }];
    
    UIAlertAction* libraryBookDropAction = [UIAlertAction actionWithTitle:@"Library Book Drop" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      
                                                                      self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                      [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                      [self.mapAnnotations removeAllObjects];
                                                                      
                                                                      // annotation for Love Library
                                                                      CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                      item.place = @"Library Book Drop";
                                                                      item.imageName = @"GatewayCenter";
                                                                      item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                      
                                                                      
                                                                      // user tapped "Tea Gardon" button in the bottom toolbar
                                                                      [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                      [self.mapAnnotations addObject:item];
                                                                      [self.campusMap addAnnotations:self.mapAnnotations];
                                                                      
                                                                      
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
                                                           
                                                           
                                                           // user tapped "Tea Gardon" button in the bottom toolbar
                                                           [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                           [self.mapAnnotations addObject:item];
                                                           [self.campusMap addAnnotations:self.mapAnnotations];

                                                           
                                                       }];
    
    UIAlertAction* littleTheaterAction = [UIAlertAction actionWithTitle:@"Little Theater" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action) {
                                                                   
                                                                   self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                   [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                   [self.mapAnnotations removeAllObjects];
                                                                   
                                                                   // annotation for Love Library
                                                                   CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                   item.place = @"Little Theater";
                                                                   item.imageName = @"GatewayCenter";
                                                                   item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                   
                                                                   
                                                                   // user tapped "Tea Gardon" button in the bottom toolbar
                                                                   [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                   [self.mapAnnotations addObject:item];
                                                                   [self.campusMap addAnnotations:self.mapAnnotations];
                                                                   
                                                                   
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
                                                                   
                                                                   
                                                                   // user tapped "Tea Gardon" button in the bottom toolbar
                                                                   [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                   [self.mapAnnotations addObject:item];
                                                                   [self.campusMap addAnnotations:self.mapAnnotations];
                                                                   
                                                                   
                                                                   
                                                                   
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
                                                                  
                                                                  
                                                                  // user tapped "Tea Gardon" button in the bottom toolbar
                                                                  [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                  [self.mapAnnotations addObject:item];
                                                                  [self.campusMap addAnnotations:self.mapAnnotations];

                                                                  
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
                                                                  
                                                                  // user tapped "Tea Gardon" button in the bottom toolbar
                                                                  [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                  [self.mapAnnotations addObject:item];
                                                                  [self.campusMap addAnnotations:self.mapAnnotations];
                                                                  
                                                                  
                                                              }];
    
    UIAlertAction* montezumaClassroomsAction = [UIAlertAction actionWithTitle:@"Montezuma Classrooms North/South" style:UIAlertActionStyleDefault
                                                                    handler:^(UIAlertAction * action) {
                                                                        
                                                                        self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                        [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                        [self.mapAnnotations removeAllObjects];
                                                                        
                                                                        // annotation for Love Library
                                                                        CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                        item.place = @"Gateway/KPBS";
                                                                        item.imageName = @"GatewayCenter";
                                                                        item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                        
                                                                        // user tapped "Tea Gardon" button in the bottom toolbar
                                                                        [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                        [self.mapAnnotations addObject:item];
                                                                        [self.campusMap addAnnotations:self.mapAnnotations];
                                                                        
                                                                        
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
                                                                     
                                                                     // user tapped "Tea Gardon" button in the bottom toolbar
                                                                     [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                     [self.mapAnnotations addObject:item];
                                                                     [self.campusMap addAnnotations:self.mapAnnotations];
                                                                     
                                                                     
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
                                                                  
                                                                  // user tapped "Tea Gardon" button in the bottom toolbar
                                                                  [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                  [self.mapAnnotations addObject:item];
                                                                  [self.campusMap addAnnotations:self.mapAnnotations];
                                                                  
                                                                  
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
                                                          
                                                          // user tapped "Viejas Arena" button in the bottom toolbar
                                                          [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                          [self.mapAnnotations addObject:item];
                                                          [self.campusMap addAnnotations:self.mapAnnotations];
                                                          
                                                          
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
                                                                     
                                                                     // user tapped "Viejas Arena" button in the bottom toolbar
                                                                     [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                     [self.mapAnnotations addObject:item];
                                                                     [self.campusMap addAnnotations:self.mapAnnotations];
                                                                     
                                                                     
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
                                                          
                                                          // user tapped "Viejas Arena" button in the bottom toolbar
                                                          [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                          [self.mapAnnotations addObject:item];
                                                          [self.campusMap addAnnotations:self.mapAnnotations];
                                                          
                                                          
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
                                                                       
                                                                       // user tapped "Viejas Arena" button in the bottom toolbar
                                                                       [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                       [self.mapAnnotations addObject:item];
                                                                       [self.campusMap addAnnotations:self.mapAnnotations];
                                                                       
                                                                       
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
                                                                  
                                                                  // user tapped "Viejas Arena" button in the bottom toolbar
                                                                  [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                  [self.mapAnnotations addObject:item];
                                                                  [self.campusMap addAnnotations:self.mapAnnotations];
                                                                  
                                                                  
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
                                                                       
                                                                       // user tapped "Viejas Arena" button in the bottom toolbar
                                                                       [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                       [self.mapAnnotations addObject:item];
                                                                       [self.campusMap addAnnotations:self.mapAnnotations];
                                                                       
                                                                       
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
                                                                 
                                                                 // user tapped "Viejas Arena" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 
                                                                 
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
                                                                          
                                                                          // user tapped "Viejas Arena" button in the bottom toolbar
                                                                          [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                          [self.mapAnnotations addObject:item];
                                                                          [self.campusMap addAnnotations:self.mapAnnotations];
                                                                          
                                                                          
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
                                                                               
                                                                               // user tapped "Viejas Arena" button in the bottom toolbar
                                                                               [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                               [self.mapAnnotations addObject:item];
                                                                               [self.campusMap addAnnotations:self.mapAnnotations];
                                                                               
                                                                               
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
                                                                   
                                                                   // user tapped "Viejas Arena" button in the bottom toolbar
                                                                   [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                   [self.mapAnnotations addObject:item];
                                                                   [self.campusMap addAnnotations:self.mapAnnotations];
                                                                   
                                                                   
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
                                                                     
                                                                     // user tapped "Viejas Arena" button in the bottom toolbar
                                                                     [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                     [self.mapAnnotations addObject:item];
                                                                     [self.campusMap addAnnotations:self.mapAnnotations];
                                                                     
                                                                     
                                                                 }];
    
    UIAlertAction* stormHallAction = [UIAlertAction actionWithTitle:@"Storm Hall" style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                
                                                                self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                [self.mapAnnotations removeAllObjects];
                                                                
                                                                // annotation for Love Library
                                                                CustomAnnotation *item = [[CustomAnnotation alloc] init];
                                                                item.place = @"Gateway/KPBS";
                                                                item.imageName = @"GatewayCenter";
                                                                item.coordinate = CLLocationCoordinate2DMake(32.777003, -117.071654);
                                                                
                                                                // user tapped "Tea Gardon" button in the bottom toolbar
                                                                [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                [self.mapAnnotations addObject:item];
                                                                [self.campusMap addAnnotations:self.mapAnnotations];
                                                                
                                                                
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
                                                                 
                                                                 // user tapped "Viejas Arena" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 
                                                                 
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
                                                                 
                                                                 // user tapped "Viejas Arena" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 
                                                                 
                                                             }];
    
    UIAlertAction* tenochaResHallAction = [UIAlertAction actionWithTitle:@"Tenocha Residence Hall" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      
                                                                      self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                      [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                      [self.mapAnnotations removeAllObjects];
                                                                      
                                                                      // annotation for Love Library
                                                                      CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                      item.place = @"Viejas Arena";
                                                                      item.imageName = @"ViejasArena";
                                                                      item.coordinate = CLLocationCoordinate2DMake(32.773645, -117.07543);
                                                                      
                                                                      // user tapped "Viejas Arena" button in the bottom toolbar
                                                                      [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                      [self.mapAnnotations addObject:item];
                                                                      [self.campusMap addAnnotations:self.mapAnnotations];
                                                                      
                                                                      
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
                                                                     
                                                                     // user tapped "Viejas Arena" button in the bottom toolbar
                                                                     [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                     [self.mapAnnotations addObject:item];
                                                                     [self.campusMap addAnnotations:self.mapAnnotations];
                                                                     
                                                                     
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
                                                                    
                                                                    // user tapped "Viejas Arena" button in the bottom toolbar
                                                                    [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                    [self.mapAnnotations addObject:item];
                                                                    [self.campusMap addAnnotations:self.mapAnnotations];
                                                                    
                                                                    
                                                                }];
    
    UIAlertAction* universityTowerAction = [UIAlertAction actionWithTitle:@"University Tower Residence Hall" style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * action) {
                                                                    
                                                                    self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                    [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                    [self.mapAnnotations removeAllObjects];
                                                                    
                                                                    // annotation for Love Library
                                                                    CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                    item.place = @"Viejas Arena";
                                                                    item.imageName = @"ViejasArena";
                                                                    item.coordinate = CLLocationCoordinate2DMake(32.773645, -117.07543);
                                                                    
                                                                    // user tapped "Viejas Arena" button in the bottom toolbar
                                                                    [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                    [self.mapAnnotations addObject:item];
                                                                    [self.campusMap addAnnotations:self.mapAnnotations];
                                                                    
                                                                    
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
                                                                      
                                                                      // user tapped "Viejas Arena" button in the bottom toolbar
                                                                      [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                      [self.mapAnnotations addObject:item];
                                                                      [self.campusMap addAnnotations:self.mapAnnotations];
                                                                      
                                                                      
                                                                  }];
    
    UIAlertAction* villaAlvaradoAction = [UIAlertAction actionWithTitle:@"Villa Alvarado Residence Hall" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      
                                                                      self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                      [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                      [self.mapAnnotations removeAllObjects];
                                                                      
                                                                      // annotation for Love Library
                                                                      CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                      item.place = @"Viejas Arena";
                                                                      item.imageName = @"ViejasArena";
                                                                      item.coordinate = CLLocationCoordinate2DMake(32.773645, -117.07543);
                                                                      
                                                                      // user tapped "Viejas Arena" button in the bottom toolbar
                                                                      [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                      [self.mapAnnotations addObject:item];
                                                                      [self.campusMap addAnnotations:self.mapAnnotations];
                                                                      
                                                                      
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
                                                                 
                                                                 // user tapped "Viejas Arena" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 
                                                                 
                                                             }];
    
    UIAlertAction* zuraResHallAction = [UIAlertAction actionWithTitle:@"Zura Residence Hall" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
                                                                 [self.campusMap removeAnnotations:self.campusMap.annotations];
                                                                 [self.mapAnnotations removeAllObjects];
                                                                 
                                                                 // annotation for Love Library
                                                                 CustomAnnotation *item= [[CustomAnnotation alloc] init];
                                                                 item.place = @"West Commons (WC)";
                                                                 item.imageName = @"WestCommons";
                                                                 item.coordinate = CLLocationCoordinate2DMake(32.776227, -117.073437);
                                                                 
                                                                 // user tapped "Viejas Arena" button in the bottom toolbar
                                                                 [self gotoByAnnotationClass:[CustomAnnotation class]];
                                                                 [self.mapAnnotations addObject:item];
                                                                 [self.campusMap addAnnotations:self.mapAnnotations];
                                                                 
                                                                 
                                                             }];
    
    
    [alert addAction:administrationAction];
    [alert addAction:adamsHumanitiesAction];
    [alert addAction:ALIAction];
    [alert addAction:aquaplexAction];
    [alert addAction:arenaMeetingCenterAction];
    [alert addAction:artAction];
    [alert addAction:artGalleryAction];
    [alert addAction:artsandLettersAction];
    [alert addAction:aztecAthleticCenterAction];
    [alert addAction:aztecMesaModularsAction];
    [alert addAction:ARCAction];
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
    [alert addAction:departmentofPublicSafetyAction];
    [alert addAction:dramaticArtsAction];
    [alert addAction:educationAction];
    [alert addAction:eduBusAdminAction];
    [alert addAction:engineeringLabAction];
    [alert addAction:eastCommonAction];
    [alert addAction:engineeringAction];
    [alert addAction:exerciseNutritionSciAction];
    [alert addAction:exerciseNutritionSciAnnexAction];
    [alert addAction:facilitiesServicesAction];
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
    [alert addAction:libraryAdditionAction];
    [alert addAction:libraryBookDropAction];
    [alert addAction:lifeSciencesAction];
    [alert addAction:littleTheaterAction];
    [alert addAction:loveLibraryAction];
    [alert addAction:mayaResidenceHallAction];
    [alert addAction:manchesterHallAction];
    [alert addAction:montezumaClassroomsAction];
    [alert addAction:northEducationAction];
    [alert addAction:nasatirHallAction];
    [alert addAction:oatAction];
    [alert addAction:olmecaResHallAction];
    [alert addAction:physicalSciencesAction];
    [alert addAction:publicSafetyAction];
    [alert addAction:universityTowerAction];
    [alert addAction:westCommonAction];
    [alert addAction:nasatirHallAction];
    [alert addAction:parmaAlumniAction];
    [alert addAction:petersonGymAction];
    [alert addAction:physicalSciencesAction];
    [alert addAction:physicsAstroAction];
    [alert addAction:profStudiesFineArtsAction];
    [alert addAction:prospectiveStudentCenterAction];
    [alert addAction:scrippsCottageAction];
    [alert addAction:speechLangAction];
    [alert addAction:stormHallAction];
    [alert addAction:stormHallWestAction];
    [alert addAction:studentServicesAction];
    [alert addAction:tenochaResHallAction];
    [alert addAction:transitCenterAction];
    [alert addAction:tulaCommunityAction];
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
