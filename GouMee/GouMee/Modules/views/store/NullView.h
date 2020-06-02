//
//  NullView.h
//  GouMee
//
//  Created by 白冰 on 2019/12/21.
//  Copyright © 2019 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReviewViewBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface NullView : UIView
@property (nonatomic, strong)UILabel *nullTitle;
@property (nonatomic, strong)UIImageView *nullIocn;
@property (nonatomic, strong)UIButton *refreshBtn;
@property (nonatomic, copy)ReviewViewBlock click;

@end

NS_ASSUME_NONNULL_END
