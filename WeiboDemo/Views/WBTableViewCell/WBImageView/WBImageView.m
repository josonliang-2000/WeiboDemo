//
//  WBImageView.m
//  WeiboDemo
//
//  Created by joson on 2025/4/23.
//

#import "WBImageView.h"
#import "WBImageUtils.h"

@implementation WBImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super initWithImage:image]) {
        // 添加tap放大事件
        [self addZoomInTapGesture];
    }
    return self;
}


- (void)addZoomInTapGesture {
    [self setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapZoomRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanZoommedImage)];
    [self addGestureRecognizer:tapZoomRecognizer];
}

- (void)scanZoommedImage {
    [WBImageUtils zoomInImageOfImageView:self];
}
@end
