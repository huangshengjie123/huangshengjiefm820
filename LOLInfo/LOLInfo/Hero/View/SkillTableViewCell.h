//
//  SkillTableViewCell.h
//  LOLInfo
//
//  Created by 刘硕 on 16/6/29.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkillTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *cdLabel;

@property (weak, nonatomic) IBOutlet UILabel *costLabel;

- (void)loadDataFromArr:(NSArray*)skillArr;

@end
