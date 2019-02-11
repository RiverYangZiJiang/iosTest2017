//
//  LBXScanTestVC.m
//  ThirdLibs-2018
//
//  Created by 杨子江 on 1/25/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "LBXScanTestVC.h"
#import "LBXScanViewStyle.h"
#import "DIYScanViewController.h"
#import "StyleDIY.h"

@interface LBXScanTestVC ()

@end

@implementation LBXScanTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self recoCropRect];
}

#pragma mark -框内区域识别
- (void)recoCropRect
{
    DIYScanViewController *vc = [DIYScanViewController new];
    vc.libraryType = SLT_ZXing;
    vc.style = [LBXScanTestVC recoCropRect];
    vc.scanCodeType = SCT_QRCode;
    //开启只识别框内
    vc.isOpenInterestRect = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -框内区域识别
+ (LBXScanViewStyle*)recoCropRect
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.colorAngle = [UIColor whiteColor];
    style.photoframeLineW = 2;
    style.photoframeAngleW = 24;
    style.photoframeAngleH = 24;
    style.isNeedShowRetangle = YES;
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    //矩形框离左边缘及右边缘的距离
    style.xScanRetangleOffset = 80;
    
//    style.animationImage = [StyleDIY createImageWithColor:[UIColor redColor]];
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    
    return style;
}


@end
