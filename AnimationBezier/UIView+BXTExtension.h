//
//  UIView+BXTExtension.h
//  BXTApp
//
//  Created by zhaoshenkan on 16/4/18.
//  Copyright © 2016年 zhaoshenkan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BXTExtension)

/** view最右边点的x坐标*/
- (CGFloat)rightX;

/** view底部的y坐标*/
- (CGFloat)bottomY;

/** view的x坐标*/
- (CGFloat)view_x;

/** view的y坐标*/
- (CGFloat)view_y;

/** view的宽度*/
- (CGFloat)view_width;

/** view的高度*/
- (CGFloat)view_height;

- (CGFloat)view_centerX;

- (CGFloat)view_centerY;

@end
