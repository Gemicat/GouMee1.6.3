//
//  Goumee_AddAreaViewController.h
//  GouMee
//
//  Created by 白冰 on 2020/3/9.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GouMee_BaseViewController.h"
typedef void(^AddAddressBlocks)(NSDictionary *model);
NS_ASSUME_NONNULL_BEGIN

@interface Goumee_AddAreaViewController : GouMee_BaseViewController
@property (nonatomic, strong)NSDictionary *model;
@property (nonatomic, copy)AddAddressBlocks click;

@end

NS_ASSUME_NONNULL_END
