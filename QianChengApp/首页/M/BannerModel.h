//
//  BannerModel.h
//  QianChengApp
//
//  Created by zhangsong on 2017/11/22.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject
/** bannerName */
@property (nonatomic, strong) NSString *bannerName;

/** bannerPic */
@property (nonatomic, strong) NSString *bannerPic;

/** bannerSort */
@property (nonatomic, strong) NSNumber *bannerSort;

/** bannerUrl */
@property (nonatomic, strong) NSString *bannerUrl;
@end
