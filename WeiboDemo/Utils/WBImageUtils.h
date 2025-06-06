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

@class WBMediaView;
@class WBImageView;

@protocol WBZoomOutDelegate;

@interface WBImageUtils : NSObject

+ (instancetype)shared;
- (UIWindow *)currentWindow;
- (void)zoomInImageOfImageView:(WBImageView *)imageView
                OfImageUrlList:(NSArray<NSString *> *)imageUrlList
               zoomOutDelegate:(id<WBZoomOutDelegate>) zoomOutDelegate;

@end

NS_ASSUME_NONNULL_END
