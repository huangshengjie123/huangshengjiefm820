//
//  HeroModel.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/28.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "HeroModel.h"

@implementation HeroModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}

@end
