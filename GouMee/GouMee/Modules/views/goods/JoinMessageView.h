//
//  JoinMessageView.h
//  GouMee
//
//  Created by 白冰 on 2020/4/7.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JoinMessageView : UIView
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UILabel *titleLabs;
@property (nonatomic, strong)UILabel *contextLabs;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong)UIButton *copysBtn;
@property (nonatomic, strong)UIImageView *topIcon;
@end

NS_ASSUME_NONNULL_END
