//
//  ViewController.m
//  自制美图秀秀
//
//  Created by lanou3g on 15/5/31.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "ViewController.h"
#import "KCView.h"
#import "KCView2.h"
#import "KCView3.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
#pragma mark -- 绘制三角形 //绘制矩形 //绘制椭圆

//    [self drawRectangle];
#pragma mark -- 绘制渐变
//      [self gradient];
    
#pragma mark -- 自制美图
    
    [self meiTu];
   
    
    
}


- (void)drawRectangle{
    KCView *view = [[KCView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
}

- (void)gradient{
    
    KCView3 *view = [[KCView3 alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}

- (void)meiTu{
    
    KCView2 *view = [[KCView2 alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
