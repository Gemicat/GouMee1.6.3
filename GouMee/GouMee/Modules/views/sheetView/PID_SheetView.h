//
//  PID_SheetView.h
//  GouMee
//
//  Created by 白冰 on 2019/12/19.
//  Copyright © 2019 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^UpBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface PID_SheetView : UIView
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)NSString *context;
@property (nonatomic, strong)NSString *contexts;
@property (nonatomic, strong)UILabel *contextLab;
@property (nonatomic, strong)UIButton *copysBtn;
@property (nonatomic, strong)UIButton *wxBtn;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, copy)UpBlock click;
@property (nonatomic, strong)UIImageView *topIcon;
@end

NS_ASSUME_NONNULL_END
