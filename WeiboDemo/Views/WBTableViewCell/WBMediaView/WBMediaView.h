//
//  WBMediaView.h
//  WeiboDemo
//
//  Created by joson on 2025/4/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WBTableViewCell;
@protocol WBImageViewDelegate;

@interface WBMediaView : UIView

- (void)setImageViews:(NSArray<NSString *> *)picUrls andImagesDelegate:(WBTableViewCell<WBImageViewDelegate> *) delegate;

@end

NS_ASSUME_NONNULL_END
