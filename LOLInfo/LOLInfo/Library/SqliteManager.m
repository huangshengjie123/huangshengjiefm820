//
//  SqliteManager.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/29.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "SqliteManager.h"

@implementation SqliteManager

+ (instancetype)sharedSqliteManager{
    /*
    static SqliteManager *manager;
    if (manager == nil) {
        manager = [[SqliteManager alloc]init];
    }
    return manager;
     */
    static SqliteManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SqliteManager alloc]init];
    });
    return manager;
}

- (instancetype)init{
    if (self = [super init]) {
        //沙盒路径
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/Hero.db"];
        //创建数据库
        _dataBase = [[FMDatabase alloc]initWithPath:path];
        //判断
        if ([_dataBase open]) {
            NSLog(@"数据库创建成功");
        } else {
            NSLog(@"数据库创建失败");
        }
        //创建表
        NSString *createTable = @"create table if not exists HeroTable (heroID varchar(64))";
        //执行语句
        BOOL isSuc = [_dataBase executeUpdate:createTable];
        if (isSuc) {
            NSLog(@"表创建成功");
        } else {
            NSLog(@"表创建失败");
        }
    }
    return self;
}

- (BOOL)insertHeroWithHeroID:(NSString *)heroID{
    NSString *insertStr = @"insert into HeroTable (heroID) values(?)";
    BOOL isSuc = [_dataBase executeUpdate:insertStr,heroID];
    if (isSuc) {
        NSLog(@"购买成功");
        return YES;
    } else {
        NSLog(@"购买失败");
        return NO;
    }
}

- (BOOL)isExistHeroWithHeroID:(NSString *)heroID{
    NSString *selectStr = @"select * from HeroTable where heroID = ?";
    
    FMResultSet *set = [_dataBase executeQuery:selectStr,heroID];
    //是否可以取得元素
    if ([set next]) {
        NSLog(@"已购买");
        return YES;
    } else {
        NSLog(@"未购买");
        return NO;
    }
}

@end






