//
//  SKTemperatureCircleViewController.m
//  AnimationBezier
//
//  Created by 赵申侃 on 2017/11/14.
//  Copyright © 2019 赵申侃. All rights reserved.
//

#import "SKTemperatureCircleViewController.h"

@interface SKTemperatureCircleViewController ()

@property (nonatomic, strong) UIView *hoopView;

@end

@implementation SKTemperatureCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *hoopView = [[UIView alloc] initWithFrame:CGRectMake((KScreenWidth - 300)/2 , 100, 300, 300)];
    hoopView.backgroundColor = [UIColor redColor];
    [self.view addSubview:hoopView];
    
    for (int i = 1; i < 200; i ++ ) {
        [self addItemindex:i];
    }
    
}

- (void)addItemindex:(NSInteger)index {
    
    CGFloat radius = _hoopView.view_width/2;
    CGFloat diaLength = 20;
    CGPoint center = CGPointMake(_hoopView.view_width/2, _hoopView.view_height/2);
    
    CAShapeLayer *diaItemLayer = [[CAShapeLayer alloc] init];
    diaItemLayer.lineWidth = 1;
    diaItemLayer.lineCap = kCALineCapSquare;
    diaItemLayer.lineJoin = kCALineJoinRound;
    diaItemLayer.strokeColor = [WKTool ColorFromHexColor:@"dddddd"].CGColor;
    diaItemLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat outsideRadius = radius ; // 刻度 外点半径
    CGFloat insideRadius = outsideRadius - diaLength; // 刻度 内点半径
    
    CGFloat angle1 = M_PI/2 + M_PI*3/8;
    CGFloat angle2 = index*((M_PI/2 + M_PI*3/8)*2/200);
    CGFloat angle = angle1 - angle2;
    
    CGPoint insidePoint = CGPointMake(center.x - (insideRadius * sin(angle)), center.y - (insideRadius * cos(angle)));
    CGPoint outsidePoint = CGPointMake(center.x - (outsideRadius * sin(angle)), center.y - (outsideRadius * cos(angle)));
    
    [path moveToPoint:insidePoint];
    [path addLineToPoint:outsidePoint];
    diaItemLayer.path = path.CGPath;
    
    [_hoopView.layer addSublayer:diaItemLayer];
    
}

@end
