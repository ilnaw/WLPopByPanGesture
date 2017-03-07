//
//  ViewController.m
//  WLGesture
//
//  Created by wanli on 17/3/7.
//  Copyright © 2017年 wanli. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *push = [UIButton buttonWithType:UIButtonTypeSystem];
    [push setTitle:@"push" forState:UIControlStateNormal];
    [push addTarget:self action:@selector(Push) forControlEvents:UIControlEventTouchUpInside];
    push.frame = CGRectMake(100, 100, 200, 40);
    [self.view addSubview:push];
    
    self.navigationItem.title = @"1";
}

- (void)Push
{
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:secondVC animated:YES];
}

@end
