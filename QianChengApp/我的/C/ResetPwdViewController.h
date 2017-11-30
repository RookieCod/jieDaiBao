//
//  ResetPwdViewController.h
//  QianChengApp
//
//  Created by 张松 on 2017/11/30.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, pushType) {
    pushTypeForget,
    pushTypeReset,
};
@interface ResetPwdViewController : UIViewController
/*  */
@property (nonatomic, assign) pushType *pushType;
@end
