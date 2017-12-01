//
//  NSString+Addtion.h
//  QianChengApp
//
//  Created by zhangsong on 2017/12/1.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addtion)

+ (CGSize)getStringSize:(NSString *)string withFont:(UIFont *)font withWidth:(int)width;

+ (CGSize)getStringSize:(NSString *)string withFont:(UIFont *)font withHeight:(NSUInteger)height;
@end
