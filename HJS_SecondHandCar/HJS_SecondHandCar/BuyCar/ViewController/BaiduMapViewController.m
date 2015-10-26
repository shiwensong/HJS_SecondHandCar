//
//  BaiduMapViewController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-26.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "BaiduMapViewController.h"
#import <BaiduMapAPI/BMapKit.h>

#import <MapKit/MapKit.h>



@interface BaiduMapViewController () <BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    IBOutlet BMKMapView *_mapView;
    BMKLocationService* _locService;
}
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation BaiduMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    _locService = [[BMKLocationService alloc]init];

    [self startLocation];
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}

-(void)updateLocationData:(BMKUserLocation*)userLocation{
    
    NSLog(@"userlocation ==%@",userLocation.location);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}


#pragma mark - Private

- (void)startLocation{
    
    NSLog(@"进入普通定位态");
    [_locService startUserLocationService];
    _mapView.showsUserLocation = YES;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
}


- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
}

- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

#pragma mark - BMKMapViewDelegate







@end
