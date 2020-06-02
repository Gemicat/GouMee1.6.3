//
//  ConditionsView.h
//  GouMee
//
//  Created by 白冰 on 2019/12/12.
//  Copyright © 2019 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^FilterViewBlock)(NSString *orderStr);
typedef void(^FilterViewBlocks)(NSString *lowStr,NSString *highStr,NSString *liStr);
@interface ConditionsView : UIView
@property (nonatomic, strong)UIView *sheetView;
@property (nonatomic, copy) FilterViewBlock click;
@property (nonatomic, copy) FilterViewBlocks clicks;
@end

NS_ASSUME_NONNULL_END
