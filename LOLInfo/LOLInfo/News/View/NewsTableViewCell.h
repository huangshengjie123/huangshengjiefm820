//
//  NewsTableViewCell.h
//  LOLInfo
//
//  Created by 刘硕 on 16/6/27.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface NewsTableViewCell : UITableViewCell
//图片
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//详情
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;


- (void)loadDataFromModel:(NewsModel*)model;

@end
