//
//  WBImageZoom.m
//  WeiboDemo
//
//  Created by joson on 2025/4/23.
//

#import "WBImageUtils.h"
#import "WBImageView.h"
#import "SDWebImage/SDWebImage.h"

@interface WBImageUtils()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, copy) NSArray<NSString *> *imageUrlList;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) CGRect screenFrame;

- (void)handleTapOfZoommedInImage:(UITapGestureRecognizer *)tap;

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

- (void)zoomInImageOfImageView:(WBImageView *)imageView withImageUrlList:(NSArray<NSString *> *)imageUrlList {
    // 1. 初始化数据
    UIWindow *currentWindow = [self currentWindow];
    self.currentIndex = imageView.index;
    self.imageUrlList = imageUrlList;
    
    // 2. 获取imageView全局frame
    const CGRect originFrame = [imageView convertRect:imageView.bounds toView:currentWindow];
    
    // 3.黑色背景设置为透明
    self.backgroundView.alpha = 0;
    
    // 4. 创建临时的imageView用于动画
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_placeholder"]];
    tempImageView.frame = originFrame;
    [self.backgroundView addSubview:tempImageView];
    
    // 5. 给collectionView添加点击事件，处理缩小
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOfZoommedInImage:)];
    [self.collectionView addGestureRecognizer:tap];
    
    [currentWindow addSubview:self.backgroundView];

    // 7. 播放放大动画
    [UIView animateWithDuration:0.4 animations:^{
        tempImageView.frame = self.collectionView.frame;
        tempImageView.contentMode = UIViewContentModeScaleAspectFit;
         self.backgroundView.alpha = 1;
     } completion:^(BOOL finished) {
         [tempImageView removeFromSuperview];
         [self.backgroundView removeFromSuperview];
         // 动画完成后显示CollectionView
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

- (void)handleTapOfZoommedInImage:(UITapGestureRecognizer *)tap {
    // collectionView离屏并清空cell
    [self.collectionView removeFromSuperview];
    self.collectionView = nil;
    
//    // 取出九宫格的那个imageView
//    UIImageView *imageView = self.imageViewList[self.currentIndex];
//    // 创建临时tempImageView
//    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:imageView.image];
//    tempImageView.frame = self.collectionView.frame;
//    tempImageView.contentMode = UIViewContentModeScaleAspectFit;
//    // 加入到backgroundView
//    [self.backgroundView addSubview:tempImageView];
//    // 显示backgroundView
//    UIWindow *currentWindow = [self currentWindow];
//    [currentWindow addSubview:self.backgroundView];
//    
//    // 播放缩小动画
//    [UIView animateWithDuration:0.4 animations:^ {
//        tempImageView.frame = [imageView convertRect:imageView.bounds toView:currentWindow];
//        self.backgroundView.alpha = 0;
//    } completion:^(BOOL finished) {
//        [tempImageView removeFromSuperview];
//        [self.backgroundView removeFromSuperview];
//    }];
    
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
@end
