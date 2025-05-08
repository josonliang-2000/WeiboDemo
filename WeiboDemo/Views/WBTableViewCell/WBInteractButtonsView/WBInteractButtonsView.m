//
//  WBInteractButtons.m
//  WeiboDemo
//
//  Created by joson on 2025/4/21.
//

#import "WBInteractButtonsView.h"
#import "WBInteractButton.h"
#import "Masonry/Masonry.h"
#import "WBViewController.h"
#import "WBCommentViewController.h"

@implementation WBInteractButtonsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma  mark - public methods

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        
        [self.shareBtn addTarget:self action:@selector(didTapShareButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.cmmtBtn addTarget:self action:@selector(didTapCmmtButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.likeBtn addTarget:self action:@selector(didTapLikeButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma  mark - private methods

- (void)setupUI {
    self.shareBtn = [[WBInteractButton alloc] initWithImageName:@"share" andNumber:38000];
    self.cmmtBtn = [[WBInteractButton alloc] initWithImageName:@"comment" andNumber:1157];
    self.likeBtn = [[WBInteractButton alloc] initWithImageName:@"like" andNumber:999];
    [self addArrangedSubview:self.shareBtn];
    [self addArrangedSubview:self.cmmtBtn];
    [self addArrangedSubview:self.likeBtn];
    
    [self setupLayout];
}

- (void)setupLayout {
    self.axis = UILayoutConstraintAxisHorizontal; //水平布局
    self.distribution = UIStackViewDistributionFillEqually;
}

- (void)didTapShareButton:(WBInteractButton *)sender {
    NSLog(@"did tap %@", sender);
}

- (void)didTapCmmtButton:(WBInteractButton *)sender {
    // 1. 通过响应链找到所在的视图控制器
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[WBViewController class]]) {
            WBViewController *currenntVC = (WBViewController *)responder;
            
            // 2. 创建评论区
            WBCommentViewController *commentVC = [[WBCommentViewController alloc] init];
            
            // 3. 通过导航控制器跳转
            [currenntVC.navigationController pushViewController:commentVC animated:YES];
            break;
        }
    }
}

- (void)didTapLikeButton:(WBInteractButton *)sender {
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        [sender.iconView setImage:[UIImage imageNamed:@"liked"]];
        sender.count++;
    } else {
        [sender.iconView setImage:[UIImage imageNamed:@"like"]];
        sender.count--;
    }
}

@end
