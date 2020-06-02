//
//  LiveSaleViewCell.h
//  GouMee
//
//  Created by 白冰 on 2019/12/16.
//  Copyright © 2019 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^LiveHight)(CGFloat h);
NS_ASSUME_NONNULL_BEGIN

@interface LiveSaleViewCell : UICollectionViewCell
@property (nonatomic, strong)UILabel *desLab;
@property (nonatomic, copy)LiveHight click;
@property (nonatomic, strong)NSDictionary *model;
@end

NS_ASSUME_NONNULL_END
