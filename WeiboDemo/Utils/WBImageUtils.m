//
//  WBImageZoom.m
//  WeiboDemo
//
//  Created by joson on 2025/4/23.
//

#import "WBImageUtils.h"

@implementation WBImageUtils

typedef NS_ENUM(NSInteger, WBViewTag) {
    WBViewTagOfTempBackgroundView = 19999,
    WBViewTagOfTempImageView
};

static CGRect kOriginFrame; // 

+ (void)zoomInImageOfImageView:(UIImageView *)imageView {
    // 1. 获取当前窗口和图片
    UIWindow *currentWindow = [self currentWindow];
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    UIImage *image = imageView.image;
    
    // 2. 获取imageView全局坐标
    kOriginFrame = [imageView convertRect:imageView.bounds toView:currentWindow];
    
    // 3.创建黑色背景
    UIView *tempBackgroundView = [[UIView alloc] initWithFrame:screenFrame];
    tempBackgroundView.backgroundColor = [UIColor blackColor]; // 黑色
    tempBackgroundView.alpha = 0; // 初始透明
    tempBackgroundView.tag = WBViewTagOfTempBackgroundView;
    
    // 3. 创建临时的imageView
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:image];
    tempImageView.frame = kOriginFrame;
    tempImageView.tag = WBViewTagOfTempImageView;
    [tempBackgroundView addSubview:tempImageView];
    
    // 给临时的backgroundView绑定tap事件，处理缩小
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOfZoommedInImage:)];
    [tempBackgroundView addGestureRecognizer:tap];
    
//    // 给临时的backgroundView绑定左滑
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipeOfZoomedInImage:)];
    [tempBackgroundView addGestureRecognizer:leftSwipe];
//    
//    // 右滑事件
//    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipeOfZoomedInImage:)];
//    [tempBackgroundView addGestureRecognizer:rightSwipe];

    [currentWindow addSubview:tempBackgroundView];

    // 4. 放大动画
    [UIView animateWithDuration:0.4 animations:^{
        CGFloat imageW = screenFrame.size.width;
        CGFloat imageH = image.size.height / image.size.width * imageW;
        tempImageView.frame = CGRectMake(0, (screenFrame.size.height - imageH) / 2, imageW, imageH);
        tempBackgroundView.alpha = 1;
    }];
    
    
}

+ (void)handleTapOfZoommedInImage:(UITapGestureRecognizer *)tap {
    UIView *tappedView = tap.view;
    
    // 找出临时创建的View
    UIView *tempImageView = [tappedView viewWithTag:WBViewTagOfTempImageView];
    // 缩小动画
    [UIView animateWithDuration:0.4 animations: ^{
        tempImageView.frame = kOriginFrame;
    } completion:^(BOOL finished) {
        [tappedView removeFromSuperview];
    }];
}

+ (void)handleLeftSwipeOfZoomedInImage:(UISwipeGestureRecognizer *)leftSwipe {
    UIView *tappedView = leftSwipe.view;
    UIView *tempImageView = [tappedView viewWithTag:WBViewTagOfTempImageView];

    // 左滑动画
    [UIView animateWithDuration:0.4 animations:^ {
//        CGFloat dstX = kOriginFrame
    }];
    
}

+ (void)handleRightSwipeOfZoomedInImage:(UISwipeGestureRecognizer *)rightSwipe {
    
}

+ (UIWindow *)currentWindow {
    UIWindow *currentWindow;
    if (@available(iOS 13.0, *)) {
        // 从已连接的Scene中获取第一个活跃的窗口
        for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive) {
                currentWindow = scene.windows.firstObject;
                break;
            }
        }
    } else {
        currentWindow = [UIApplication sharedApplication].keyWindow;
    }
    return currentWindow;
}



@end
