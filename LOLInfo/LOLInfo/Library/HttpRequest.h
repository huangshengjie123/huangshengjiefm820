//
//  HttpRequest.h
//  LOLInfo
//
//  Created by 刘硕 on 16/6/27.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface HttpRequest : NSObject
//返回值类型 (^) (参数类型)
//外漏方法 传入网址参数返回数据
//(void(^)(NSData *data,NSError *error))
+ (void)startRequestWithURL:(NSString*)url AndParameter:(NSDictionary*)parameter AndReturnBlock:(void(^)(NSData *data,NSError *error))resultBlock;

@end
