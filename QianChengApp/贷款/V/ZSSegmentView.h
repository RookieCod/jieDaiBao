//
//  ZSSegmentView.h
//  QianChengApp
//
//  Created by zhangsong on 2017/11/23.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@class ZSSegmentView;

@protocol ZSSegmentViewDelegate <NSObject>

- (void)selectedSegmentView:(ZSSegmentView *)view atIndex:(NSInteger)index;
@end

@interface ZSSegmentView : UIView

/** delegate */
@property (nonatomic, assign) id<ZSSegmentViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet CustomButton *leftButton;
@property (weak, nonatomic) IBOutlet CustomButton *rightButton;

- (void)reloadSubview:(NSInteger)index;

- (void)reloadTitle:(NSString *)string index:(NSInteger)index;
@end
