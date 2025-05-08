//
//  WBUICollectionViewDelegate.h
//  WeiboDemo
//
//  Created by joson on 2025/4/29.
//

#ifndef WBUICollectionViewDelegate_h
#define WBUICollectionViewDelegate_h

@protocol WBZoomOutDelegate <NSObject>

- (CGRect)getFrameFromIndex:(NSInteger)index;
@end
#endif /* WBUICollectionViewDelegate_h */
