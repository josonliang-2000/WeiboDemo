//
//  WBTableViewCell.h
//  WeiboDemo
//
//  Created by joson on 2025/4/18.
//

#import <UIKit/UIKit.h>
#import "WBImageViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@class WBCellModel;
@interface WBTableViewCell : UITableViewCell<WBImageViewDelegate>

// model
@property(nonatomic, copy)WBCellModel *model;

@end

NS_ASSUME_NONNULL_END
