# WLPopByPanGesture
pop by PanGesture

#一句代码实现全屏手势滑动pop

***
根据[J_雨](http://www.jianshu.com/p/d39f7d22db6c)的思路和[sunnyxx](http://blog.sunnyxx.com/2015/06/07/fullscreen-pop-gesture/)的思路进行封装
***
##cocoaPods
```pod 'WLPopByPanGesture'```
***
##使用
	#import "UINavigationController+popGesture.h"
	
	- (void)viewWillAppear:(BOOL)animated
	{
    	[super viewWillAppear:animated];
    	self.navigationController.popGestureAbled = YES;
	}
默认全屏滑动手势关闭，与系统自带边缘滑动返回不冲突。
