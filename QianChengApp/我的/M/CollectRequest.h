//
//  CollectRequest.h
//  QianChengApp
//
//  Created by 张松 on 2017/12/2.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

typedef NS_ENUM(NSUInteger, collectType) {
    collectTypeDaiKuan,
    collectTypeCard,
};

@interface CollectRequest : YTKRequest
- (instancetype)initWithProductId:(NSNumber *)productId CollectType:(NSNumber *)type cardType:(collectType)collectType;

@end
