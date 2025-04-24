//
//  WBTableViewCell.h
//  WeiboDemo
//
//  Created by joson on 2025/4/18.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class WBCellModel;
@class WBUsrInfoView;
@class WBInteractButtonsView;
@interface WBTableViewCell : UITableViewCell

// 子控件
@property(nonatomic, strong) WBUsrInfoView *usrInfoView;
@property(nonatomic, strong) UILabel *textLbl;
@property(nonatomic, strong) UIView *mediaView;
@property(nonatomic, strong) UILabel *countLbl;
@property(nonatomic, strong) UIView *line;
@property(nonatomic, strong) WBInteractButtonsView *interacButtonsView;
@property(nonatomic, strong) UIView *seperator;

// model
@property(nonatomic, copy)WBCellModel *model;

@end

NS_ASSUME_NONNULL_END
