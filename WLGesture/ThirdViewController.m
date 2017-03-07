//
//  ThirdViewController.m
//  WLGesture
//
//  Created by wanli on 17/3/7.
//  Copyright © 2017年 wanli. All rights reserved.
//

#import "ThirdViewController.h"
#import "UINavigationController+popGesture.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"3";
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.popGestureAbled = NO;
    
    //禁用系统自带
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
@end
