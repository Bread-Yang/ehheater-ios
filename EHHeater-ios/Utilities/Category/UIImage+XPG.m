//
//  UIImage+XPG.m
//  SmartKitchen
//
//  Created by Lin Dan on 13-12-23.
//  Copyright (c) 2013年 danplin. All rights reserved.
//

#import "UIImage+XPG.h"

@implementation UIImage (XPG)

- (UIImage *)resizableImage{
    CGFloat hCenter = self.size.height / 2.0;
    CGFloat wCenter = self.size.width / 2.0;
    UIEdgeInsets insets = UIEdgeInsetsMake(hCenter - 1, wCenter - 1, hCenter, wCenter);
    UIImage *resized = [self resizableImageWithCapInsets:insets];
    return resized;
}

- (UIImage *)centerResizableImage{
    CGFloat wCenter = self.size.width / 2.0;
    UIEdgeInsets insets = UIEdgeInsetsMake(0, wCenter - 1, self.size.height, wCenter);
    UIImage *resized = [self resizableImageWithCapInsets:insets];
    return resized;
}


//修改图片颜色
- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}






+ (UIImage *)imageWithName:(NSString *)name andExtension:(NSString *)extension{
    NSString * scaledName = name;
    
    if ([[UIDevice currentDevice].name hasSuffix:@"Simulator"] || ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)) {
        scaledName = [scaledName stringByAppendingString:@"@2x"];
    }
    
	
	NSString * fullPath = [NSString stringWithFormat:@"%@/%@.%@", [[NSBundle mainBundle] resourcePath], scaledName, extension];
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:fullPath]){
		fullPath = [NSString stringWithFormat:@"%@/%@.%@", [[NSBundle mainBundle] resourcePath], name, extension];
	}
	
	return [UIImage imageWithContentsOfFile:fullPath];
}

+ (UIImage *)imagePNGName:(NSString *)name{
    return [UIImage imageWithName:name andExtension:@"png"];
}

@end
