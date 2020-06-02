//
//  Goumee_TimeView.h
//  GouMee
//
//  Created by 白冰 on 2020/3/11.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^TimeViewBlocks)(NSString *date,NSString *low,NSString *high);
@interface Goumee_TimeView : UIView
@property (nonatomic, copy)TimeViewBlocks click;
@end

NS_ASSUME_NONNULL_END
