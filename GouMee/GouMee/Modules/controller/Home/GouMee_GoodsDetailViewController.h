//
//  GouMee_GoodsDetailViewController.h
//  GouMee
//
//  Created by 白冰 on 2019/12/11.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GouMee_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GouMee_GoodsDetailViewController : GouMee_BaseViewController
@property (nonatomic, strong)NSString *goodId;
@property (nonatomic, assign)NSInteger isFree;//是否是免费寄样 (1)
@end

NS_ASSUME_NONNULL_END