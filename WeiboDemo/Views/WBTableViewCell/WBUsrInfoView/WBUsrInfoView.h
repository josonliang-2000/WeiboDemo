//
//  WBUsrInfoView.h
//  WeiboDemo
//
//  Created by joson on 2025/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WBImageView;
@interface WBUsrInfoView : UIView

@property (nonatomic, strong) WBImageView *avatarView;
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UIImageView *vipView;
@property (nonatomic, strong) UIButton *followBtn;

@end

NS_ASSUME_NONNULL_END
