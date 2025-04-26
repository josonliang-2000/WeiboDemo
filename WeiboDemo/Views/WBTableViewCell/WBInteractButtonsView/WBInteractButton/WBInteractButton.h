//
//  WBInteractButton.h
//  WeiboDemo
//
//  Created by joson on 2025/4/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface WBInteractButton : UIButton

@property(nonatomic, strong)UIImageView *iconView;
@property(nonatomic, strong)UILabel *textLbl;
@property(nonatomic, assign)NSInteger count;
@property(nonatomic, readonly)NSString *name;

- (instancetype)initWithImageName:(NSString *)imgName andNumber:(NSInteger)number;

@end

NS_ASSUME_NONNULL_END
