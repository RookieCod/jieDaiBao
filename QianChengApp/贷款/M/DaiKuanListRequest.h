//
//  DaiKuanListRequest.h
//  QianChengApp
//
//  Created by zhangsong on 2017/11/23.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface DaiKuanListRequest : YTKRequest
/** <#description#> */
@property (nonatomic, strong) NSString *money;

/** <#description#> */
@property (nonatomic, strong) NSString *sort;
@end
