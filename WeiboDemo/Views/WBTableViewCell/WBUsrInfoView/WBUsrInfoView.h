//
//  WBUsrInfoView.h
//  WeiboDemo
//
//  Created by joson on 2025/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBUsrInfoView : UIView

@property(nonatomic, strong)UIImageView *avatarView;
@property(nonatomic, strong)UILabel *nameLbl;
@property(nonatomic, strong)UIImageView *vipView;
@property(nonatomic, strong)UIButton *followBtn;


- (void)setAvatarWithImageName:(NSString *)imgName;
- (void)setNameWithName:(NSString *)nickName;
- (void)displayVip;
- (void)hideVip;
@end

NS_ASSUME_NONNULL_END
