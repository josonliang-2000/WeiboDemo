//
//  WBImageZoom.h
//  WeiboDemo
//
//  Created by joson on 2025/4/23.
//

/**
 用于放大所点击的ImageView、以及恢复原始大小
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBImageUtils : NSObject

+ (void)zoomInImageOfImageView:(UIImageView *)imageView;
+ (void)zoomOutImageOfTap:(UITapGestureRecognizer *)tap;
+ (UIWindow *)currentWindow;

@end

NS_ASSUME_NONNULL_END
