//
//  KCView2.m
//  自制美图秀秀
//
//  Created by lanou3g on 15/6/1.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "KCView2.h"

@implementation KCView2

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
#pragma mark -- 绘制图形上下文形变
    [self drawImage2:context];
    [self drawImage:context];
    
}
//pragma mark -- 绘制图形上下文形变
- (void)drawImage:(CGContextRef)context{
    //保存初始状态
    CGContextSaveGState(context);
    
    // 形变第一步:图形上下文向右平移40
    CGContextTranslateCTM(context, 100, 0);
    
    // 形变第二步:缩放0.8
    CGContextScaleCTM(context, 0.8, 0.8);
    
    // 形变第三步:旋转
    CGContextRotateCTM(context, M_PI_4/4);
    
    UIImage *image = [UIImage imageNamed:@"girl.jpg"];
    [image drawInRect:CGRectMake(220, 50, 240, 300)];
    
    //恢复到初始状态
    CGContextRestoreGState(context);
    
}


//使用Core Graphics绘制图像
- (void)drawImage2:(CGContextRef)context{
    
    //在前面基本绘图部分，绘制图像时使用了UIKit中封装的方法进行了图像绘制，我们不妨看一下使用Quartz 2D内置方法绘制是什么效果。
    UIImage *image = [UIImage imageNamed:@"girl.jpg"];
    //绘制图像
    CGRect rect = CGRectMake(10, 150, 300, 450);
//    CGContextDrawImage(context, rect, image.CGImage);
    
    /*!
     *  @author 朝夕
     *
     *  @brief  运行结果看起来整个图像是倒过来的，原因正是前面说的：在Core Graphics中坐标系的y轴正方向是向上的，坐标原点在屏幕左下角，y轴方向刚好和UIKit中y轴方向相反。而使用UIKit进行绘图之所以没有问题是因为UIKit中进行了处理，事实上对于其他图形即使使用Core Graphics绘制也没有问题，因为UIKit统一了编程方式。但是使用Core Graphics中内置方法绘制图像是存在这种问题的，如何解决呢？
     其实图形上下文只要沿着x轴旋转180度，然后向上平移适当的高度即可（但是注意不要沿着z轴旋转，这样得不到想要的结果）。可是通过前面介绍的CGContextRotateCTM方法只能通过沿着z轴旋转，此时不妨使用另外一种方法，那就是在y轴方向缩放-1，同样可以达到想要的效果：
    
     */
    
    CGSize size = [UIScreen mainScreen].bounds.size ;
    CGContextSaveGState(context);
    CGFloat height =450, y = 100;
    
    //上下文变形
    CGContextScaleCTM(context, 1.0, -1.0);// 在Y轴缩放-1相当于沿着X轴旋转180
    CGContextTranslateCTM(context, 0, -(size.height-(size.height-2*y-height)));//向上平移
    //图像绘制
    CGRect rect1= CGRectMake(10, y, 300, height);
    CGContextDrawImage(context, rect1, image.CGImage);
    
    CGContextRestoreGState(context);
    
}

@end
