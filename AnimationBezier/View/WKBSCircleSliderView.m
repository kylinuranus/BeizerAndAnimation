//
//  WKBSCircleSliderView.m
//  weiKit
//
//  Created by zsk on 2017/6/26.
//  Copyright © 2017年 zsk. All rights reserved.
//

#import "WKBSCircleSliderView.h"

@interface WKBSCircleSliderView ()

@property (nonatomic, strong) UIView *sliderView;

@property (nonatomic, strong) UIBezierPath *grayPath;
@property (nonatomic, strong) UIBezierPath *greenPath;
@property (nonatomic, strong) CAShapeLayer *greenShaperLayer;
;

@end

@implementation WKBSCircleSliderView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = KScreenWidth - 70*2;
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = CGRectMake(0, 0, width, width/2);
        layer.lineWidth = 10;
        layer.fillColor = [UIColor whiteColor].CGColor; // 填充色为透明（不设置为黑色）
        layer.strokeColor = [WKTool ColorFromHexColor:@"edf0ed"].CGColor; // 随便设置一个边框颜色
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2, width/2) radius:width/2 - 10 startAngle:M_PI  endAngle:2*M_PI clockwise:YES];
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
        
        _greenShaperLayer = [CAShapeLayer layer];
        _greenShaperLayer.frame = CGRectMake(0, 0, width, width/2);
        _greenShaperLayer.lineWidth = 10;
        _greenShaperLayer.fillColor = [UIColor whiteColor].CGColor; // 填充色为透明（不设置为黑色）
        _greenShaperLayer.strokeColor = [WKTool ColorFromHexColor:@"28b97e"].CGColor; // 随便设置一个边框颜色
        _grayPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2, width/2) radius:width/2 - 10 startAngle:M_PI  endAngle:M_PI clockwise:YES];
        _greenShaperLayer.path = _grayPath.CGPath;
        [self.layer addSublayer:_greenShaperLayer];
        
//        _sliderView = [[UIView alloc] init];  //slider的圆弧半斤唯 self.viewHeight - 10
//        _sliderView.backgroundColor = [UIColor whiteColor];
//        _sliderView.layer.cornerRadius = 10;
//        _sliderView.layer.borderWidth = 1;
//        _sliderView.layer.borderColor = [WKTool ColorFromHexColor:@"edf0ed"].CGColor;
//        [self addSubview:_sliderView];
//        
//        [_sliderView makeConstraints:^(MASConstraintMaker *make) {
//            make.width.height.equalTo(20);
//            make.centerY.equalTo(self.top).offset(width/2);
//            make.centerX.equalTo(self.left).offset(10);
//        }];

    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   [self sliderAnimation:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    CGPoint thisPoint = [[touches anyObject] locationInView:self];
    if (thisPoint.y > self.view_height) return;
    [self sliderAnimation:touches];
}

- (void)sliderAnimation:(NSSet<UITouch *> *)touches
{
    [self layoutIfNeeded];
    CGPoint arcCenter = CGPointMake(self.view_width/2, self.view_height);
    CGPoint thisPoint = [[touches anyObject] locationInView:self];
    CGFloat R = self.view_height - 10;
    CGFloat adjustedAngle = atan2f( arcCenter.y - thisPoint.y , arcCenter.x - thisPoint.x );
    self.adjustAngel = adjustedAngle;
//    NSLog(@"panPoint = %@",NSStringFromCGPoint(thisPoint));
//    NSLog(@"adAngel = %f, sin(adjustedAngle) * R = %f,cos(adjustedAngle) * R = %f",adjustedAngle,sin(adjustedAngle) * R  ,cos(adjustedAngle) * R);
    CGFloat y = sin(adjustedAngle) * R;
    y = R - fabs(y);
    CGFloat x = cos(adjustedAngle) * R;
    x = R - x;
    [_sliderView updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.left).offset(10 + x);
        make.centerY.equalTo(self.top).offset(y + 10);
    }];
    
    CGFloat width = KScreenWidth - 70*2;
    _grayPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2, width/2) radius:width/2 - 10 startAngle:M_PI  endAngle:(M_PI + adjustedAngle) clockwise:YES];
    _greenShaperLayer.path = _grayPath.CGPath;

}

- (void)slideWithAngle:(CGFloat )angle
{
    CGFloat width = KScreenWidth - 70*2;
    _grayPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2, width/2) radius:width/2 - 10 startAngle:M_PI  endAngle:(M_PI + angle) clockwise:YES];
    _greenShaperLayer.path = _grayPath.CGPath;
    
    CGFloat R = self.view_height - 10;
    CGFloat y = sin(angle) * R;
    y = R - fabs(y);
    CGFloat x = cos(angle) * R;
    x = R - x;
    [_sliderView updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.left).offset(10 + x);
        make.centerY.equalTo(self.top).offset(y + 10);
    }];

}

@end
