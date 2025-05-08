//
//  WBMediaView.h
//  WeiboDemo
//
//  Created by joson on 2025/4/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WBImageView;

@interface WBMediaView : UIView

- (void)setImagesWithUrls:(NSArray<NSString *> *)picUrls;
- (CGRect)getFrameFromIndex:(NSInteger)index;
- (void)didTapImageView:(WBImageView *)imageView;

@end

NS_ASSUME_NONNULL_END
