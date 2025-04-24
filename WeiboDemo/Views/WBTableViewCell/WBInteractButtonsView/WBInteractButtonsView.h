//
//  WBInteractButtons.h
//  WeiboDemo
//
//  Created by joson on 2025/4/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WBInteractButton;

@interface WBInteractButtonsView: UIStackView

@property(nonatomic, strong)WBInteractButton *shareBtn;
@property(nonatomic, strong)WBInteractButton *cmmtBtn;
@property(nonatomic, strong)WBInteractButton *likeBtn;

@end

NS_ASSUME_NONNULL_END
