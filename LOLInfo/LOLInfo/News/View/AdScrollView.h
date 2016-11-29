//
//  AdScrollView.h
//  LOLInfo
//
//  Created by 刘硕 on 16/6/28.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdScrollView : UIView

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

- (instancetype)initWithFrame:(CGRect)frame AndPicArr:(NSArray*)picArr;

//声明Block
@property (nonatomic,copy) void(^block)(NSString*);

@end





