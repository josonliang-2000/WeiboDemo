//
//  WBCollectionView.h
//  WeiboDemo
//
//  Created by joson on 2025/4/29.
//

#import <UIKit/UIKit.h>
#import "WBCollectionViewDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface WBCollectionView : UICollectionView

@property (nonatomic, weak) id<WBCollectionViewDelegate> zoomOutDelegate;

@end

NS_ASSUME_NONNULL_END
