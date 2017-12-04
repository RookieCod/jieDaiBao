//
//  UIViewController+ReloadViewDidLoad.m
//  QianChengApp
//
//  Created by 张松 on 2017/12/4.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "UIViewController+ReloadViewDidLoad.h"

@implementation UIViewController (ReloadViewDidLoad)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"UIViewController");

        Method originalMethod = class_getInstanceMethod(class, @selector(viewDidLoad));
        Method swizzledMethod = class_getInstanceMethod(class, @selector(zs_viewDidLoad));

        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

- (void)zs_viewDidLoad
{
    @autoreleasepool {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        return [self zs_viewDidLoad];
    }
}

@end
