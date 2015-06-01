//
//  KCView3.m
//  自制美图秀秀
//
//  Created by lanou3g on 15/6/1.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "KCView3.h"
#define TILE_SIZE 20
@implementation KCView3


- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
#pragma mark -- 线性渐变
//    [self drawLinearGradient:context];
#pragma  mark -- 径向渐变
//    [self drawRadialGradient:context];
#pragma mark --渐变填充
//   [self drawRectWithLinearGradientFill:context];
#pragma mark --叠加模式
    [self drawRectByUIKitWithContext2:context];
#pragma mark -- 填充模式
    [self drawBackgroundWithColoredPattern:context];
//  [self drawBackgroundWithPattern:context];
    
    
}

//pragma mark -- 线性渐变
- (void)drawLinearGradient:(CGContextRef)context{
    
    //如果颜色空间使用RGB则数组中的元素四个为一组，分别是red（红）、green（绿）、blue（蓝）、alpha（透明度）；如果使用CMYK颜色空间，那么数组中的元素五个为一组，分别是cyan（青）、magenta（洋红）、yellow（黄）、black（黑）、alpha（透明度）。
    
    //使用rgb颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3] = {0,0.3,1.0};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    /*绘制线性渐变
     context:图形上下文
     gradient:渐变色
     startPoint:起始位置
     endPoint:终止位置
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
     */
    CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(320, 300), kCGGradientDrawsAfterEndLocation);
    
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);

}

//pragma  mark -- 径向渐变
- (void)drawRadialGradient:(CGContextRef)context{
    
    //使用rgb颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    /*绘制径向渐变
     context:图形上下文
     gradient:渐变色
     startCenter:起始点位置
     startRadius:起始半径（通常为0，否则在此半径范围内容无任何填充）
     endCenter:终点位置（通常和起始点相同，否则会有偏移）
     endRadius:终点半径（也就是渐变的扩散长度）
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，但是到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，但到结束点之后继续填充
     */
    CGContextDrawRadialGradient(context, gradient, CGPointMake(160, 284),0, CGPointMake(165, 289), 150, kCGGradientDrawsAfterEndLocation);
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
    
    
    
    
    
}

//pragma mark --渐变填充
-(void)drawRectWithLinearGradientFill:(CGContextRef)context{
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    //裁切处一块矩形用于显示，注意必须先裁切再调用渐变
    //CGContextClipToRect(context, CGRectMake(20, 50, 280, 300));
    //裁切还可以使用UIKit中对应的方法
    UIRectClip(CGRectMake(20, 50, 280, 300));
    
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    CGContextDrawLinearGradient(context, gradient, CGPointMake(20, 50), CGPointMake(300, 300), kCGGradientDrawsAfterEndLocation);
    
    
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
}

//pragma mark --叠加模式
-(void)drawRectByUIKitWithContext2:(CGContextRef)context{
    CGRect rect= CGRectMake(0, 130.0, 320.0, 50.0);
    CGRect rect1= CGRectMake(0, 390.0, 320.0, 50.0);
    
    
    CGRect rect2=CGRectMake(20, 50.0, 10.0, 250.0);
    CGRect rect3=CGRectMake(40.0, 50.0, 10.0, 250.0);
    CGRect rect4=CGRectMake(60.0, 50.0, 10.0, 250.0);
    CGRect rect5=CGRectMake(80.0, 50.0, 10.0, 250.0);
    CGRect rect6=CGRectMake(100.0, 50.0, 10.0, 250.0);
    CGRect rect7=CGRectMake(120.0, 50.0, 10.0, 250.0);
    CGRect rect8=CGRectMake(140.0, 50.0, 10.0, 250.0);
    CGRect rect9=CGRectMake(160.0, 50.0, 10.0, 250.0);
    CGRect rect10=CGRectMake(180.0, 50.0, 10.0, 250.0);
    CGRect rect11=CGRectMake(200.0, 50.0, 10.0, 250.0);
    CGRect rect12=CGRectMake(220.0, 50.0, 10.0, 250.0);
    CGRect rect13=CGRectMake(240.0, 50.0, 10.0, 250.0);
    CGRect rect14=CGRectMake(260.0, 50.0, 10.0, 250.0);
    CGRect rect15=CGRectMake(280.0, 50.0, 10.0, 250.0);
    
    CGRect rect16=CGRectMake(30.0, 310.0, 10.0, 250.0);
    CGRect rect17=CGRectMake(50.0, 310.0, 10.0, 250.0);
    CGRect rect18=CGRectMake(70.0, 310.0, 10.0, 250.0);
    CGRect rect19=CGRectMake(90.0, 310.0, 10.0, 250.0);
    CGRect rect20=CGRectMake(110.0, 310.0, 10.0, 250.0);
    CGRect rect21=CGRectMake(130.0, 310.0, 10.0, 250.0);
    CGRect rect22=CGRectMake(150.0, 310.0, 10.0, 250.0);
    CGRect rect23=CGRectMake(170.0, 310.0, 10.0, 250.0);
    CGRect rect24=CGRectMake(190.0, 310.0, 10.0, 250.0);
    CGRect rect25=CGRectMake(210.0, 310.0, 10.0, 250.0);
    CGRect rect26=CGRectMake(230.0, 310.0, 10.0, 250.0);
    CGRect rect27=CGRectMake(250.0, 310.0, 10.0, 250.0);
    CGRect rect28=CGRectMake(270.0, 310.0, 10.0, 250.0);
    CGRect rect29=CGRectMake(290.0, 310.0, 10.0, 250.0);
    
    
    [[UIColor yellowColor]set];
    UIRectFill(rect);
    
    [[UIColor greenColor]setFill];
    UIRectFill(rect1);
    
    [[UIColor redColor]setFill];
    UIRectFillUsingBlendMode(rect2, kCGBlendModeClear);
    UIRectFillUsingBlendMode(rect3, kCGBlendModeColor);
    UIRectFillUsingBlendMode(rect4, kCGBlendModeColorBurn);
    UIRectFillUsingBlendMode(rect5, kCGBlendModeColorDodge);
    UIRectFillUsingBlendMode(rect6, kCGBlendModeCopy);
    UIRectFillUsingBlendMode(rect7, kCGBlendModeDarken);
    UIRectFillUsingBlendMode(rect8, kCGBlendModeDestinationAtop);
    UIRectFillUsingBlendMode(rect9, kCGBlendModeDestinationIn);
    UIRectFillUsingBlendMode(rect10, kCGBlendModeDestinationOut);
    UIRectFillUsingBlendMode(rect11, kCGBlendModeDestinationOver);
    UIRectFillUsingBlendMode(rect12, kCGBlendModeDifference);
    UIRectFillUsingBlendMode(rect13, kCGBlendModeExclusion);
    UIRectFillUsingBlendMode(rect14, kCGBlendModeHardLight);
    UIRectFillUsingBlendMode(rect15, kCGBlendModeHue);
    UIRectFillUsingBlendMode(rect16, kCGBlendModeLighten);
    
    UIRectFillUsingBlendMode(rect17, kCGBlendModeLuminosity);
    UIRectFillUsingBlendMode(rect18, kCGBlendModeMultiply);
    UIRectFillUsingBlendMode(rect19, kCGBlendModeNormal);
    UIRectFillUsingBlendMode(rect20, kCGBlendModeOverlay);
    UIRectFillUsingBlendMode(rect21, kCGBlendModePlusDarker);
    UIRectFillUsingBlendMode(rect22, kCGBlendModePlusLighter);
    UIRectFillUsingBlendMode(rect23, kCGBlendModeSaturation);
    UIRectFillUsingBlendMode(rect24, kCGBlendModeScreen);
    UIRectFillUsingBlendMode(rect25, kCGBlendModeSoftLight);
    UIRectFillUsingBlendMode(rect26, kCGBlendModeSourceAtop);
    UIRectFillUsingBlendMode(rect27, kCGBlendModeSourceIn);
    UIRectFillUsingBlendMode(rect28, kCGBlendModeSourceOut);
    UIRectFillUsingBlendMode(rect29, kCGBlendModeXOR);
}

//pragma mark -- 填充模式
    //pragma mark - 有颜色填充模式
void drawColoredTile(void *info,CGContextRef context){
    //有颜色填充，这里设置填充色
    CGContextSetRGBFillColor(context, 254.0/255.0, 52.0/255.0, 90.0/255.0, 1);
    CGContextFillRect(context, CGRectMake(0, 0, TILE_SIZE, TILE_SIZE));
    CGContextFillRect(context, CGRectMake(TILE_SIZE, TILE_SIZE, TILE_SIZE, TILE_SIZE));
}
-(void)drawBackgroundWithColoredPattern:(CGContextRef)context{
    //设备无关的颜色空间
    //    CGColorSpaceRef rgbSpace= CGColorSpaceCreateDeviceRGB();
    //模式填充颜色空间,注意对于有颜色填充模式，这里传NULL
    CGColorSpaceRef colorSpace=CGColorSpaceCreatePattern(NULL);
    //将填充色颜色空间设置为模式填充的颜色空间
    CGContextSetFillColorSpace(context, colorSpace);
    
    //填充模式回调函数结构体
    CGPatternCallbacks callback={0,&drawColoredTile,NULL};
    /*填充模式
     info://传递给callback的参数
     bounds:瓷砖大小
     matrix:形变
     xStep:瓷砖横向间距
     yStep:瓷砖纵向间距
     tiling:贴砖的方法
     isClored:绘制的瓷砖是否已经指定了颜色(对于有颜色瓷砖此处指定位true)
     callbacks:回调函数
     */
    CGPatternRef pattern=CGPatternCreate(NULL, CGRectMake(0, 0, 2*TILE_SIZE, 2*TILE_SIZE), CGAffineTransformIdentity,2*TILE_SIZE+ 5,2*TILE_SIZE+ 5, kCGPatternTilingNoDistortion, true, &callback);
    
    CGFloat alpha=1;
    //注意最后一个参数对于有颜色瓷砖指定为透明度的参数地址，对于无颜色瓷砖则指定当前颜色空间对应的颜色数组
    CGContextSetFillPattern(context, pattern, &alpha);
    
    UIRectFill(CGRectMake(30, 30, 320, 568));
    
    //    CGColorSpaceRelease(rgbSpace);
    CGColorSpaceRelease(colorSpace);
    CGPatternRelease(pattern);
}


#pragma mark - 无颜色填充模式
//填充瓷砖的回调函数（必须满足CGPatternCallbacks签名）
void drawTile(void *info,CGContextRef context){
    CGContextFillRect(context, CGRectMake(0, 0, TILE_SIZE, TILE_SIZE));
    CGContextFillRect(context, CGRectMake(TILE_SIZE, TILE_SIZE, TILE_SIZE, TILE_SIZE));
}
-(void)drawBackgroundWithPattern:(CGContextRef)context{
    //设备无关的颜色空间
    CGColorSpaceRef rgbSpace= CGColorSpaceCreateDeviceRGB();
    //模式填充颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreatePattern(rgbSpace);
    //将填充色颜色空间设置为模式填充的颜色空间
    CGContextSetFillColorSpace(context, colorSpace);
    
    //填充模式回调函数结构体
    CGPatternCallbacks callback={0,&drawTile,NULL};
    /*填充模式
     info://传递给callback的参数
     bounds:瓷砖大小
     matrix:形变
     xStep:瓷砖横向间距
     yStep:瓷砖纵向间距
     tiling:贴砖的方法（瓷砖摆放的方式）
     isClored:绘制的瓷砖是否已经指定了颜色（对于无颜色瓷砖此处指定位false）
     callbacks:回调函数
     */
    CGPatternRef pattern=CGPatternCreate(NULL, CGRectMake(0, 0, 2*TILE_SIZE, 2*TILE_SIZE), CGAffineTransformIdentity,2*TILE_SIZE+ 5,2*TILE_SIZE+ 5, kCGPatternTilingNoDistortion, false, &callback);
    
    CGFloat components[]={254.0/255.0,52.0/255.0,90.0/255.0,1.0};
    //注意最后一个参数对于无颜色填充模式指定为当前颜色空间颜色数据
    CGContextSetFillPattern(context, pattern, components);
    //    CGContextSetStrokePattern(context, pattern, components);
    UIRectFill(CGRectMake(0, 0, 320, 568));
    
    CGColorSpaceRelease(rgbSpace);
    CGColorSpaceRelease(colorSpace);
    CGPatternRelease(pattern);
}


@end
