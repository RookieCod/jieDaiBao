//
//  CollectRequest.m
//  QianChengApp
//
//  Created by 张松 on 2017/12/2.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "CollectRequest.h"

@interface CollectRequest()
{
    NSNumber *_productId;
    NSNumber *_type;
    collectType _cardType;
}
@end
@implementation CollectRequest

- (instancetype)initWithProductId:(NSNumber *)productId CollectType:(NSNumber *)type cardType:(collectType)collectType {
    if (self = [super init]) {
        _productId = productId;
        _type = type;
        _cardType = collectType;
    }
    return self;
}

- (NSString *)requestUrl
{
    if (_cardType == collectTypeCard) {
        return @"collection/card";
    } else {
        return @"collection/loan";
    }
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{

    if (_cardType == collectTypeCard) {
        return @{
                 @"sessionid" : [ZSUntils getApplicationDelegate].userSession,
                 @"cardid" : _productId,
                 @"deleteflag":_type,
                 };
    } else {
        return @{
                 @"sessionid" : [ZSUntils getApplicationDelegate].userSession,
                 @"loanid" : _productId,
                 @"deleteflag":_type,
                 };
    }
}
@end
