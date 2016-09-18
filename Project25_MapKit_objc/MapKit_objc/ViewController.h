//
//  ViewController.h
//  MapKit_objc
//
//  Created by Kuan-Wei Lin on 2/25/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CoreLocation/CoreLocation.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate>


@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)currentLocationAction:(id)sender;
- (IBAction)setMap:(id)sender;

- (void)navigateToURL: (NSURL *)mapURL;

@end

