//
//  SKChartViewController.m
//  AnimationBezier
//
//  Created by 赵申侃 on 2017/11/14.
//  Copyright © 2019 赵申侃. All rights reserved.
//

typedef enum : NSUInteger {
    kLineTypeStraight,
    kLineTypeCurve,
} kLineType;

#import "SKChartViewController.h"

@interface SKChartViewController ()


@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *lineStraightChartView;
@property (nonatomic, strong) UIView *lineCureChartView;
@property (nonatomic, strong) UIView *barChartView;
@property (nonatomic, strong) UIView *pieChartView;

@end

@implementation SKChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, self.view.view_height)];
    [self.view addSubview:_scrollView];
    
    _lineStraightChartView = [[UIView alloc] initWithFrame:CGRectMake(30, 100, KScreenWidth - 60, 200)];
    _lineStraightChartView.backgroundColor = [UIColor blueColor];
    [_scrollView addSubview:_lineStraightChartView];
    
    _lineCureChartView = [[UIView alloc] initWithFrame:CGRectMake(30, _lineStraightChartView.view_height + _lineStraightChartView.view_y + 30, KScreenWidth - 60, 200)];
    _lineCureChartView.backgroundColor = [UIColor blueColor];
    [_scrollView addSubview:_lineCureChartView];
    
    _barChartView = [[UIView alloc] initWithFrame:CGRectMake(30, _lineCureChartView.view_height + _lineCureChartView.view_y + 30, KScreenWidth - 60, 200)];
    _barChartView.backgroundColor = [UIColor blueColor];
    [_scrollView addSubview:_barChartView];
    
    _pieChartView = [[UIView alloc] initWithFrame:CGRectMake(30, _barChartView.view_height + _barChartView.view_y + 30, KScreenWidth - 60, 200)];
    _pieChartView.backgroundColor = [UIColor blueColor];
    [_scrollView addSubview:_pieChartView];
    
    _scrollView.contentSize = CGSizeMake(KScreenWidth, _pieChartView.view_y + _pieChartView.view_height + 100);
    
    
    NSArray *arr  = @[@"10",@"30",@"40",@"90",@"40",@"80",@"60",@"50",@"20",@"90",@"40",@"20",@"10",@"30",@"40",@"90",@"40",@"80",@"60",@"40",@"90",@"40",@"80",@"60",@"50",@"20"];
    
    
    NSArray *arr2 = @[@"10",@"30",@"40",@"40",@"80",@"60",@"50",@"20"];
    
    [self drawLineChart:arr lineType:kLineTypeStraight];
    [self drawLineChart:arr lineType:kLineTypeCurve];
    [self drawBarChartView:arr2];
    [self drawPieChartView:@[@"10",@"30",@"40"]];
    
}


- (void)drawLineChart:(NSArray *)arr lineType:(kLineType)lineType
{
    CGFloat margin = 10;
    UIBezierPath *path = [UIBezierPath bezierPath];
     CGPoint PrePonit;
    for (int i = 0; i < arr.count; i ++ ) {
        CGFloat y = [arr[i] floatValue];
        UIView *point = [[UIView alloc] init];
        point.center = CGPointMake(margin*i, 200 - y);
        point.bounds = CGRectMake(0, 0, 2, 2);
        point.backgroundColor = [UIColor redColor];
        if (i == 0) {
            [path moveToPoint:CGPointMake(margin*i, 200 - y)];
        }
        if (lineType == kLineTypeStraight) {
            [path addLineToPoint:CGPointMake(margin*i, 200 - y)];
        } else if (lineType == kLineTypeCurve) {
            CGPoint NowPoint = point.center;
            [path addCurveToPoint:NowPoint controlPoint1:CGPointMake((PrePonit.x+NowPoint.x)/2, PrePonit.y) controlPoint2:CGPointMake((PrePonit.x+NowPoint.x)/2, NowPoint.y)];
            PrePonit = NowPoint;
        }
        
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.borderWidth = 1;
    shapeLayer.frame = _lineCureChartView.bounds;
    
    
    if (lineType == kLineTypeStraight) {
        [_lineStraightChartView.layer addSublayer:shapeLayer];
    } else if (lineType == kLineTypeCurve) {
        [_lineCureChartView.layer addSublayer:shapeLayer];
    }
    
}

- (void)drawBarChartView:(NSArray *)arr
{
    for (int i=0; i<arr.count; i++) {
        CGFloat y = [arr[i] floatValue];
        CGFloat x = 40 * i;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x, 200 - y, 30, y)];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [UIColor clearColor].CGColor;
        shapeLayer.fillColor = [UIColor redColor].CGColor;
        shapeLayer.borderWidth = 2.0;
        [_barChartView.layer addSublayer:shapeLayer];
    }
}

- (void)drawPieChartView:(NSArray *)arr
{
    CGPoint point = CGPointMake(_pieChartView.frame.size.width/2,_pieChartView.frame.size.height/2);
    CGFloat startAngle = 0;
    CGFloat endAngle ;
    CGFloat radius = _pieChartView.view_height/2;
    
    //计算总数
    __block CGFloat allValue = 0;
    [arr enumerateObjectsUsingBlock:^(NSNumber *targetNumber, NSUInteger idx, BOOL * _Nonnull stop) {
        allValue += [targetNumber floatValue];
    }];
    
    NSArray *colorArr = @[@"f92145",@"28b97e",@"f8d25c"];
    //画图
    for (int i =0; i<arr.count; i++) {
        
        CGFloat targetValue = [arr[i] floatValue];
        endAngle = startAngle + targetValue/allValue*2*M_PI;
        
        //bezierPath形成闭合的扇形路径
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:point radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        [bezierPath addLineToPoint:point];
        [bezierPath closePath];
        
        //渲染
        CAShapeLayer *shapeLayer=[CAShapeLayer layer];
        shapeLayer.lineWidth = 1;
        shapeLayer.fillColor = [WKTool ColorFromHexColor:colorArr[i]].CGColor;
        shapeLayer.path = bezierPath.CGPath;
        [_pieChartView.layer addSublayer:shapeLayer];
        
        startAngle = endAngle;
    }
}

@end
