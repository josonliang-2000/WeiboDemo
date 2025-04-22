//
//  ZSWeiboModel.h
//  WeiboDemo
//
//  Created by joson on 2025/4/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBCellModel : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSArray<NSString *> *pic;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign, getter=isVip) BOOL vip;
@property (nonatomic, copy) NSString *avatar;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
