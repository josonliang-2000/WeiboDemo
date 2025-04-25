//
//  WBImageView.m
//  WeiboDemo
//
//  Created by joson on 2025/4/23.
//

#import "WBImageView.h"
#import "WBImageUtils.h"

@interface WBImageView()


- (void)addZoomInTapGesture;
- (void)handleTap;
@end


@implementation WBImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
# pragma mark - override
- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super initWithImage:image]) {
        // 添加tap放大事件
        [self addZoomInTapGesture];
    }
    return self;
}

- (instancetype)initWithIndex:(NSInteger)index {
    if (self = [super init]) {
        _index = index;
        // 添加tap放大事件
        [self addZoomInTapGesture];
    }
    return self;
}

#pragma mark - private methods
- (void)addZoomInTapGesture {
    [self setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapZoomRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self addGestureRecognizer:tapZoomRecognizer];
}

- (void)handleTap {
//    [WBImageUtils zoomInImageOfImageView:self];
    if ([self.delegate respondsToSelector:@selector(didTapImageView:)]) {
        [self.delegate didTapImageView:self];
    }
}
@end
