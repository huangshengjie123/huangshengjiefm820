//
//  SqliteManager.h
//  LOLInfo
//
//  Created by 刘硕 on 16/6/29.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface SqliteManager : NSObject

@property (nonatomic,strong) FMDatabase *dataBase;

//单例创建形式 SqliteManger* id shared default standard
+ (instancetype)sharedSqliteManager;
//增加
- (BOOL)insertHeroWithHeroID:(NSString*)heroID;
//查询
- (BOOL)isExistHeroWithHeroID:(NSString*)heroID;

@end
