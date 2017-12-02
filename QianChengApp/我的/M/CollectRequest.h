//
//  CollectRequest.h
//  QianChengApp
//
//  Created by 张松 on 2017/12/2.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface CollectRequest : YTKRequest
- (instancetype)initWithCollectType:(NSNumber *)type;

@end
