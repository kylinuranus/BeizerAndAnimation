//
//  WKTool.m
//  weiKit
//
//  Created by zsk on 2017/6/14.
//  Copyright © 2017年 zsk. All rights reserved.
//

#import "WKTool.h"

@implementation WKTool

+ (UIColor *)ColorFromHexColor:(NSString *)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    NSInteger startLocation = 0;
    if ([hexColor hasPrefix:@"#"]) {
        startLocation += 1;
    }
    
    range.location = startLocation;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location += range.length;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location += range.length;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}

@end
