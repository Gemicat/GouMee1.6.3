//
//  GouMee_IDEditViewController.h
//  GouMee
//
//  Created by 白冰 on 2020/1/11.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GouMee_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GouMee_IDEditViewController : GouMee_BaseViewController
@property (nonatomic, strong)NSMutableDictionary *IDModel;
@property (nonatomic , strong)NSMutableDictionary *frontModel;
@property (nonatomic, strong)NSMutableDictionary *afterModel;
@end

NS_ASSUME_NONNULL_END
