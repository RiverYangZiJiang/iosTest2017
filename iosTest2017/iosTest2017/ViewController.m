//
//  ViewController.m
//  iosTest2017
//
//  Created by yangzijiang on 2017/2/16.
//  Copyright © 2017年 yangzijiang. All rights reserved.
//

#import "ViewController.h"
#import "UITableViewControllerTest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self presentViewController:[[UITableViewControllerTest alloc] init] animated:YES completion:nil];
}

@end
