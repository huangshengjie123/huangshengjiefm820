//
//  DetailModel.h
//  LOLInfo
//
//  Created by 刘硕 on 16/6/29.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject
/*
 [NSCFNumber Length] 报错 检查数据模型类型
 */
@property (nonatomic,copy) NSString *img_top;//头部视图
@property (nonatomic,copy) NSString *background;//背景故事
@property (nonatomic,copy) NSString *analyse;//使用技巧
@property (nonatomic,copy) NSString *talent_desc;//对线技巧
@property (nonatomic,strong) NSArray *skill;//英雄技能数组

@end

