//
//  HomeCardTableViewCell.h
//  QianChengApp
//
//  Created by zhangsong on 2017/11/22.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCardModel.h"
#import "CardDetailModel.h"
#import "InfoListModel.h"
#define homeCardCellIdentifier @"HomeCardTableViewCell"

@interface HomeCardTableViewCell : UITableViewCell
/** <#description#> */
@property (nonatomic, strong) HomeCardModel *cardModel;

/** <#description#> */
@property (nonatomic, strong) CardDetailModel *detailModel;

/*  */
@property (nonatomic, strong) InfoListModel *infoListModel;
@end
