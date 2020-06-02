//
//  GouMee_AddressViewController.h
//  GouMee
//
//  Created by 白冰 on 2020/3/9.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GouMee_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^AddressBlocks)(NSDictionary *model);
@interface GouMee_AddressViewController : GouMee_BaseViewController
@property (nonatomic, strong)NSDictionary *addressModel;
@property (nonatomic, copy)AddressBlocks click;
@end

NS_ASSUME_NONNULL_END
