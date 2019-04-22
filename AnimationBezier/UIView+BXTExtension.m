//
//  UIView+BXTExtension.m
//  BXTApp
//
//  Created by zhaoshenkan on 16/4/18.
//  Copyright © 2016年 zhaoshenkan. All rights reserved.
//

#import "UIView+BXTExtension.h"

@implementation UIView (BXTExtension)

- (CGFloat)rightX
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottomY
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)view_x
{
    return self.frame.origin.x;
}

- (CGFloat)view_y
{
    return self.frame.origin.y;
}

- (CGFloat)view_width
{
    return self.frame.size.width;
}

- (CGFloat)view_height
{
    return self.frame.size.height;
}

- (CGFloat)view_centerX
{
    return self.center.x;
}

- (CGFloat)view_centerY
{
    return self.center.y;
}

@end
