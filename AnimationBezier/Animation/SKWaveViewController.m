//
//  SKWaveViewController.m
//  AnimationAndBizier
//
//  Created by 赵申侃 on 2017/11/14.
//  Copyright © 2019 赵申侃. All rights reserved.
//

#import "SKWaveViewController.h"


@interface SKWaveViewController ()

@property (nonatomic, strong) CAShapeLayer *circleShapeLayer;

@end

@implementation SKWaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    _circleShapeLayer = [CAShapeLayer layer];
    _circleShapeLayer.frame = CGRectMake(0, 0, 200, 200);
    _circleShapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 200)].CGPath;
    _circleShapeLayer.fillColor = [UIColor grayColor].CGColor;
    _circleShapeLayer.opacity = 0;
    
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame =  CGRectMake(100, 100, 200, 200);
    replicator.instanceDelay = 0.5; //这两个属性相乘 等于aniomation 的时间duration 最佳
    replicator.instanceCount = 6;
    
    [replicator addSublayer:_circleShapeLayer];
    [self.view.layer addSublayer:replicator];
    
    [self startAnimation];
}

- (void)startAnimation
{
    CABasicAnimation *alphaAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnim.fromValue = [NSNumber numberWithFloat:0.6];
    alphaAnim.toValue = [NSNumber numberWithFloat:0.0];
    
    CABasicAnimation *scaleAnim =[CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D t = CATransform3DIdentity;
    CATransform3D t2 = CATransform3DScale(t, 0.3, 0.3, 0.0);
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:t2];
    CATransform3D t3 = CATransform3DScale(t, 1.0, 1.0, 0.0);
    scaleAnim.toValue = [NSValue valueWithCATransform3D:t3];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[alphaAnim, scaleAnim];
    groupAnimation.duration = 3;
    groupAnimation.autoreverses = NO;
    groupAnimation.repeatCount = HUGE;
    groupAnimation.removedOnCompletion = NO;
    
    [_circleShapeLayer addAnimation:groupAnimation forKey:nil];
}




@end
