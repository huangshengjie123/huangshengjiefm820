//
//  HttpRequest.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/27.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest

+ (void)startRequestWithURL:(NSString*)url AndParameter:(NSDictionary*)parameter AndReturnBlock:(void(^)(NSData *data,NSError *error))resultBlock{
    
    //执行网络请求
    //请求队列管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置默认返回类型(NSData)
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //调用get请求
    [manager GET:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //成功
        resultBlock(responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //失败
        resultBlock(nil,error);
        
    }];

}

@end



