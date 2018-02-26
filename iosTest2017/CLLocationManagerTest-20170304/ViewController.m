//
//  ViewController.m
//  CLLocationManagerTest-20170304
//
//  Created by yangzijiang on 2017/3/4.
//  Copyright © 2017年 yangzijiang. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@property (strong) CLLocationManager *locationManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // 如此设置之后，每隔一秒钟被调用一次
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    
    [self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
}


- (IBAction)startDownload:(id)sender {
}
/**
 每隔一秒钟被调用一次

 @param manager <#manager description#>
 @param locations CLLocation数组
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    NSLog(@"%s currentLocation = %@", __func__, currentLocation);
    // 根据经纬度反向得出位置城市信息 http://m.blog.csdn.net/article/details?id=46788567
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            NSString *currentCity = placeMark.locality;
            if (!currentCity) {
                NSLog(@"%@", NSLocalizedString(@"home_cannot_locate_city", comment:@"无法定位当前城市"));
            }
        }
     }];
}


@end
