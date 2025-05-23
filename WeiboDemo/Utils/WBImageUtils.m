//
//  WBImageZoom.m
//  WeiboDemo
//
//  Created by joson on 2025/4/23.
//

#import "WBImageUtils.h"
#import "WBImageView.h"
#import "SDWebImage/SDWebImage.h"
#import "WBMediaView.h"
#import "WBZoomOutDelegate.h"


@interface WBImageUtils()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, copy) NSArray<NSString *> *imageUrlList;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) CGRect screenFrame;
@property (nonatomic, weak) id<WBZoomOutDelegate> zoomOutDelegate;

@end

@implementation WBImageUtils

#pragma  mark - public methods
+ (instancetype)shared {
    static WBImageUtils *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WBImageUtils alloc] init];
    });
    return instance;
}

- (void)zoomInImageOfImageURLList:(WBImageView *)imageView OfImageUrlList:(NSArray<NSString *> *)imageUrlList zoomOutDelegate:(id<WBZoomOutDelegate>) zoomOutDelegate {
    // 1. 初始化数据
    UIWindow *currentWindow = [self currentWindow];
    self.currentIndex = imageView.index;
    self.imageUrlList = imageUrlList;
    self.zoomOutDelegate = zoomOutDelegate;
    
    // 2. 获取imageView全局frame
    const CGRect originFrame = [imageView convertRect:imageView.bounds toView:currentWindow];
    
    // 3. 创建临时的imageView用于动画
    UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:originFrame];
    tempImageView.image = imageView.image;
    tempImageView.contentMode = UIViewContentModeScaleAspectFill; // 防止拉伸
    tempImageView.clipsToBounds = YES;
    
    // 4. 动画依托黑色背景
    [self.backgroundView addSubview:tempImageView];
    [currentWindow addSubview: self.backgroundView];
    
    // 5. 播放放大动画
    [UIView animateWithDuration:0.3 animations:^{
        tempImageView.frame = [self getZoommedInFrameOfImage:tempImageView.image];
     } completion:^(BOOL finished) {
         [tempImageView removeFromSuperview];
         [self.backgroundView removeFromSuperview];
        
         // 6. 动画完成后显示CollectionView
         [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
         [currentWindow addSubview:self.collectionView];
     }];
}

- (UIWindow *)currentWindow {
    UIWindow *currentWindow;
    if (@available(iOS 13.0, *)) {
        // 从已连接的Scene中获取第一个活跃的窗口
        for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive) {
                currentWindow = scene.windows.firstObject;
                break;
            }
        }
    } else {
        currentWindow = [UIApplication sharedApplication].keyWindow;
    }
    return currentWindow;
}

#pragma mark - private methods

- (void)zoomOutImageOfImageView {
    // collectionView离屏
    [self.collectionView removeFromSuperview];
    
    // 处理缩小动画
    if ([self.zoomOutDelegate respondsToSelector:@selector(getFrameFromIndex:)]) {
        CGRect dstFrame = [self.zoomOutDelegate getFrameFromIndex:self.currentIndex];
        
        // 取出当前cell的imageView
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        UIImageView *imageView = cell.contentView.subviews.firstObject;
        
        // 创建临时的imageView用于动画
        UIImageView *tempImageView = [[UIImageView alloc] initWithImage:imageView.image];
        
        // 需要手动计算imageView中图片的frame
        tempImageView.frame = [self getZoommedInFrameOfImage:imageView.image];
        tempImageView.contentMode = UIViewContentModeScaleAspectFill;
        tempImageView.clipsToBounds = YES;
        
        // 展现临时的imageView
        UIWindow *currentWindow = [self currentWindow];
        [self.backgroundView addSubview:tempImageView];
        [currentWindow addSubview:self.backgroundView];
        
        // 播放缩小动画
        [UIView animateWithDuration:0.3 animations:^{
            tempImageView.frame = dstFrame;
        }completion:^(BOOL finished) {
            [tempImageView removeFromSuperview];
            [self.backgroundView removeFromSuperview];
        }];
    }
    self.collectionView = nil;
}

// 返回图片全屏放大之后的frame
- (CGRect)getZoommedInFrameOfImage:(UIImage *)image {
    CGFloat imageH = image.size.height;
    CGFloat imageW = image.size.width;
    CGFloat heightToWidth = imageH / imageW;
    
    CGFloat screenH = self.screenFrame.size.height;
    CGFloat screenW = self.screenFrame.size.width;
    
    CGFloat dstH = screenW * heightToWidth;
    
    // 屏幕宽为图片宽
    CGFloat dstX = 0;
    CGFloat dstY = (screenH - dstH) / 2.0;
    return CGRectMake(dstX, dstY, screenW, dstH);
}

#pragma mark getter

- (UIView *)backgroundView {
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
    }
    return _backgroundView;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        // 创建collection布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = self.screenFrame.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.screenFrame collectionViewLayout:layout];
        _collectionView .backgroundColor = [UIColor grayColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (CGRect)screenFrame {
    return [UIScreen mainScreen].bounds;
}

# pragma mark - collection view data source & delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageUrlList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    // 移除旧的ImageView
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    // load imageView
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.screenFrame];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrlList[indexPath.item]] placeholderImage: [UIImage imageNamed:@"image_placeholder"]];
        
//    NSLog(@"现在是第%ld个cell，图片url为：%@", indexPath.item, self.imageUrlList[indexPath.item]);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor blackColor];
    [cell.contentView addSubview:imageView];
    
    return cell;
}

// 实时更新self.currentIndex
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat centerX = scrollView.contentOffset.x + CGRectGetWidth(scrollView.frame) / 2.0;
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(centerX, 0)];
    
    self.currentIndex = indexPath.item;
//    NSLog(@"---------现在是第%ld张图片", self.currentIndex);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self zoomOutImageOfImageView];
}
@end
