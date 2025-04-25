//
//  WBUsrInfoView.m
//  WeiboDemo
//
//  Created by joson on 2025/4/18.
//

#import "WBUsrInfoView.h"
#import "Masonry/Masonry.h"
#import "WBImageView.h"

@implementation WBUsrInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        
        [_followBtn addTarget:self action:@selector(didTapFollowBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)setupUI {
    _avatarView = [[WBImageView alloc] init];
    _nameLbl = [[UILabel alloc] init];
    _vipView = [[UIImageView alloc] init];
    _followBtn = [[UIButton alloc] init];
    
    [self initStyle];
    
    [self addSubview:_avatarView];
    [self addSubview:_nameLbl];
    [self addSubview:_vipView];
    [self addSubview:_followBtn];
    
    [self setupLayout];
}

- (void)initStyle {
    // for debug
//    [_avatarView setBackgroundColor: [UIColor grayColor]];
//    [_nameLbl setBackgroundColor:[UIColor lightGrayColor]];
//    [_vipView setBackgroundColor:[UIColor yellowColor]];
    
    _avatarView.clipsToBounds = YES;
    
    _nameLbl.font = [UIFont systemFontOfSize:14];

    [_vipView setImage:[UIImage imageNamed:@"vip"]];
    
    [_followBtn setBackgroundColor:[UIColor clearColor]];
    _followBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    _followBtn.layer.borderWidth = 1.0;
    _followBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    // TODO: 应该从服务端获取关注状态后更新，否则可重用的cell无法
    [_followBtn setTitle:@"+关注" forState:UIControlStateNormal];
    [_followBtn setTitleColor:[UIColor colorWithRed:230/255.0 green:90/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_followBtn setTitleColor:[UIColor brownColor] forState:UIControlStateHighlighted];

}

- (void)setupLayout {
    // 1. 头像
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.width.height.equalTo(@40);
    }];
    _avatarView.layer.cornerRadius = 20;
    
    // 2. 昵称
    [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarView.mas_right).offset(8);
        make.top.equalTo(_avatarView.mas_top);
        make.height.equalTo(@20);
    }];
    
    // 3. 会员图标
    [_vipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLbl.mas_right).offset(4);
        make.top.equalTo(_nameLbl);
        make.height.width.equalTo(@20);
    }];
    
    // 4. 关注按钮
    [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12);
        make.centerY.equalTo(self);
        make.width.equalTo(@60);
        make.height.equalTo(@28);
    }];
    _followBtn.layer.cornerRadius = 4;
}

#pragma mark - public methods

- (void)setAvatarWithImageName:(NSString *)imgName {
    // TODO: 换成SDImage
    _avatarView.image = [UIImage imageNamed:imgName];
}

- (void)setNameWithName:(NSString *)nickName {
    _nameLbl.text = nickName;
}

- (void)didTapFollowBtn {
    // TODO: 应该从服务端获取关注状态后更新，否则可重用的cell无法
    if ([_followBtn.titleLabel.text isEqualToString:@"+关注"]) {
        [_followBtn setTitle:@"取消关注" forState:UIControlStateNormal];
    } else {
        [_followBtn setTitle:@"+关注" forState:UIControlStateNormal];
    }
}

- (void)displayVip {
    self.vipView.hidden = NO;
}

- (void)hideVip {
    self.vipView.hidden = YES;
}
@end
