//
//  WBImageViewDelegate.h
//  WeiboDemo
//
//  Created by joson on 2025/4/24.
//

#ifndef WBImageViewDelegate_h
#define WBImageViewDelegate_h

@class WBImageView;
@protocol WBImageViewDelegate <NSObject>
- (void)didTapImageView:(WBImageView *)imageView;

@end
#endif /* WBImageViewDelegate_h */
