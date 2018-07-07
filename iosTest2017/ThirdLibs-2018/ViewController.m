//
//  ViewController.m
//  ThirdLibs-2018
//
//  Created by yangzijiang on 2018/5/26.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <Masonry/Masonry.h>

#import <MapKit/MapKit.h>

@interface ViewController ()<MAMapViewDelegate>
@property (strong, nonatomic) MAMapView *mapView;

@property (strong, nonatomic) AMapSearchAPI *search;

/**
 苹果系统自带地图
 */
@property (strong, nonatomic) MKMapView *mkMapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self gaodeMapTest];
    [self MKMapTest];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s", __func__);
    [self pointAnnotation];
}

#pragma mark - AMap高德地图
- (void)gaodeMapTest{
    [self initAMap];
    [self MAPolylineTest];
    [self drawThousandsOfPoint];
    
    [self locationDistance];
}

- (void)initAMap{
    ///初始化地图
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    self.mapView = _mapView;
    self.mapView.delegate = self;
    ///把地图添加至view
    [self.view addSubview:_mapView];
    
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    // 卫星地图
    //    [self.mapView setMapType:MAMapTypeSatellite];
    // 路况图层
    //    self.mapView.showTraffic = YES;
}

/**
 离线地图
 */
- (void)AMapOfflineMap{
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    UIViewController *detailViewController = [MAOfflineMapViewController sharedInstance];
    //    [self.navigationController pushViewController:detailViewController animated:YES];
    //    [self.navigationController presentViewController:detailViewController animated:YES completion:nil];
    [self presentViewController:detailViewController animated:YES completion:nil];
}

#pragma mark -- 绘制点标记
- (void)pointAnnotation{
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街6号";
    
    [_mapView addAnnotation:pointAnnotation];
}


/**
 实现 <MAMapViewDelegate> 协议中的 mapView:viewForAnnotation:回调函数，设置标注样式
 包括当前位置标注点、绘制的标注点
 运行程序，在地图显示对应的标注点，点击标注弹出气泡
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

#pragma mark -- 绘制折线
- (void)MAPolylineTest{
    //构造折线数据对象
    CLLocationCoordinate2D commonPolylineCoords[4];
    commonPolylineCoords[0].latitude = 39.832136;
    commonPolylineCoords[0].longitude = 116.34095;
    
    commonPolylineCoords[1].latitude = 39.832136;
    commonPolylineCoords[1].longitude = 116.42095;
    
    commonPolylineCoords[2].latitude = 39.902136;
    commonPolylineCoords[2].longitude = 116.42095;
    
    commonPolylineCoords[3].latitude = 39.902136;
    commonPolylineCoords[3].longitude = 116.44095;
    
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:4];
    
    //在地图上添加折线对象
    [_mapView addOverlay: commonPolyline];
}


/**
 实现 <MAMapViewDelegate> 协议中的 mapView:rendererForOverlay: 回调函数，设置折线的样式
 */
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
}

#pragma mark -- 绘制海量点图层
- (void)drawThousandsOfPoint{
    ///根据file读取出经纬度数组
    NSString *file = [[NSBundle mainBundle] pathForResource:@"10w" ofType:@"txt"];
    NSString *locationString = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    NSArray *locations = [locationString componentsSeparatedByString:@"\n"];
    
    ///创建MultiPointItems数组，并更新数据
    NSMutableArray *items = [NSMutableArray array];
    
    for (int i = 0; i < locations.count; ++i)
    {
        @autoreleasepool {
            MAMultiPointItem *item = [[MAMultiPointItem alloc] init];
            
            NSArray *coordinate = [locations[i] componentsSeparatedByString:@","];
            
            if (coordinate.count == 2)
            {
                item.coordinate = CLLocationCoordinate2DMake([coordinate[1] floatValue], [coordinate[0] floatValue]);
                
                [items addObject:item];
            }
        }
    }
    
    ///根据items创建海量点Overlay MultiPointOverlay
    MAMultiPointOverlay *_overlay = [[MAMultiPointOverlay alloc] initWithMultiPointItems:items];
    
    ///把Overlay添加进mapView
    [self.mapView addOverlay:_overlay];
}

#pragma mark -- 驾车出行路线规划
- (void)drivingRouteSearch{
//    self.startAnnotation.coordinate = self.startCoordinate;
//    self.destinationAnnotation.coordinate = self.destinationCoordinate;
//
//    AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
//
//    navi.requireExtension = YES;
//    navi.strategy = 5;
//    /* 出发点. */
//    navi.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
//                                           longitude:self.startCoordinate.longitude];
//    /* 目的地. */
//    navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
//                                                longitude:self.destinationCoordinate.longitude];
//
//    [self.search AMapDrivingRouteSearch:navi];
}

#pragma mark -- 距离/面积计算
- (void)locationDistance{
    //1.将两个经纬度点转成投影点
    MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(39.989612,116.480972));
    MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(39.990347,116.480441));
    //2.计算距离
    CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
    NSLog(@"distance = %f", distance);
}

#pragma mark - 苹果自带地图
- (void)MKMapTest{
    [self initMKMap];
}
- (void)initMKMap{
    self.mkMapView = [[MKMapView alloc] init];
    self.mkMapView.delegate = self;
    self.mkMapView.showsBuildings = YES;
    self.mkMapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    self.mkMapView.showsScale = YES;  // 用户缩放地图到一定比例时才显示
    self.mkMapView.showsCompass = YES;  // 用户选择地图时才显示
    self.mkMapView.showsUserLocation = YES;
    self.mkMapView.showsPointsOfInterest = YES;
    [self.view addSubview:self.mkMapView];
    
    [self.mkMapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
@end
