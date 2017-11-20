//
//  CycleScrollView.h
//  CircleScrollView
//
//  Created by 董德富 on 13-1-30.
//  Copyright (c) 2013年 董德富. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PageIndicateType) {
    PageIndicateTypePageControl,
    PageIndicateTypeLabel,
};

@protocol CycleScrollViewDelegate;
@protocol CycleScrollViewDatasource;

@interface CycleScrollView : UIView

/**
 *  form 0
 */
@property (nonatomic, assign, readonly) NSUInteger currentPage;
/**
 *  default 5s
 */
@property (nonatomic, assign) CGFloat cycleTimeInterval;

@property (nonatomic, weak) id<CycleScrollViewDatasource> datasource;
@property (nonatomic, weak) id<CycleScrollViewDelegate> delegate;

@property (assign, nonatomic) PageIndicateType indicateType;

- (void)reloadData;
- (void)startTimer;
/**
 *  must be called so that self can be dealloced
 */
- (void)stopTimer;

//- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;

@end


@protocol CycleScrollViewDelegate <NSObject>
- (void)cycleView:(CycleScrollView *)cycleView didSelectPageAtIndex:(NSUInteger)index;
- (void)cycleView:(CycleScrollView *)cycleView didShowPageAtIndex:(NSUInteger)index;
@end


@protocol CycleScrollViewDatasource <NSObject>
@required
- (NSInteger)numberOfCycleScrollViewPage;
- (UIView *)cycleView:(CycleScrollView *)cycleView pageAtIndex:(NSUInteger)index;
//- (NSString *)cycleView:(CycleScrollView *)cycleView titleAtIndex:(NSInteger)index;
@end
