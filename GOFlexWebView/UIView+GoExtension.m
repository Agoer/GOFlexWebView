//
//  UIView+GoExtension.m
//  GOFlexWebViewDemo
//
//  Created by 李二狗 on 2018/5/30.
//  Copyright © 2018年 李二狗. All rights reserved.
//

#import "UIView+GoExtension.h"

@implementation UIView (GoExtension)

- (void)setGo_x:(CGFloat)go_x
{
    CGRect frame = self.frame;
    frame.origin.x = go_x;
    self.frame = frame;
}

- (CGFloat)go_x
{
    return self.frame.origin.x;
}

- (void)setGo_y:(CGFloat)go_y
{
    CGRect frame = self.frame;
    frame.origin.y = go_y;
    self.frame = frame;
}

- (CGFloat)go_y
{
    return self.frame.origin.y;
}

- (void)setGo_w:(CGFloat)go_w
{
    CGRect frame = self.frame;
    frame.size.width = go_w;
    self.frame = frame;
}

- (CGFloat)go_w
{
    return self.frame.size.width;
}

- (void)setGo_h:(CGFloat)go_h
{
    CGRect frame = self.frame;
    frame.size.height = go_h;
    self.frame = frame;
}

- (CGFloat)go_h
{
    return self.frame.size.height;
}

- (void)setGo_size:(CGSize)go_size
{
    CGRect frame = self.frame;
    frame.size = go_size;
    self.frame = frame;
}

- (CGSize)go_size
{
    return self.frame.size;
}

- (void)setGo_origin:(CGPoint)go_origin
{
    CGRect frame = self.frame;
    frame.origin = go_origin;
    self.frame = frame;
}

- (CGPoint)go_origin
{
    return self.frame.origin;
}

@end
