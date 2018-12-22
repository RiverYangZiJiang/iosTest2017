//
//  MKMapViewTestVC.m
//  iosTest2017
//
//  Created by yangzijiang on 2018/12/22.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "MKMapViewTestVC.h"
#import <MapKit/MapKit.h>
#import <Masonry/Masonry.h>

@interface MKMapViewTestVC ()<MKMapViewDelegate>
/**
 苹果系统自带地图视图
 */
@property (strong, nonatomic) MKMapView *mapView;

@end

@implementation MKMapViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    uil
//    self.mapView addGestureRecognizer:<#(nonnull UIGestureRecognizer *)#>
}

- (MKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MKMapView alloc] init];
        
        _mapView.delegate = self;
        _mapView.showsBuildings = YES;
        _mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
        _mapView.showsScale = YES;  // 用户缩放地图到一定比例时才显示
        _mapView.showsCompass = YES;  // 是否显示右上角的指南针
        _mapView.showsUserLocation = YES;  // 显示用户当前位置
        _mapView.showsPointsOfInterest = YES;
        _mapView.mapType = MKMapTypeStandard;  // 地图类型，普通地图
        //设置地图可缩放
        _mapView.zoomEnabled = YES;
        //设置地图可滚动
        _mapView.scrollEnabled = YES;
        NSLog(@"用户当前是否位于地图中：%d", _mapView.userLocationVisible);
    }
    return _mapView;
}

@end
