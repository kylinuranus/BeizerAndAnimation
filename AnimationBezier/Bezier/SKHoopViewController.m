//
//  SKHoopViewController.m
//  AnimationAndBizier
//
//  Created by 赵申侃 on 2017/11/14.
//  Copyright © 2019 赵申侃. All rights reserved.
//

#import "SKHoopViewController.h"


@interface SKHoopViewController ()

@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) UIView *grayView;

@end

@implementation SKHoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _grayView = [[UIView alloc] initWithFrame:CGRectMake((self.view.view_width - 220)/2, 100, 220, 220)];
    _grayView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_grayView];
    
    _circleLayer = [CAShapeLayer layer];
    _circleLayer.frame = CGRectMake(0, 0, _grayView.view_width, _grayView.view_height);
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    [_grayView.layer addSublayer:_circleLayer];
    
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    leftLayer.frame = CGRectMake(0, 0, 220, 220);
    // 分段设置渐变色
    leftLayer.locations = @[@0.3, @0.9, @1];
    leftLayer.colors = @[(id)[WKTool ColorFromHexColor:@"2ebc82"].CGColor, (id)[WKTool ColorFromHexColor:@"57e1a9"].CGColor];
    [_circleLayer addSublayer:leftLayer];
    
    CAShapeLayer *layer = [self generateMaskLayerWithStartAngel:-0.5*M_PI endAngel:1.5*M_PI];
    _circleLayer.mask = layer;
    _circleLayer = layer;

    CAShapeLayer *layer2 = [self generateMaskLayerWithStartAngel:-0.5*M_PI endAngel:1.5*M_PI];
    _grayView.layer.mask = layer2;
    
    _circleLayer.strokeEnd = 0;
    
    
    [UIView animateWithDuration:8 animations:^{
        [self animationWithStrokeEnd:0.8];
    } completion:^(BOOL finished) {
        
    }];
}

- (CAShapeLayer *)generateMaskLayerWithStartAngel:(CGFloat )startAngle endAngel:(CGFloat )endAngel{
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.view.bounds;
    
    UIBezierPath *path = nil;
    path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(110, 110) radius:100 startAngle:startAngle  endAngle:endAngel clockwise:YES];
    
    layer.lineWidth = 20;
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor; // 填充色为透明（不设置为黑色）
    layer.strokeColor = [UIColor blackColor].CGColor; // 随便设置一个边框颜色
    layer.lineCap = kCALineCapRound;
    return layer;
}


- (void)animationWithStrokeEnd:(CGFloat)strokeEnd {
    
    POPSpringAnimation *strokeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    strokeAnimation.toValue = @(strokeEnd);
    strokeAnimation.springBounciness = 0;
    strokeAnimation.removedOnCompletion = NO;
    strokeAnimation.beginTime = 2;
    [self.circleLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];
}


@end
