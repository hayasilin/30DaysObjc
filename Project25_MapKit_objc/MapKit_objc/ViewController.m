//
//  ViewController.m
//  MapKit_objc
//
//  Created by Kuan-Wei Lin on 2/25/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
{
    CLLocationManager *locationManager;
}
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    locationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    [locationManager requestWhenInUseAuthorization]; // Add This Line
    
    self.mapView.showsUserLocation = YES;
    self.mapView.showsBuildings = YES;
    self.mapView.showsPointsOfInterest = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)currentLocationAction:(id)sender {
    MKUserLocation *location = self.mapView.userLocation;
    MKCoordinateRegion region;
    region.center = location.coordinate;
    region = MKCoordinateRegionMakeWithDistance(region.center, 1000, 1000);
    
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)setMap:(id)sender {
    
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:{
            self.mapView.mapType = MKMapTypeStandard;
            break;
        }
        case 1:{
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        }
        case 2:{
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        }
        default:
            break;
    }
}

- (IBAction)shareLocationAction:(id)sender {
    MKUserLocation *location = self.mapView.userLocation;
    CLLocationCoordinate2D coord = location.location.coordinate;
    
    NSString *str = [NSString stringWithFormat:@"mymap://%f,%f", coord.latitude, coord.longitude];
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[str] applicationActivities:nil];
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (void)navigateToURL: (NSURL *)mapURL{
    NSCharacterSet *separator = [NSCharacterSet characterSetWithCharactersInString:@":/,"];
    NSArray *comps = [mapURL.absoluteString componentsSeparatedByCharactersInSet:separator];
    if (comps.count < 5) {
        return;
    }
    
    double latitude = [comps[3] doubleValue];
    double longitude = [comps[4] doubleValue];
    
    CLLocationCoordinate2D destCoord = CLLocationCoordinate2DMake(latitude, longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(destCoord, 800, 800);
    [self.mapView setRegion:region animated:YES];
    
    //加入目的地的紅圓圈使其明顯(但無法拉近地圖至指定範圍)
    /*
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:destCoord radius:10.0];
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView addOverlay:circle level:MKOverlayLevelAboveRoads];
    [self.mapView setCenterCoordinate:destCoord animated:YES];
     */
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = destCoord;
    
    [self.mapView addAnnotation:point];
    
    [self requestNavigationToDestinationCoord:destCoord];
}

- (MKOverlayRenderer *)mapView: (MKMapView *)mapView rendererForOverlay:(nonnull id<MKOverlay>)overlay{
    if ([overlay isKindOfClass:[MKCircle class]]) {
        MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithCircle:overlay];
        renderer.strokeColor = [UIColor colorWithRed:1.0 green:0.231 blue:0.188 alpha:1.0];
        return renderer;
    }else if ([overlay isKindOfClass:[MKPolyline class]]){
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc]initWithPolyline:overlay];
        renderer.strokeColor = [UIColor colorWithRed:0 green:0.478 blue:1.0 alpha:0.65];
        return renderer;
    }
    return nil;
}

- (void)requestNavigationToDestinationCoord: (CLLocationCoordinate2D)destCoord{
    CLLocationCoordinate2D sourceCoord = self.mapView.userLocation.location.coordinate;
    MKPlacemark *sourcePlacemark = [[MKPlacemark alloc] initWithCoordinate:sourceCoord addressDictionary:nil];
    MKPlacemark *destPlacemark = [[MKPlacemark alloc] initWithCoordinate:destCoord addressDictionary:nil];
    
    MKDirectionsRequest *request = [MKDirectionsRequest new];
    request.transportType = MKDirectionsTransportTypeWalking;
    request.source = [[MKMapItem alloc]initWithPlacemark:sourcePlacemark];
    request.destination = [[MKMapItem alloc]initWithPlacemark:destPlacemark];
    MKDirections *directions = [[MKDirections alloc]initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        double midLat = (sourceCoord.latitude + destCoord.latitude) / 2.0;
        double midLong = (sourceCoord.longitude + destCoord.longitude) / 2.0;
        CLLocationCoordinate2D midCoord = CLLocationCoordinate2DMake(midLat, midLong);
        CLLocation *sourceLoc = [[CLLocation alloc]initWithLatitude:sourceCoord.latitude longitude:sourceCoord.longitude];
        CLLocation *destLoc = [[CLLocation alloc]initWithLatitude:destCoord.latitude longitude:destCoord.longitude];
        CLLocationDistance distance = [destLoc distanceFromLocation:sourceLoc];
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(midCoord, distance + 100, distance + 100);
        [self.mapView setRegion:region animated:YES];
        
        for (MKRoute *route in response.routes) {
            [self.mapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        }
    }];
}

- (IBAction)findIt:(id)sender {
    [self navigateToURL:[NSURL URLWithString:@"mymap://25.067162,121.578216"]];
    
}


@end
