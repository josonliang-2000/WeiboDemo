//
//  WBInteractButton.m
//  WeiboDemo
//
//  Created by joson on 2025/4/21.
//

#import "WBInteractButton.h"
#import "Masonry/Masonry.h"

@implementation WBInteractButton

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
        [self addTarget:self action:@selector(didTapButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithImageName:(NSString *)imgName andText:(NSString *)text  {
    self = [self init];
    [_iconView setImage:[UIImage imageNamed:imgName]];
    _textLbl.text = text;
//    [self setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
//    [self setTitle:text forState:UIControlStateNormal];
    return self;
};

- (void)setupUI {
    _iconView = [[UIImageView alloc] init];
    _textLbl = [[UILabel alloc] init];
    _stackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    [self addSubview:_stackView];
    
    [self initStyle];
    [self setupLayout];
    // for debug
//    [self setBackgroundColor:[UIColor lightGrayColor]];
}

- (void) initStyle {
    _textLbl.font = [UIFont systemFontOfSize:14];
    // TODO: 了解组件的事件传递链
    _textLbl.userInteractionEnabled = NO;
    _iconView.userInteractionEnabled = NO;
    _stackView.userInteractionEnabled = NO;
//    self.titleLabel.font = [UIFont systemFontOfSize:14];
    
}

- (void) setupLayout {
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@16);
    }];
    
    [_textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@16);
        make.width.equalTo(@50);
    }];
    
    _stackView.spacing = 4;
    _stackView.axis = UILayoutConstraintAxisHorizontal;
    _stackView.distribution = UIStackViewDistributionFillProportionally;
    [_stackView addArrangedSubview:_iconView];
    [_stackView addArrangedSubview:_textLbl];
    
    [_stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
    }];
    
//    // 先确保按钮自身有最小尺寸
//      [self mas_makeConstraints:^(MASConstraintMaker *make) {
//          make.width.greaterThanOrEqualTo(@60); // 最小宽度
//          make.height.greaterThanOrEqualTo(@30); // 最小高度
//      }];
//    
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.height.width.equalTo(@16);
//    }];
//    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.imageView.mas_right).offset(4);
//        make.height.equalTo(@16);
//        make.width.equalTo(@50);
//    }];
    
}

- (void)didTapButton {
    NSLog(@"did tap the %@ button", self.iconView);
}



@end
