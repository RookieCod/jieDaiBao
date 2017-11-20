//
//  CycleScrollView.m
//  CircleScrollView
//
//  Created by 董德富 on 13-1-30.
//  Copyright (c) 2013年 董德富. All rights reserved.
//

#import "CycleScrollView.h"

//#import <QuartzCore/QuartzCore.h>


@interface CycleScrollView ()
<
  UIScrollViewDelegate
> 
@property (nonatomic, strong) UIScrollView *baseScrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (strong, nonatomic) UILabel *pageLabel;

/**
 *  存储当前三个显示的视图
 */
@property (nonatomic, strong) NSMutableArray *currentViews;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalPages;

@end


@implementation CycleScrollView
- (void)setDatasource:(id<CycleScrollViewDatasource>)datasource {
    _datasource = datasource;
    [self reloadData];
}
- (NSMutableArray *)currentViews {
    if (!_currentViews) {
        _currentViews = [[NSMutableArray alloc] initWithCapacity:3];
    }
    return _currentViews;
}
- (void)setCurrentPage:(NSInteger)currentPage {
    if (_currentPage != currentPage) {
        _currentPage = currentPage;
        
    }
}
- (void)setCycleTimeInterval:(CGFloat)cycleTimeInterval {
    _cycleTimeInterval = cycleTimeInterval;
    if ([self.timer isValid]) {
        [self stopTimer];
        [self startTimer];
    }
}

#pragma mark - init

-(void)dealloc
{

}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self perset];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self perset];
    }
    return self;
}


#pragma mark - public
- (void)reloadData {
    self.totalPages = [self.datasource numberOfCycleScrollViewPage];
    if (self.totalPages <= 0) return;
    
    self.currentPage = 0;
    
    if (self.indicateType == PageIndicateTypePageControl)
    {
        self.pageControl.numberOfPages = self.totalPages;
        CGSize pageSize = [self.pageControl sizeForNumberOfPages:self.totalPages];
        self.pageControl.frame = CGRectMake(self.bounds.size.width-pageSize.width-5,
                                            self.bounds.size.height-(pageSize.height/2.)-15,
                                            pageSize.width, pageSize.height);
    }
    else {
        [self setPageIndicateLabelPages];
    }
    
    [self loadScrollViewWithData];
}
- (void)startTimer {
    if (self.totalPages == 0) return;
    
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.cycleTimeInterval
                                                  target:self
                                                selector:@selector(handelTimer:)
                                                userInfo:nil
                                                 repeats:YES];
}
- (void)stopTimer {
    if (self.totalPages == 0) return;
    
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - private
- (void)perset {
    _cycleTimeInterval = 5.0f;
    self.currentPage = 0;
    self.clipsToBounds = YES;
    
    self.baseScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.baseScrollView.delegate = self;
    self.baseScrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
    self.baseScrollView.showsHorizontalScrollIndicator = NO;
    self.baseScrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    self.baseScrollView.pagingEnabled = YES;
    self.baseScrollView.scrollsToTop = NO;
    [self addSubview:self.baseScrollView];
    
    [self setIndicateType:PageIndicateTypePageControl];
}

- (void)setPageIndicateLabelPages
{
    NSDictionary *attributesRed = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                      NSForegroundColorAttributeName: [UIColor whiteColor]};
    NSDictionary *attributesGray = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                    NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#b7b7b7"]};
    NSMutableAttributedString *indicateText = [[NSMutableAttributedString alloc] initWithString:[@(self.currentPage+1) description] attributes:attributesRed];
    [indicateText appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"/%@",[@(self.totalPages) description]] attributes:attributesGray]];
    self.pageLabel.attributedText = indicateText;
}

- (void)setIndicateType:(PageIndicateType)indicateType
{
    _indicateType = indicateType;
    [[self viewWithTag:10010] removeFromSuperview];
    CGRect pageRect = CGRectMake(self.bounds.size.width - 85, self.bounds.size.height - 18, 75, 8);
    if (indicateType == PageIndicateTypePageControl)
    {
        self.pageControl = [[UIPageControl alloc] initWithFrame:pageRect];
        self.pageControl.tag = 10010;
        self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        self.pageControl.userInteractionEnabled = NO;
        self.pageControl.currentPage = self.currentPage;
        self.pageControl.clipsToBounds = NO;
        self.pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"#dedede"];
        self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#1d88eb"];
        [self addSubview:self.pageControl];
    }
    else{
        self.pageLabel = [[UILabel alloc] initWithFrame:pageRect];
        self.pageLabel.y -= 10;
        self.pageLabel.height = 15;
        self.pageLabel.tag = 10010;
        self.pageLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        self.pageLabel.font = [UIFont systemFontOfSize:14.f];
        self.pageLabel.text = @"1/18";
        self.pageLabel.textColor = [UIColor whiteColor];
        self.pageLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.pageLabel];
    }
}

- (void)loadScrollViewWithData {
    
    [self stopTimer];
    if (self.indicateType == PageIndicateTypePageControl)
    {
        self.pageControl.currentPage = self.currentPage;
    }
    else {
        [self setPageIndicateLabelPages];
    }
    
    //从scrollView上移除所有的subview
    NSArray *subViews = [self.baseScrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:(int)self.currentPage];
    
    for (int i = 0; i < self.currentViews.count; i++) {
        UIView *v = [self.currentViews objectAtIndex:i];
        v.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleTap:)];
        [v addGestureRecognizer:singleTap];
        v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
        [self.baseScrollView addSubview:v];
    }
    
    if (self.currentViews.count > 1) {
        self.baseScrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        [self.baseScrollView setContentOffset:CGPointMake(self.baseScrollView.frame.size.width, 0)];
        [self startTimer];
    } else if (self.currentViews.count == 1) {
        self.baseScrollView.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    }
    
    if ([self.delegate respondsToSelector:@selector(cycleView:didShowPageAtIndex:)]) {
        [self.delegate cycleView:self didShowPageAtIndex:self.currentPage];
    }
}
- (void)getDisplayImagesWithCurpage:(int)page {
    
    int pre = [self validPageValue:self.currentPage-1];
    int last = [self validPageValue:self.currentPage+1];
        
    [self.currentViews removeAllObjects];
    
    if (!self.datasource) return;
    
    if (self.totalPages == 1) {
        self.currentPage = 0;
        [self.currentViews addObject:[self.datasource cycleView:self pageAtIndex:0]];
    }else {
        [self.currentViews addObject:[self.datasource cycleView:self pageAtIndex:pre]];
        [self.currentViews addObject:[self.datasource cycleView:self pageAtIndex:page]];
        [self.currentViews addObject:[self.datasource cycleView:self pageAtIndex:last]];
    }
}
- (int)validPageValue:(NSInteger)value {
    
    if(value == -1) value = self.totalPages - 1;
    if(value == self.totalPages) value = 0;
    
    return (int)value;
}
- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(cycleView:didSelectPageAtIndex:)]) {
        [self.delegate cycleView:self didSelectPageAtIndex:self.currentPage];
    }
}
- (void)handelTimer:(NSTimer *)timer {
    [self.baseScrollView setContentOffset:CGPointMake(self.baseScrollView.bounds.size.width * 2, 0)
                                 animated:YES];
//    [self setTransToNextPage];
}
/*
#pragma mark animate
- (void)setTransToNextPage {
    CGSize size = self.frame.size;
    self.baseLayer = [CALayer layer];
    CALayer *theLayer = [CALayer layer];
    CALayer *nextLayer = [CALayer layer];
    self.baseLayer.backgroundColor = [UIColor whiteColor].CGColor;
    
    if (self.currentViews.count != 3) return;
    UIView *currentView = self.currentViews[1];
    UIView *nextView = self.currentViews[2];
    theLayer.contents = currentView.layer.contents;
    nextLayer.contents = nextView.layer.contents;
    
    nextLayer.frame = CGRectMake(size.width, 0, size.width, size.height);
    theLayer.frame = CGRectMake(0, 0, size.width, size.height);    
    [self.baseLayer addSublayer:nextLayer];
    [self.baseLayer addSublayer:theLayer];
    
    self.baseLayer.frame = CGRectMake(0, 0, size.width*2, size.height);
    [self.layer insertSublayer:self.baseLayer above:self.baseScrollView.layer];
    
    CAMediaTimingFunction *timeFunction = [CAMediaTimingFunction functionWithControlPoints:1. :.001 :0 :.999];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.toValue = [NSNumber numberWithFloat:0];
    animation.timingFunction = timeFunction;
    animation.delegate = self;
    animation.duration = .7;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.baseLayer addAnimation:animation forKey:nil];
    
    self.userInteractionEnabled = NO;
    [self stopTimer];
    
    self.titleLable.transitionEffect
    = ([self validPageValue:self.currentPage+1] > self.currentPage) ?
    BBCyclingLabelTransitionEffectScrollUp : BBCyclingLabelTransitionEffectScrollDown;
    [self.titleLable setText:[self.datasource cycleView:self titleAtIndex:self.currentPage]
                    animated:YES];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.baseLayer removeFromSuperlayer];
    self.baseLayer = nil;
    self.currentPage = [self validPageValue:self.currentPage+1];
    [self loadDataWithTextAnimat:NO];
    
    self.userInteractionEnabled = YES;
    [self startTimer];
}
*/

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {    
    int x = scrollView.contentOffset.x;
    //往下翻一张
    if(x >= (2*self.frame.size.width)) {
        self.currentPage = [self validPageValue:self.currentPage+1];
        [self loadScrollViewWithData];
    }
    //往上翻
    if(x <= 0) {
        self.currentPage = [self validPageValue:self.currentPage-1];
        [self loadScrollViewWithData];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    int x = scrollView.contentOffset.x;
    //往下翻一张
    if(x >= (2*self.frame.size.width)) {
        self.currentPage = [self validPageValue:self.currentPage+1];
        [self loadScrollViewWithData];
    }
    //往上翻
    if(x <= 0) {
        self.currentPage = [self validPageValue:self.currentPage-1];
        [self loadScrollViewWithData];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    [self startTimer];
}

@end








