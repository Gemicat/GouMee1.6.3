//
//  FreeGoodView.h
//  GouMee
//
//  Created by 白冰 on 2020/3/13.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^FreeBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface FreeGoodView : UIView

@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UIButton *timeBtn;

@property (nonatomic, strong)UILabel *address_name;
@property (nonatomic, strong)UILabel *address_context;
@property (nonatomic, strong)UILabel *tipLab;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UIButton *centerBtn;
@property (nonatomic, copy) FreeBlock addBlock;
@property (nonatomic, copy) FreeBlock changeBlock;
@property (nonatomic, strong)UILabel *tip;
@property (nonatomic, strong)UILabel *tipss;
@property (nonatomic, strong)UILabel *choose_tip;
@property (nonatomic, copy) FreeBlock  applyBlock;
@property (nonatomic, strong) NSString *shenqing;
@end

NS_ASSUME_NONNULL_END
