//
//  WBMediaView.h
//  WeiboDemo
//
//  Created by joson on 2025/4/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WBTableViewCell;
@class WBImageView;

@protocol WBImageViewDelegate;
@protocol WBCollectionViewDelegate;

@interface WBMediaView : UIView<WBCollectionViewDelegate, WBImageViewDelegate>

- (void)setImagesWithUrls:(NSArray<NSString *> *)picUrls;
- (CGRect)getFrameFromIndex:(NSInteger)index;
- (void)didTapImageView:(WBImageView *)imageView;

@end

NS_ASSUME_NONNULL_END
