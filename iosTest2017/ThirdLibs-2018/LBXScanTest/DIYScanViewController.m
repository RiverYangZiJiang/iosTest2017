//
//  DIYScanViewController.m
//  LBXScanDemo
//
//  Created by lbxia on 2017/6/5.
//  Copyright © 2017年 lbx. All rights reserved.
//

#import "DIYScanViewController.h"
#import "ScanResultViewController.h"


@interface DIYScanViewController ()
/**
 @brief  扫码区域上方提示文字
 */
@property (nonatomic, strong) UILabel *topTitle;
@end

@implementation DIYScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.cameraInvokeMsg = @"相机启动中";
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view addSubview:self.topTitle];
    [self.view bringSubviewToFront:self.topTitle];
}

#pragma mark -实现类继承该方法，作出对应处理

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    if (!array ||  array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //经测试，可以ZXing同时识别2个二维码，不能同时识别二维码和条形码
    //    for (LBXScanResult *result in array) {
    //
    //        NSLog(@"scanResult:%@",result.strScanned);
    //    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //TODO: 这里可以根据需要自行添加震动或播放声音提示相关代码
    //...
    
    [self showNextVCWithScanResult:scanResult];
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {
        
        strResult = @"识别失败";
    }
    
    __weak __typeof(self) weakSelf = self;
//    [LBXAlertAction showAlertWithTitle:@"扫码内容" msg:strResult buttonsStatement:@[@"知道了"] chooseBlock:^(NSInteger buttonIdx) {
    
        [weakSelf reStartDevice];
//    }];
}

- (void)showNextVCWithScanResult:(LBXScanResult*)strResult
{
    ScanResultViewController *vc = [ScanResultViewController new];
    vc.imgScan = strResult.imgScanned;
    
    vc.strScan = strResult.strScanned;
    
    vc.strCodeType = strResult.strBarCodeType;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (UILabel *)topTitle{
    if (!_topTitle) {
        _topTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 40)];
        [_topTitle setText:@"请将条码置于取景框内扫描。"];
        _topTitle.font = [UIFont systemFontOfSize:15];
        _topTitle.numberOfLines = 0;
        [_topTitle setTextColor:[UIColor whiteColor]];
        _topTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _topTitle;
}
@end


