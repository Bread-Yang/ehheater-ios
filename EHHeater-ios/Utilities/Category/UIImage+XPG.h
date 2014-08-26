//
//  UIImage+XPG.h
//  SmartKitchen
//
//  Created by Lin Dan on 13-12-23.
//  Copyright (c) 2013年 danplin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XPG)

//可拉伸图片
- (UIImage *)resizableImage;
- (UIImage *)centerResizableImage;

//颜色修改
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

//图片读取
+ (UIImage *)imageWithName:(NSString *)name andExtension:(NSString *)extension;
+ (UIImage *)imagePNGName:(NSString *)name;

@end
