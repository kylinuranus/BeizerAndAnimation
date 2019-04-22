//
//  SKDragHoopViewController.m
//  AnimationBezier
//
//  Created by 赵申侃 on 2017/11/14.
//  Copyright © 2019 赵申侃. All rights reserved.
//

#import "SKDragHoopViewController.h"
#import "WKBSCircleSliderView.h"

@interface SKDragHoopViewController ()

@property (nonatomic, strong) UIView *sliderView;

@property (nonatomic, strong) WKBSCircleSliderView *rectView;


@end

@implementation SKDragHoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _rectView = [[WKBSCircleSliderView alloc] init];
    _rectView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_rectView];
    
    [_rectView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.width.equalTo(self.view.view_width);
        make.height.equalTo(self.view.view_width/2);
        make.centerX.equalTo(self.view);
    }];

}

@end
