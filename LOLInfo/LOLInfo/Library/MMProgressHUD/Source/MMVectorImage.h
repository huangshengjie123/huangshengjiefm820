//
//  MMVectorImage.h
//  MMProgressHUD
//
//  Created by Lars Anderson on 2/17/13.
//  Copyright (c) 2013 Mutual Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>//三方库默认没有添加UIKit系统库
typedef NS_ENUM(NSInteger, MMVectorShapeType) {
    MMVectorShapeTypeCheck = 0,
    MMVectorShapeTypeX
};

@interface MMVectorImage : NSObject

+ (UIImage *)vectorImageShapeOfType:(MMVectorShapeType)shapeType
                               size:(CGSize)size
                          fillColor:(UIColor *)fillColor;

@end
