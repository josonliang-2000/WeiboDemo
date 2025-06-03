//
//  WBPlayerView.h
//  WeiboDemo
//
//  Created by joson on 2025/5/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBPlayerView : UIView

@property (nonatomic, strong) NSURL *videoUrl;

- (instancetype)initWithFrame:(CGRect)frame andUrl:(NSURL *)url;
- (void)play;
- (void)pause;
@end

NS_ASSUME_NONNULL_END
