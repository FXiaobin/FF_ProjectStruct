//
//  UIImageView+CornnerRadius.m
//  ProjectTree
//
//  Created by lovepinyao on 16/9/8.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "UIImageView+CornnerRadius.h"

@implementation UIImageView (CornnerRadius)

-(void)setCornnerRadiusWithImage:(UIImage *)image{
    self.backgroundColor = [UIColor clearColor];
    self.image = [self circleImageWithImage:image];
}

- (UIImage *)circleImageWithImage:(UIImage *)image{
    CGSize imageSize = image.size;
    // 开启图形上下文
    UIGraphicsBeginImageContext(imageSize);
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 矩形框
    CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    // 添加一个圆
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪(裁剪成刚才添加的图形形状)
    CGContextClip(ctx);
    // 往圆上面画一张图片
    [image drawInRect:rect];
    // 获得上下文中的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)cornerRadiusForShareLayerWithImageViewWidth:(CGFloat)imageWidth{
    
    CGRect imageViewRect = CGRectMake(0, 0, imageWidth, imageWidth);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageViewRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(imageWidth, imageWidth)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //设置大小
    maskLayer.frame = imageViewRect;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)cornerRadiusForGraphicsWithImageViewWidth:(CGFloat)imageWidth{
    
    CGRect imageViewRect = CGRectMake(0, 0, imageWidth, imageWidth);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageWidth), NO, 1.0);
    //使用贝塞尔曲线画出一个圆形图
    [[UIBezierPath bezierPathWithRoundedRect:imageViewRect cornerRadius:imageWidth] addClip];
    [self drawRect:imageViewRect];
    
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    //结束画图
    UIGraphicsEndImageContext();
}

@end
