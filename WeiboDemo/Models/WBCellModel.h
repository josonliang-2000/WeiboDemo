//
//  ZSWeiboModel.h
//  WeiboDemo
//
//  Created by joson on 2025/4/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBCellModel : NSObject

@property (nonatomic, assign, readonly) NSInteger id;
@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy, readonly) NSArray<NSString *> *pic;
@property (nonatomic, copy, readonly) NSString *video;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) BOOL isVip;
@property (nonatomic, copy, readonly) NSString *avatar;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
