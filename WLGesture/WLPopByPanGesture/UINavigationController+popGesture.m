//
//  UINavigationController+pop.m
//  WLGesture
//
//  Created by wanli on 17/3/7.
//  Copyright © 2017年 wanli. All rights reserved.
//

#import "UINavigationController+popGesture.h"
#import <objc/runtime.h>

static char gestureAssociatedObjectKey;
static char delegateAssociatedObjectKey;
static char popGestureAbleAssociatedObjectKey;

@interface WLPopGestureDelegate : NSObject<UIGestureRecognizerDelegate>
@property (weak, nonatomic)UINavigationController *navigationController;
@end

@implementation WLPopGestureDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //栈中只有一个vc,不执行手势
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    //开关
    if (!self.navigationController.popGestureAbled) {
        return NO;
    }
    
    return YES;
}

@end




@implementation UINavigationController (popGesture)

+(void)load
{
    //交换系统的pushViewController:animated:
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL pushOriginalSelector = @selector(pushViewController:animated:);
        SEL pushNowSelector       = @selector(wl_pushViewController:animated:);
        
        Method pushOriginalMethod = class_getInstanceMethod([self class], pushOriginalSelector);
        Method pushNowMethod      = class_getInstanceMethod([self class], pushNowSelector);
        
        method_exchangeImplementations(pushOriginalMethod, pushNowMethod);
        
    });
}
//重写push方法 给push的目标controller 拦截系统自带的边缘返回手势 把该手势的响应添加到当前的整个view
- (void)wl_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //手势的targets中存在了该手势时不重复添加
    self.popGestureAbled = NO;
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    if (![gesture.view.gestureRecognizers containsObject:self.popGestureRecongizer]) {
        
        NSMutableArray *targets = [gesture valueForKey:@"_targets"];
        
        id gestureTarget = [targets firstObject];
        
        id firstGestureTarget = [gestureTarget valueForKey:@"_target"];
        
        
        SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
        
        [self.popGestureRecongizer addTarget:firstGestureTarget action:handleTransition];
        
        //设置代理
        self.popGestureRecongizer.delegate = self.popDelegate;
        
        //添加到整个响应的view
        [gesture.view addGestureRecognizer:self.popGestureRecongizer];
    }

    if (![self.viewControllers containsObject:viewController]) {
        [self wl_pushViewController:viewController animated:YES];
    }
    
}

/**
 滑动手势代理getter

 @return delegate
 */
- (WLPopGestureDelegate *)popDelegate
{
    WLPopGestureDelegate *delegate = objc_getAssociatedObject(self, &delegateAssociatedObjectKey);
    if (!delegate) {
        delegate = [[WLPopGestureDelegate alloc]init];
        delegate.navigationController = self;
        
        objc_setAssociatedObject(self, &delegateAssociatedObjectKey, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}

/**
 手势getter

 @return gesture
 */
- (UIPanGestureRecognizer *)popGestureRecongizer
{
    UIPanGestureRecognizer *popGesture = objc_getAssociatedObject(self, &gestureAssociatedObjectKey);
    if (!popGesture) {
        popGesture = [[UIPanGestureRecognizer alloc]init];
        
        objc_setAssociatedObject(self, &gestureAssociatedObjectKey, popGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return popGesture;
}
- (BOOL)popGestureAbled
{
    return [objc_getAssociatedObject(self, &popGestureAbleAssociatedObjectKey) boolValue];
}
- (void)setPopGestureAbled:(BOOL)popGestureAbled
{
    objc_setAssociatedObject(self, &popGestureAbleAssociatedObjectKey, @(popGestureAbled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
