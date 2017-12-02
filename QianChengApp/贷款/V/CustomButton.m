//
//  CustomButton.m
//  QianChengApp
//
//  Created by 张松 on 2017/12/2.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.titleLabel.layer.borderColor = [UIColor clearColor].CGColor;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    //CGFloat width = CGRectGetWidth(self.titleLabel.frame);
    return CGRectMake(contentRect.origin.x + 50, 0, 52, 30);

}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = CGRectGetMaxX(self.titleLabel.frame);
    return CGRectMake(imageX, 10, 11, 11);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
