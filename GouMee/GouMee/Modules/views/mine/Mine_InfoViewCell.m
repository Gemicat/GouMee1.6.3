//
//  Mine_InfoViewCell.m
//  GouMee
//
//  Created by 白冰 on 2019/12/16.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "Mine_InfoViewCell.h"
#import "UIView+Gradient.h"
typedef NS_ENUM(NSInteger, DXRadianDirection) {
    DXRadianDirectionBottom     = 0,
    DXRadianDirectionTop        = 1,
    DXRadianDirectionLeft       = 2,
    DXRadianDirectionRight      = 3,
};

@interface Mine_InfoViewCell ()
{
    UIView *backView;
}
// 圆弧方向, 默认在下方
@property (nonatomic) DXRadianDirection direction;
// 圆弧高/宽, 可为负值。 正值凸, 负值凹
@property (nonatomic) CGFloat radian;
@end


@implementation Mine_InfoViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self creatView];
    }
    return self;
}

-(void)creatView
{
    self.backgroundColor = COLOR_STR(0xf5f5f5);

    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, scale(120))];
    [self addSubview:backView];


    self.direction = 0;
    [self setRadian:20];
     [backView setGradientBackgroundWithColors:@[COLOR_STR(0xFBECE5),COLOR_STR(0xF7D5E3)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];

    UIView *user_bg = [UIView new];
    [backView addSubview:user_bg];
    [user_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_top).offset(scale(0));
        make.left.mas_equalTo(backView.mas_left).offset(scale(18));
        make.height.width.mas_equalTo(scale(54));
    }];
    user_bg.layer.cornerRadius = scale(26);
    user_bg.layer.masksToBounds = YES;
    user_bg.backgroundColor = [UIColor whiteColor];

    
    self.userIcon = [UIButton new];
    [user_bg addSubview:self.userIcon];
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(user_bg.mas_centerY);
        make.centerX.mas_equalTo(user_bg.mas_centerX);
        make.height.width.mas_equalTo(scale(52));
    }];
    [self.userIcon setImage:[UIImage imageNamed:@"head_bg"] forState:UIControlStateNormal];
    self.userIcon.layer.cornerRadius = scale(26);
    self.userIcon.layer.masksToBounds = YES;

    self.userName = [UILabel new];
    [self addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.userIcon.mas_centerY).offset(0);
        make.left.mas_equalTo(self.userIcon.mas_right).offset(10);
    }];
    self.userName.textColor = COLOR_STR(0x333333);
    self.userName.font = [UIFont fontWithName:@"PingFangSC-Medium" size:scale(15)];
    self.userName.text = @"";

    UIView *centerView =[UIView new];
    [self addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_bottom).offset(scale(10));
        make.left.mas_equalTo(scale(15));
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(scale(106));
    }];
    centerView.layer.cornerRadius = 10;
    centerView.layer.masksToBounds = YES;
    centerView.backgroundColor = [UIColor whiteColor];
    UILabel *tip = [UILabel new];
    [centerView addSubview:tip];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(10));
        make.left.mas_equalTo(scale(10));

    }];
    tip.text = @"业绩中心";
    tip.textColor = COLOR_STR(0x333333);
    tip.font = font1(@"PingFangSC-Medium", scale(14));

    UIView *oneLine = [UIView new];
    oneLine.backgroundColor = COLOR_STR(0xf9f9f9);
    [centerView addSubview:oneLine];
    [oneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(centerView.mas_left).offset(0);
        make.top.mas_equalTo(tip.mas_bottom).offset(scale(10));
    }];

    self.willMonth = [UIButton new];
    [centerView addSubview:self.willMonth];
    [self.willMonth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(oneLine.mas_bottom).offset(scale(2));
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(SW/3.0-10);
    }];
    [self.willMonth setTitle:@"0.00" forState:UIControlStateNormal];
    self.willMonth.titleLabel.font = font1(@"PingFangSC-Medium", scale(16));
    [self.willMonth setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];

//
    self.willDay = [UIButton new];
    [centerView addSubview:self.willDay];
    [self.willDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.willMonth.mas_top).offset(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.willMonth.mas_left).offset(0);
        make.width.mas_equalTo(SW/3.0-10);
    }];
    [self.willDay setTitle:@"0.00" forState:UIControlStateNormal];
    self.willDay.titleLabel.font = font1(@"PingFangSC-Medium", scale(16));
    [self.willDay setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];

    self.sumMoney = [UIButton new];
    [centerView addSubview:self.sumMoney];
    [self.sumMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.willMonth.mas_top).offset(0);
        make.right.mas_equalTo(-15);
        make.left.mas_equalTo(self.willMonth.mas_right).offset(0);
        make.width.mas_equalTo(SW/3.0-10);
    }];
    [self.sumMoney setTitle:@"0.00" forState:UIControlStateNormal];
    self.sumMoney.titleLabel.font = font1(@"PingFangSC-Medium", scale(16));
    [self.sumMoney setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];


    UILabel *dayLab = [UILabel new];
    [centerView addSubview:dayLab];
    [dayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.willDay.mas_bottom).offset(0);
        make.centerX.mas_equalTo(self.willDay.mas_centerX).offset(0);
    }];
    dayLab.text = @"今日付款预估收入";
    dayLab.textColor = COLOR_STR(0x666666);
    dayLab.font = font(11);

    UILabel *monthLab = [UILabel new];
    [centerView addSubview:monthLab];
    [monthLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.willMonth.mas_bottom).offset(0);
        make.centerX.mas_equalTo(self.willMonth.mas_centerX).offset(0);
    }];
    monthLab.text = @"本月付款预估收入";
    monthLab.textColor = COLOR_STR(0x666666);
    monthLab.font = font(11);

    UILabel *sumLab = [UILabel new];
    [centerView addSubview:sumLab];
    [sumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sumMoney.mas_bottom).offset(0);
        make.centerX.mas_equalTo(self.sumMoney.mas_centerX).offset(0);
    }];
    sumLab.text = @"累计收入";
    sumLab.textColor = COLOR_STR(0x666666);
    sumLab.font = font(11);

    UIView *twoLine = [UIView new];
    [centerView addSubview:twoLine];
    twoLine.backgroundColor =COLOR_STR(0xf9f9f9);
    [twoLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(oneLine.mas_bottom).offset(14);
        make.bottom.mas_equalTo(centerView.mas_bottom).offset(-14);
        make.left.mas_equalTo(self.willDay.mas_right).offset(0);
        make.width.mas_equalTo(1);
    }];

    UIView *threeLine = [UIView new];
    [centerView addSubview:threeLine];
    threeLine.backgroundColor = COLOR_STR(0xf9f9f9);
    [threeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(twoLine.mas_top).offset(0);
        make.bottom.mas_equalTo(twoLine.mas_bottom).offset(0);
        make.left.mas_equalTo(self.willMonth.mas_right).offset(0);
        make.width.mas_equalTo(1);
    }];

    UIView *bomView = [UIView new];
    [backView addSubview:bomView];
    [bomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(scale(58));
        make.left.mas_equalTo(15);
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [bomView setGradientBackgroundWithColors:@[COLOR_STR(0x7F7F7F),COLOR_STR(0x292121)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    bomView.layer.cornerRadius = 10;
    bomView.layer.masksToBounds = YES;

    UIImageView *leftIcon = [UIImageView new];
    [bomView addSubview:leftIcon];
    [leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bomView.mas_centerY).offset(-3);
        make.left.mas_equalTo(scale(28));
    }];
    leftIcon.image = [UIImage imageNamed:@"logoss_mine"];

    UIView *lines = [UIView new];
    [bomView addSubview:lines];
    [lines mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftIcon.mas_right).offset(scale(20));
        make.centerY.mas_equalTo(leftIcon.mas_centerY).offset(0);
        make.height.mas_equalTo(leftIcon.mas_height);
        make.width.mas_equalTo(1);
    }];
    lines.backgroundColor = COLOR_STR(0xD9CB9E);

    self.balanceLab = [UILabel new];
    [bomView addSubview:self.balanceLab];
    [self.balanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(leftIcon.mas_centerY).offset(0);
        make.left.mas_equalTo(lines.mas_right).offset(scale(12));

    }];
    self.balanceLab.text = @"余额：0.00";
    self.balanceLab.textColor = COLOR_STR(0xF4DEA3);
    self.balanceLab.font = font1(@"PingFangSC-Medium", scale(18));


    self.withMoneyBtn = [UIButton new];
    [bomView addSubview:self.withMoneyBtn];
    [self.withMoneyBtn setTitle:@"提现" forState:UIControlStateNormal];
    [self.withMoneyBtn setTitleColor:COLOR_STR(0x706247) forState:UIControlStateNormal];
    self.withMoneyBtn.titleLabel.font = font(12);
    [self.withMoneyBtn setGradientBackgroundWithColors:@[COLOR_STR(0xFAE5AD),COLOR_STR(0xECD899)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    self.withMoneyBtn.layer.cornerRadius = 12;
    self.withMoneyBtn.layer.masksToBounds = YES;
    [self.withMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(leftIcon.mas_centerY).offset(0);
        make.right.mas_equalTo(bomView.mas_right).offset(-15);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(54);
    }];
    [self.withMoneyBtn addTarget:self action:@selector(xxxxx) forControlEvents:UIControlEventTouchUpInside];

    [self.willDay addTarget:self action:@selector(clicks) forControlEvents:UIControlEventTouchUpInside];
    [self.willMonth addTarget:self action:@selector(clicks) forControlEvents:UIControlEventTouchUpInside];
    [self.sumMoney addTarget:self action:@selector(clicks) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)sets
{
    if (self.setBlock) {
        self.setBlock();
    }

}
-(void)xxxxx
{
    if (self.clickBlock) {
        self.clickBlock();
    }
}
-(void)clicks
{

    if (self.click) {
        self.click();
    }
}
-(void)creatLeftView:(UIView *)view
{
    UIView *topView = [UIView new];
    [view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_top).offset(scale(20));
        make.left.mas_equalTo(view.mas_left).offset(15);
        make.height.width.mas_equalTo(scale(58));
    }];
    UIImageView *backView = [UIImageView new];
    [view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
    }];
    backView.image = [UIImage imageNamed:@"user_bg"];
    self.userIcon = [UIButton new];
    [topView addSubview:self.userIcon];
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_top).offset(scale(0));
        make.centerX.mas_equalTo(topView.mas_centerX).offset(0);
        make.height.width.mas_equalTo(scale(58));
    }];
     [self.userIcon setImage:[UIImage imageNamed:@"head_bg"] forState:UIControlStateNormal];
    self.userIcon.layer.cornerRadius = scale(29);
    self.userIcon.layer.masksToBounds = YES;
    topView.layer.cornerRadius = scale(29);
   
//    self.userIcon.image = [UIImage imageNamed:@"sucai1"];
        topView.backgroundColor = [UIColor whiteColor];
        topView.layer.shadowColor = COLOR_STR1(0, 0, 0, 0.3).CGColor;
             //    阴影偏移量
        topView.layer.shadowOffset = CGSizeMake(0, 3);
             //    阴影透明度
        topView.layer.shadowOpacity = 1;
             //    阴影半径
             topView.layer.shadowRadius = 5;
    
    self.userName = [UILabel new];
    [view addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView.mas_centerY).offset(0);
        make.left.mas_equalTo(topView.mas_right).offset(10);
        make.right.mas_equalTo(view.mas_right).offset(-10);
    }];
    self.userName.textColor = COLOR_STR(0x999999);
    self.userName.font = [UIFont fontWithName:@"PingFangSC-Regular" size:scale(18)];
    self.userName.text = @"138****8888";
}
-(void)creatRightView:(UIView *)view
{
    UILabel *topLab = [UILabel new];
    [view addSubview:topLab];
    [topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_top).offset(scale(10));
        make.centerX.mas_equalTo(0);
    }];
    topLab.textColor = COLOR_STR(0x999999);
    topLab.font = font1(@"PingFangSC-Regular",scale(14));
    topLab.text = @"余额";
    
    self.retainLab = [UILabel new];
    [view addSubview:self.retainLab];
    [self.retainLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topLab.mas_bottom).offset(scale(6));
        make.centerX.mas_equalTo(topLab.mas_centerX).offset(0);
        make.left.mas_equalTo(view.mas_left).offset(10);
    }];
    self.retainLab.textColor = COLOR_STR(0x333333);
    self.retainLab.textAlignment = NSTextAlignmentCenter;
    self.retainLab.font = font1(@"PingFangSC-Medium", scale(15));
    self.retainLab.text = @"8888.88";
    
    UIButton *WithdrawalBtn = [UIButton new];
    [view addSubview:WithdrawalBtn];
    [WithdrawalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.retainLab.mas_bottom).offset(scale(5));
        make.centerX.mas_equalTo(view.mas_centerX).offset(0);
        make.height.mas_equalTo(scale(22));
        make.width.mas_equalTo(scale(56));
    }];
    
    WithdrawalBtn.layer.cornerRadius = scale(11);
    WithdrawalBtn.layer.masksToBounds = YES;
    WithdrawalBtn.layer.borderWidth = 1;
    WithdrawalBtn.layer.borderColor = COLOR_STR(0x999999).CGColor;
    [WithdrawalBtn setTitle:@"提现" forState:UIControlStateNormal];
    [WithdrawalBtn setTitleColor:COLOR_STR(0x999999) forState:UIControlStateNormal];
    WithdrawalBtn.titleLabel.font = font1(@"PingFangSC-Medium", scale(12));
    [WithdrawalBtn addTarget:self action:@selector(tixian) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setRadian:(CGFloat) radian
{
    if(radian == 0) return;
    CGFloat t_width = CGRectGetWidth(backView.frame); // 宽
    CGFloat t_height = CGRectGetHeight(backView.frame); // 高
    CGFloat height = fabs(radian); // 圆弧高度
    CGFloat x = 0;
    CGFloat y = 0;

    // 计算圆弧的最大高度
    CGFloat _maxRadian = 0;
    switch (self.direction) {
        case DXRadianDirectionBottom:
        case DXRadianDirectionTop:
            _maxRadian =  MIN(t_height, t_width / 2);
            break;
        case DXRadianDirectionLeft:
        case DXRadianDirectionRight:
            _maxRadian =  MIN(t_height / 2, t_width);
            break;
        default:
            break;
    }
    if(height > _maxRadian){
        NSLog(@"圆弧半径过大, 跳过设置。");
        return;
    }

    // 计算半径
    CGFloat radius = 0;
    switch (self.direction) {
        case DXRadianDirectionBottom:
        case DXRadianDirectionTop:
        {
            CGFloat c = sqrt(pow(t_width / 2, 2) + pow(height, 2));
            CGFloat sin_bc = height / c;
            radius = c / ( sin_bc * 2);
        }
            break;
        case DXRadianDirectionLeft:
        case DXRadianDirectionRight:
        {
            CGFloat c = sqrt(pow(t_height / 2, 2) + pow(height, 2));
            CGFloat sin_bc = height / c;
            radius = c / ( sin_bc * 2);
        }
            break;
        default:
            break;
    }

    // 画圆
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    CGMutablePathRef path = CGPathCreateMutable();
    switch (self.direction) {
        case DXRadianDirectionBottom:
        {
            if(radian > 0){
                CGPathMoveToPoint(path,NULL, t_width,t_height - height);
                CGPathAddArc(path,NULL, t_width / 2, t_height - radius, radius, asin((radius - height ) / radius), M_PI - asin((radius - height ) / radius), NO);
            }else{
                CGPathMoveToPoint(path,NULL, t_width,t_height);
                CGPathAddArc(path,NULL, t_width / 2, t_height + radius - height, radius, 2 * M_PI - asin((radius - height ) / radius), M_PI + asin((radius - height ) / radius), YES);
            }
            CGPathAddLineToPoint(path,NULL, x, y);
            CGPathAddLineToPoint(path,NULL, t_width, y);
        }
            break;
        case DXRadianDirectionTop:
        {
            if(radian > 0){
                CGPathMoveToPoint(path,NULL, t_width, height);
                CGPathAddArc(path,NULL, t_width / 2, radius, radius, 2 * M_PI - asin((radius - height ) / radius), M_PI + asin((radius - height ) / radius), YES);
            }else{
                CGPathMoveToPoint(path,NULL, t_width, y);
                CGPathAddArc(path,NULL, t_width / 2, height - radius, radius, asin((radius - height ) / radius), M_PI - asin((radius - height ) / radius), NO);
            }
            CGPathAddLineToPoint(path,NULL, x, t_height);
            CGPathAddLineToPoint(path,NULL, t_width, t_height);
        }
            break;
        case DXRadianDirectionLeft:
        {
            if(radian > 0){
                CGPathMoveToPoint(path,NULL, height, y);
                CGPathAddArc(path,NULL, radius, t_height / 2, radius, M_PI + asin((radius - height ) / radius), M_PI - asin((radius - height ) / radius), YES);
            }else{
                CGPathMoveToPoint(path,NULL, x, y);
                CGPathAddArc(path,NULL, height - radius, t_height / 2, radius, 2 * M_PI - asin((radius - height ) / radius), asin((radius - height ) / radius), NO);
            }
            CGPathAddLineToPoint(path,NULL, t_width, t_height);
            CGPathAddLineToPoint(path,NULL, t_width, y);
        }
            break;
        case DXRadianDirectionRight:
        {
            if(radian > 0){
                CGPathMoveToPoint(path,NULL, t_width - height, y);
                CGPathAddArc(path,NULL, t_width - radius, t_height / 2, radius, 1.5 * M_PI + asin((radius - height ) / radius), M_PI / 2 + asin((radius - height ) / radius), NO);
            }else{
                CGPathMoveToPoint(path,NULL, t_width, y);
                CGPathAddArc(path,NULL, t_width  + radius - height, t_height / 2, radius, M_PI + asin((radius - height ) / radius), M_PI - asin((radius - height ) / radius), YES);
            }
            CGPathAddLineToPoint(path,NULL, x, t_height);
            CGPathAddLineToPoint(path,NULL, x, y);
        }
            break;
        default:
            break;
    }

    CGPathCloseSubpath(path);
    [shapeLayer setPath:path];
    CFRelease(path);
    backView.layer.mask = shapeLayer;
}
-(void)tixian
{
    if (self.click) {
        self.click();
    }
    
}
@end
