//
//  XZBButton.m
//  XZBActionSheet
//
//  Created by 肖志斌 on 2018/7/29.
//  Copyright © 2018年 xiao. All rights reserved.
//

#import "XZBButton.h"
@interface XZBButton ()

@property (nonatomic, strong, nullable) UIColor *beginColor;

@property (nonatomic, strong, nullable) UIColor *endColor;

@end
@implementation XZBButton

- (void)initWithBlock:(ClickActionBlock)clickActionBlock for:(UIControlEvents)event{
    
    [self addTarget:self action:@selector(goAction:) forControlEvents:event];
    
    self.caBlock = clickActionBlock;
    
}

- (void)goAction:(UIButton *)btn{
    
    self.caBlock(btn);
    
}

+ (instancetype)btnWithBeginColor:(UIColor *)begin endColor:(UIColor *)end {
    XZBButton *btn = [self buttonWithType:UIButtonTypeCustom];
    btn.beginColor = begin;
    btn.endColor = end;
    return btn;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef currenRef = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat location[2] = {0.0,1.0};
    CFArrayRef colors = CFArrayCreate(kCFAllocatorDefault, (const void*[]){_beginColor.CGColor,_endColor.CGColor}, 2, nil);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colors, location);
    CGPoint start = CGPointMake(self.frame.size.width * 0.5, 0);
    CGPoint end = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height);
    UIGraphicsPushContext(currenRef);
    CGContextDrawLinearGradient(currenRef, gradient, start, end, 0);
    UIGraphicsPopContext();
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}

@end
