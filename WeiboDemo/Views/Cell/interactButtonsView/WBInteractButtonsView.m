//
//  WBInteractButtons.m
//  WeiboDemo
//
//  Created by joson on 2025/4/21.
//

#import "WBInteractButtonsView.h"
#import "WBInteractButton.h"
#import "Masonry/Masonry.h"


@implementation WBInteractButtonsView

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
    }
    return self;
}

- (void)setupUI {
    self.shareBtn = [[WBInteractButton alloc] initWithImageName:@"share" andText:@"430"];
    self.cmmtBtn = [[WBInteractButton alloc] initWithImageName:@"comment" andText:@"1157"];
    self.likeBtn = [[WBInteractButton alloc] initWithImageName:@"like" andText:@"3.8万"];
    [self addArrangedSubview:self.shareBtn];
    [self addArrangedSubview:self.cmmtBtn];
    [self addArrangedSubview:self.likeBtn];
    
    [self setupLayout];
}

- (void)setupLayout {
    self.spacing = 4;
    self.axis = UILayoutConstraintAxisHorizontal; //水平布局
    self.distribution = UIStackViewDistributionFillEqually;
}

@end
