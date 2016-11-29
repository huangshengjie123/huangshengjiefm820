//
//  RecommModel.h
//  LOLInfo
//
//  Created by 刘硕 on 16/6/28.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "article_id": "292303",
 "comment_count": 2,
 "ban_img": "http%3A%2F%2Fuserimg.shiwan.com%2Fuploads%2Fmanage%2F44%2Fe5%2F1c6c710f3e8f598a37030604bddae4bf7a81.jpg",
 "name": "\u65b0\u82f1\u96c4\uff1a\u201c\u6d77\u517d\u796d\u53f8 \u4fc4\u6d1b\u4f0a\u201d \u6b63\u5f0f\u767b\u573a"
 */
@interface RecommModel : NSObject

@property (nonatomic,copy) NSString *article_id;
@property (nonatomic,copy) NSString *ban_img;
@property (nonatomic,copy) NSString *name;

@end
