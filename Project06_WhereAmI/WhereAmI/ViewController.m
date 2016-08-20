//
//  ViewController.m
//  WhereAmI
//
//  Created by Kuan-Wei Lin on 8/13/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"
#import "CoreLocation/CoreLocation.h"

@interface ViewController () <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *myLocationLabel;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)findMyLocationAction:(UIButton *)sender {
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    self.myLocationLabel.text = [NSString stringWithFormat:@"Error while updating location = %@", error.localizedDescription];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:manager.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        if (error != nil) {
            self.myLocationLabel.text = [NSString stringWithFormat:@"Reverse geocoder failed with error = %@", error.description];
        }
        
        if (placemarks.count > 0) {
            CLPlacemark *pm = placemarks[0];
            [self displayLocationInfo:pm];
        }else{
            self.myLocationLabel.text = @"Problem with the data received from geocoder";
        }
    }];
}

- (void)displayLocationInfo:(CLPlacemark *)placeMark{
    
    [_locationManager stopUpdatingLocation];
    
    NSString *locality = (placeMark.locality != nil) ? placeMark.locality : @"";
    NSString *postalCode = (placeMark.postalCode != nil) ? placeMark.postalCode : @"";
    NSString *administrativeArea = (placeMark.administrativeArea != nil) ? placeMark.administrativeArea : @"";
    
    NSString *country = (placeMark.country != nil) ? placeMark.country : @"";
    
    NSLog(@"locality = %@", locality);
    NSLog(@"postalCode = %@", postalCode);
    NSLog(@"administrativeArea = %@", administrativeArea);
    NSLog(@"country = %@", country);
    
    self.myLocationLabel.text = [NSString stringWithFormat:@"%@%@%@%@", locality, postalCode, administrativeArea, country];
}

@end
