//
//  SendSheetView.h
//  GouMee
//
//  Created by 白冰 on 2020/4/11.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^sureBlock)(NSString *expressname, NSString *expressno);
NS_ASSUME_NONNULL_BEGIN

@interface SendSheetView : UIView
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong)UILabel *contextLab;
@property (nonatomic, strong)UILabel *expressName;
@property (nonatomic, strong)UITextField *expressNo;
@property (nonatomic, copy)sureBlock click;
@property (nonatomic, strong)NSString *exzz;

@end

NS_ASSUME_NONNULL_END
