//
//  NSString+Addtion.m
//  QianChengApp
//
//  Created by zhangsong on 2017/12/1.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "NSString+Addtion.h"

@implementation NSString (Addtion)
+ (CGSize)getStringSize:(NSString *)string withFont:(UIFont *)font withWidth:(int)width
{
    CGSize stringSize;
    
    NSDictionary *attributes = @{NSFontAttributeName: font};
    
    stringSize = [[NSString stringWithFormat:@"%@",string]
                  boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                  attributes:attributes
                  context:nil].size;
    
    stringSize = CGSizeMake(ceilf(stringSize.width), ceilf(stringSize.height));
    
    if ([string length] == 0) {
        return CGSizeZero;
    }
    return stringSize;
}

+ (CGSize)getStringSize:(NSString *)string withFont:(UIFont *)font withHeight:(NSUInteger)height
{
    CGSize stringSize;
    
    NSDictionary *attributes = @{NSFontAttributeName: font};
    
    stringSize = [[NSString stringWithFormat:@"%@",string]
                  boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                  attributes:attributes
                  context:nil].size;
    
    stringSize = CGSizeMake(ceilf(stringSize.width), ceilf(stringSize.height));
    
    if ([string length] == 0) {
        return CGSizeZero;
    }
    return stringSize;
}

@end
