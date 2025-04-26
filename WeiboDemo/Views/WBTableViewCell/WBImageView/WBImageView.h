//
//  WBImageView.h
//  WeiboDemo
//
//  Created by joson on 2025/4/23.
//

#import <UIKit/UIKit.h>
#import "WBImageViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface WBImageView : UIImageView

@property (nonatomic, readonly) NSInteger index;
@property (nonatomic, weak) id<WBImageViewDelegate> delegate;

- (instancetype)initWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
