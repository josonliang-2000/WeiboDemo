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
#import "WBImageUtils.h"
#import "WBImageViewDelegate.h"
#import "WBZoomOutDelegate.h"
#import "WBPlayerView.h"

@interface WBMediaView()<WBZoomOutDelegate, WBImageViewDelegate>

@property (nonatomic, strong) NSMutableArray<WBImageView *> *imageViews;
@property (nonatomic, strong) NSArray<NSString *> *picUrls;
@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, strong) WBPlayerView *playerView;

@end

@implementation WBMediaView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - public
- (void)setImagesWithUrls:(NSArray<NSString *> *)picUrls {
    self.picUrls = picUrls;
    // 先清空数据
    [self clearData];
    
    const CGFloat spacing = 4;
    // 重新计算布局并添加子控件
    NSArray<NSString *> *picsArray = [NSArray arrayWithArray:picUrls];
    if (picsArray.count) {
        const NSInteger picsNum = MIN(9, picsArray.count); // 最多显示9张
        const BOOL isNeedOverlay = picsArray.count > 9;
        
        // 根据行数、列数排布mediaView内的照片，以及约束mediaView的高度
        void(^arrangePicsandLayout)(int, int) = ^(int columns, int rows) {
            CGFloat imageWidth = (self.contentWidth - spacing * (columns - 1)) / columns;
            CGFloat imageHeight = imageWidth;
            CGFloat mediaViewH = imageHeight * rows + spacing * (rows - 1);
            for (int i = 0; i < picsNum; i++) {
                WBImageView *imageView = [[WBImageView alloc] initWithIndex:i];
                [imageView sd_setImageWithURL:[NSURL URLWithString:picUrls[i]]];
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                imageView.clipsToBounds = YES;
                imageView.delegate = self;
                imageView.frame = CGRectMake((spacing + imageWidth) * (i % columns),
                                             (spacing + imageHeight) * (i / columns),
                                             imageWidth,
                                             imageHeight
                                             );
                
                if (i == 8 && isNeedOverlay) {
                    // 添加遮罩
                    [self addOverlayFor:imageView withNum:picsArray.count - 9];
                }
                
                [self addSubview:imageView];
                [self.imageViews addObject:imageView];
                
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
            
            WBImageView *imageView = [[WBImageView alloc] initWithIndex: 0];
            imageView.delegate = self;
            [imageView sd_setImageWithURL:[NSURL URLWithString:picUrls[0]]];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.frame = CGRectMake(0, 0, imageWidth, imageHeight);
            
            [self addSubview:imageView];
            [self.imageViews addObject:imageView];

            // 确定大小
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(imageHeight);
            }];
        }
        self.hidden = NO;
    } else {
        self.hidden = YES;
    }
}

- (void)setVideoWithUrl:(NSString *)videoUrl {
    [self clearData];
    
    const CGFloat height = self.contentWidth / 16 * 9;
    CGRect frame = CGRectMake(0, 0, self.contentWidth, height);
    WBPlayerView *playerView = [[WBPlayerView alloc] initWithFrame:frame andUrl:[NSURL URLWithString:videoUrl]];
    [self addSubview:playerView];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
}

#pragma mark - private

- (void)clearData {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.imageViews removeAllObjects];
}

- (void)addOverlayFor:(UIImageView *)imageView withNum:(NSInteger)remainCount {
    // 创建黑色遮罩
    UIView *overlay = [[UIView alloc] initWithFrame:imageView.bounds];
    overlay.backgroundColor = [[UIColor alloc] initWithWhite:0 alpha:0.5];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:overlay.bounds];
    countLabel.text = [NSString stringWithFormat:@"+%ld", remainCount];
    countLabel.textColor = [UIColor whiteColor];
    countLabel.font = [UIFont boldSystemFontOfSize:38];
    countLabel.textAlignment = NSTextAlignmentCenter;
    
    [overlay addSubview:countLabel];
    [imageView addSubview:overlay];
}


#pragma mark - get

- (NSMutableArray<WBImageView *> *)imageViews {
    if (_imageViews == nil) {
        _imageViews = [[NSMutableArray alloc] init];
    }
    return _imageViews;
}

- (CGFloat)contentWidth {
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat kMarginX = 8.0f;
    return cellWidth - kMarginX * 2;
}

#pragma  mark - WBImageViewDelegate

- (void)didTapImageView:(WBImageView *)imageView {
    [[WBImageUtils shared] zoomInImageOfImageView:imageView OfImageUrlList:self.picUrls zoomOutDelegate:self];
}

#pragma  mark - WBZoomOutDelegate

- (CGRect)getImageFrameFromIndex:(NSInteger)index {
    WBImageView *imageView = self.imageViews[index];
    return [imageView convertRect:imageView.bounds toView:[[WBImageUtils shared] currentWindow]];
}
@end
