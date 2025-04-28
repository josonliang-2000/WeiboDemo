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

@class WBImageView;
@interface WBImageUtils : NSObject

+ (instancetype)shared;
- (UIWindow *)currentWindow;
- (void)zoomInImageOfImageView:(WBImageView *)imageView
              withImageUrlList:(NSArray<NSString *> *)imageUrlList;

@end

NS_ASSUME_NONNULL_END
