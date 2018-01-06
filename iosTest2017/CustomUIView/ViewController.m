//
//  ViewController.m
//  CustomUIView
//
//  Created by yangzijiang on 29/12/2017.
//  Copyright © 2017 yangzijiang. All rights reserved.
//

#import "ViewController.h"
#import "CustomUIView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addCustomUIView];
}


- (void)addCustomUIView {
//    CustomUIView *view = [[CustomUIView alloc] initWithFrame:CGRectMake(10, 20, 40, 80)];
    CustomUIView *view = [[CustomUIView alloc] initWithFrame:self.view.frame];
//    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
}


@end
