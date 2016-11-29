//
//  FindModel.h
//  LOLInfo
//
//  Created by 刘硕 on 16/6/30.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindModel : NSObject
//房间id
@property (nonatomic,copy) NSString *room_id;
//图片
@property (nonatomic,copy) NSString *room_src;
//名字
@property (nonatomic,copy) NSString *room_name;
//房主
@property (nonatomic,copy) NSString *nickname;
//在线人数
@property (nonatomic,assign) int online;

@end
