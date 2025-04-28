//
//  WBMediaView.m
//  WeiboDemo
//
//  Created by joson on 2025/4/28.
//

#import "WBMediaView.h"
#import "WBImageView.h"
#import "WBTableViewCell.h"
#import "WBImageViewDelegate.h"
#import "SDWebImage/SDWebImage.h"
#import "Masonry/Masonry.h"

@implementation WBMediaView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setImageViews:(NSArray<NSString *> *)picUrls andDelegate:(WBTableViewCell<WBImageViewDelegate> *) delegate {
    const CGFloat spacing = 4;
    const CGFloat kHorizontalMargin = 8;
    
    // 先清空子控件
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 重新计算布局并添加子控件
    NSArray<NSString *> *picsArray = [NSArray arrayWithArray:picUrls];
    if (picsArray.count) {
        const NSInteger picsNum = MIN(9, picsArray.count); // 最多显示9张
        const CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
        NSMutableArray<UIImageView *> *imageViewList = [[NSMutableArray alloc] init];
        
        // 根据行数、列数排布mediaView内的照片，以及约束mediaView的高度
        void(^arrangePicsandLayout)(int, int) = ^(int columns, int rows) {
            CGFloat imageWidth = (cellWidth - spacing * (columns - 1) - kHorizontalMargin * 2) / columns;
            CGFloat imageHeight = imageWidth;
            CGFloat mediaViewH = imageHeight * rows + spacing * (rows - 1);
            for (int i = 0; i < picsNum; i++) {
                // TODO: 封装imageView创建
                WBImageView *imageView = [[WBImageView alloc] initWithIndex:i];
                [imageView sd_setImageWithURL:[NSURL URLWithString:picUrls[i]] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
                imageView.delegate = delegate;
                imageView.frame = CGRectMake((spacing + imageWidth) * (i % columns),
                                             (spacing + imageHeight) * (i / columns),
                                             imageWidth,
                                             imageHeight
                                             );
                
                [self addSubview:imageView];
                
                [imageViewList addObject:imageView];
            }
            // 确定高度
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(mediaViewH);
            }];
        };
        
        if (picsNum >= 4) {
            // 九宫格
            int columns = 3; // 每行3个
            int rows = ceil(1.0 * picsNum / columns); 
            arrangePicsandLayout(columns, rows);
        } else if (picsNum >= 2){
            // 四宫格
            int columns = 2; // 每行2个
            int rows = ceil(1.0 * picsNum / columns);
            arrangePicsandLayout(columns, rows);
        } else {
            // 单张图按比例
            const CGFloat imageWidth = 250.0;
            const CGFloat imageHeight = imageWidth;
            const CGFloat imageX = 0;
            const CGFloat imageY = 0;
            
            WBImageView *imageView = [[WBImageView alloc] initWithIndex: 0];
            imageView.delegate = delegate;
            [imageView sd_setImageWithURL:[NSURL URLWithString:picUrls[0]] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
            // TODO: 能否将下载的图片按照比例绘制到imageView里
            imageView.frame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
            [self addSubview:imageView];
            
            [imageViewList addObject:imageView];
            
            // 确定大小
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(imageHeight);
            }];
        }
        self.hidden = NO;
        delegate.imageViewList = [[NSArray alloc] initWithArray:imageViewList];
    } else {
        self.hidden = YES;
    }
}

@end
