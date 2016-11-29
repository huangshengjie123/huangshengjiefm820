//
//  NewsModel.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/27.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

//重写KVC赋值方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
    if ([key isEqualToString:@"short"]) {
        _shortStr = value;
    }
}

@end
