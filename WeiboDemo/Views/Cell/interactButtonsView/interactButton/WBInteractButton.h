//
//  WBInteractButton.h
//  WeiboDemo
//
//  Created by joson on 2025/4/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//TODO: 改成内部的titleLabel、imageView
@interface WBInteractButton : UIButton
@property(nonatomic, strong)UIImageView *iconView;
@property(nonatomic, strong)UILabel *textLbl;
@property(nonatomic, strong)UIStackView *stackView;

- (instancetype)initWithImageName:(NSString *)imgName andText:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
