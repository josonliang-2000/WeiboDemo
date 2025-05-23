//
//  WBInteractButton.m
//  WeiboDemo
//
//  Created by joson on 2025/4/21.
//

#import "WBInteractButton.h"
#import "Masonry/Masonry.h"

@interface WBInteractButton()
@property (nonatomic, strong) UIStackView *stackView;

@end

@implementation WBInteractButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - public methods

- (instancetype)initWithImageName:(NSString *)imgName andNumber:(NSInteger)count {
    if(self = [super init]) {
        [self setupUI];
        [self.iconView setImage:[UIImage imageNamed:imgName]];
        self.count = count;
        
        // KVO改变按钮背景色
        [self addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
};

- (void)setCount:(NSInteger)count {
    _count = count;
    self.textLbl.text = [self formattedTextforNumber:_count];
}

#pragma mark - private methods

- (void)setupUI {
    [self addSubview:self.stackView];
    [self setupLayout];
    // for debug
//    [self setBackgroundColor:[UIColor lightGrayColor]];
}


- (void) setupLayout {
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(16);
    }];
    
    [self.textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
    }];
    
    [self.stackView addArrangedSubview:self.iconView];
    [self.stackView addArrangedSubview:self.textLbl];
    
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.mas_equalTo(20);
    }];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"highlighted"]) {
        UIButton *button = (UIButton *)object;
        if (button.highlighted) {
            button.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
        } else {
            button.backgroundColor = [UIColor clearColor];
        }
    }
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

#pragma  mark - getter

- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.userInteractionEnabled = NO;
    }
    return _iconView;
}

- (UILabel *)textLbl {
    if (_textLbl == nil) {
        _textLbl = [[UILabel alloc] init];
        _textLbl.font = [UIFont systemFontOfSize:14];
        _textLbl.userInteractionEnabled = NO;
    }
    return _textLbl;
}

- (UIStackView *)stackView {
    if (_stackView == nil) {
        _stackView = [[UIStackView alloc] init];
        _stackView.userInteractionEnabled = NO;
        _stackView.spacing = 4;
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.alignment = UIStackViewAlignmentCenter;
    }
    return _stackView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}
@end
