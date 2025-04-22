//
//  ZSWeiboModel.m
//  WeiboDemo
//
//  Created by joson on 2025/4/18.
//

#import "WBCellModel.h"

@implementation WBCellModel


- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}
@end

