//
//  UIView+LayoutFrame.h
//  QianChengApp
//
//  Created by zhangsong on 2017/11/20.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LayoutFrame)
- (CGFloat)x;
- (CGFloat)y;

- (CGFloat)height;

- (CGFloat)width;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;

- (void)setWidth:(CGFloat)width;

- (void)setHeight:(CGFloat)height;

- (void)setSize:(CGSize)size;

- (CGSize)size;

- (void)setOrigin:(CGPoint)origin;

- (CGPoint)origin;

- (CGFloat)bottom;

//- (void)setCenterX:(CGFloat)centerX;
//
//- (void)setCenterY:(CGFloat)centerY;

- (void)addSubView:(UIView *)bView frameBottomView:(UIView *)sView;

- (void)addSubView:(UIView *)bView frameBottomView:(UIView *)sView offset:(CGFloat)offset;
@end
