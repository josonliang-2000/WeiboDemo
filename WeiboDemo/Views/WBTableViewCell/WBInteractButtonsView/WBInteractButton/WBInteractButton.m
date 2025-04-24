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

- (instancetype)initWithImageName:(NSString *)imgName andNumber:(NSInteger)count {
    self = [self init];
    [_iconView setImage:[UIImage imageNamed:imgName]];
    _name = imgName;
    self.count = count;
    return self;
};

- (void)setCount:(NSInteger)count {
    _count = count;
    self.textLbl.text = [self formattedTextforNumber:_count];
}

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
}

- (void)didTapButton {
    if ([self.name isEqualToString:@"like"]) {
        // 获取服务器的关注状态，若关注中，则+1，否则-1
        if (YES) {
            self.count++;
        } else {
            self.count--;
        }
    }
    NSLog(@"%ld", self.count);
}

- (NSString *)formattedTextforNumber:(NSInteger) num {
    if (num <= 9999) {
        return [NSString stringWithFormat:@"%ld", num];
    } else if (num <= 999 * 10000) {
        return [NSString stringWithFormat:@"%.1lf万", num / 10000.0];
    } else {
        return [NSString stringWithFormat:@"999+万"];
    }
}

@end
