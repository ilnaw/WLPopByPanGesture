//
//  SecondViewController.m
//  WLGesture
//
//  Created by wanli on 17/3/7.
//  Copyright © 2017年 wanli. All rights reserved.
//

#import "SecondViewController.h"
#import "UINavigationController+popGesture.h"
#import "ThirdViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"2";
    
    
    UIButton *push = [UIButton buttonWithType:UIButtonTypeSystem];
    [push setTitle:@"push" forState:UIControlStateNormal];
    [push addTarget:self action:@selector(Push) forControlEvents:UIControlEventTouchUpInside];
    push.frame = CGRectMake(100, 100, 200, 40);
    [self.view addSubview:push];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.popGestureAbled = YES;
}

- (void)Push
{
    ThirdViewController *thirdVC = [[ThirdViewController alloc]init];
    [self.navigationController pushViewController:thirdVC animated:YES];
}


@end
