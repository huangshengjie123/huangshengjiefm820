//
//  FindCollectionViewCell.h
//  LOLInfo
//
//  Created by 刘硕 on 16/6/30.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"
@interface FindCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)loadDataFromModel:(FindModel*)model;
@end
