//
//  GeoObject.m
//  面试之道
//
//  Created by 龙格 on 2020/2/5.
//  Copyright © 2020 Paul Gao. All rights reserved.
//

#import "GeoObject.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface GeoObject ()<CLLocationManagerDelegate> {
    CLLocationManager *locationmanager;//定位服务
    CLLocation *currentLocation;
}
@end

@implementation GeoObject

- (instancetype)init {
    self = [super init];
    if (self) {
        [self getLocation];
    }
    return self;
}

-(void)getLocation {
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationmanager = [[CLLocationManager alloc] init];
        locationmanager.delegate = self;
        [locationmanager requestAlwaysAuthorization];
        [locationmanager requestWhenInUseAuthorization];
        
        //设置寻址精度
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        locationmanager.distanceFilter = 5.0;
        [locationmanager startUpdatingLocation];
    }
}

#pragma mark - CLLocationManagerDelegate
//定位失败后调用此代理方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    //设置提示提醒用户打开定位服务
    NSLog(@"定位失败");
}

#pragma mark 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [locationmanager stopUpdatingHeading];
    currentLocation = [locations lastObject];
}


- (void)currentGeocoder {
    NSLog(@"当前位置：%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
}

- (void)reverseGeocoder {
    //反地理编码
//    37.965145,110.988070
    currentLocation = [[CLLocation alloc] initWithLatitude:37.96 longitude:(110.9)];
    
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.6250, 0.6250);
    MKCoordinateRegion region = MKCoordinateRegionMake(currentLocation.coordinate, span);
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    searchRequest.region = region;
    searchRequest.naturalLanguageQuery = @"ATM";
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }else {
            for (MKMapItem *item in response.mapItems) {
                NSLog(@"%@", item.name);
            }
        }
    }];
//    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
//    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//
//        NSLog(@"%zd", placemarks.count);
//        for (CLPlacemark *mark in placemarks) {
//            NSLog(@"%@ %@ %@ %@", mark.country, mark.subLocality, mark.thoroughfare, mark.name);
//        }
//    }];
}

@end
