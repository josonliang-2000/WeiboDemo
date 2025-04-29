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

#pragma mark public methods

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        [self.followBtn addTarget:self action:@selector(didTapFollowBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


# pragma mark private methods

- (void)setupUI {
    [self addSubview:self.avatarView];
    [self addSubview:self.nameLbl];
    [self addSubview:self.vipView];
    [self addSubview:self.followBtn];
    
    [self setupLayout];
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

- (void)didTapFollowBtn {
    self.followBtn.selected = !self.followBtn.selected;
    // 修改数据库的值
}

#pragma mark - getter

- (WBImageView *)avatarView {
    if (_avatarView == nil) {
        _avatarView = [[WBImageView alloc] init];
        _avatarView.clipsToBounds = YES;
    }
    return _avatarView;
}

- (UILabel *)nameLbl {
    if (_nameLbl == nil) {
        _nameLbl = [[UILabel alloc] init];
        _nameLbl.font = [UIFont systemFontOfSize:14];
    }
    return _nameLbl;
}

- (UIImageView *)vipView {
    if (_vipView == nil) {
        _vipView = [[UIImageView alloc] init];
        [_vipView setImage:[UIImage imageNamed:@"vip"]];
    }
    return _vipView;
}

- (UIButton *)followBtn {
    if (_followBtn == nil) {
        _followBtn = [[UIButton alloc] init];
        [_followBtn setBackgroundColor:[UIColor clearColor]];
        _followBtn.layer.borderWidth = 1.0;
        self.followBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _followBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_followBtn setTitle:@"+关注" forState:UIControlStateNormal];
        [_followBtn setTitle:@"✓已关注" forState:UIControlStateSelected];
        
        [_followBtn setTitleColor:[UIColor colorWithRed:230/255.0 green:90/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_followBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    }
    return _followBtn;
}

@end
