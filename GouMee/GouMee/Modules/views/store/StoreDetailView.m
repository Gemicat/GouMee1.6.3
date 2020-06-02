//
//  StoreDetailView.m
//  GouMee
//
//  Created by 白冰 on 2019/12/16.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "StoreDetailView.h"
#import "UIView+Gradient.h"
#import "UIButton+HPImageTitleSpacing.h"
@interface StoreDetailView ()
@property (nonatomic, strong)UIImageView *storeIcon;
@property (nonatomic, strong)UILabel *storeName;
@property (nonatomic, strong)UILabel *desScore;
@property (nonatomic, strong)UIButton *serviceScore;
@property (nonatomic, strong)UIButton *logisticsScore;


@end
@implementation StoreDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.isCircle = NO;
        [self createInterface];
    }
    return self;
}

-(void)createInterface
{
    self.backgroundColor = viewColor;
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, self.frame.size.height-10)];
    [self addSubview:self.backView];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.storeIcon = [UIImageView new];
    [self.backView addSubview:self.storeIcon];
    [self.storeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backView.mas_centerY).offset(0);
        make.left.mas_equalTo(16);
        make.height.width.mas_equalTo(44);
    }];
    self.storeIcon.layer.cornerRadius = 22;
    self.storeIcon.layer.masksToBounds = YES;
    self.storeIcon.image = [UIImage imageNamed:@"goods_bg"];
    
    self.enterStore = [UIButton new];
    [self.backView addSubview:self.enterStore];
    [self.enterStore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.storeIcon.mas_centerY).offset(0);
        make.right.mas_equalTo(self.backView.mas_right).offset(-16);
        make.height.mas_equalTo(scale(20));
        make.width.mas_equalTo(scale(40));
        
    }];
    self.storeName = [UILabel new];
    [self.backView addSubview:self.storeName];
    [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.storeIcon.mas_right).offset(10);
        make.top.mas_equalTo(self.storeIcon.mas_top).offset(0);
        make.right.mas_equalTo(self.enterStore.mas_left).offset(-6);
    }];
    self.storeName.textColor = COLOR_STR(0x333333);
    self.storeName.text = @"秋雨小熊旗舰店";
    self.storeName.font =[UIFont fontWithName:@"PingFangSC-Regular" size:scale(14)];
    
    //描述相符
    UILabel *label1 =[UILabel new];
    [self.backView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.storeIcon.mas_bottom).offset(0);
        make.left.mas_equalTo(self.storeName.mas_left).offset(0);
    }];
    label1.text = @"店铺综合分:";
    label1.textColor = COLOR_STR(0x999999);
    label1.font =[UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)];
    
    self.desScore = [UILabel new];
    [self.backView addSubview:self.desScore];
    [self.desScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1.mas_right).offset(3);
        make.centerY.mas_equalTo(label1.mas_centerY).offset(0);
    }];
    self.desScore.textColor = ThemeRedColor;
    self.desScore.font = [UIFont fontWithName:@"PingFangSC-Medium" size:scale(15)];;
    self.desScore.text = @"5.0";
//    [self.desScore setImage:[UIImage imageNamed:@"low_bg"] forState:UIControlStateNormal];
//    [self.desScore layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleRight imageTitleSpace:5];
    
    
    //服务态度
//       UILabel *label2 =[UILabel new];
//       [self.backView addSubview:label2];
//       [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.centerY.mas_equalTo(label1.mas_centerY).offset(0);
//           make.centerX.mas_equalTo(self.mas_centerX).offset(0);
//       }];
//       label2.text = @"服务态度";
//       label2.textColor = COLOR_STR(0x999999);
//       label2.font =[UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)];
//
//       self.serviceScore = [UIButton new];
//       [self.backView addSubview:self.serviceScore];
//       [self.serviceScore mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.top.mas_equalTo(label2.mas_bottom).offset(5);
//           make.centerX.mas_equalTo(label2.mas_centerX).offset(0);
//       }];
//       [self.serviceScore setTitle:@"5.0" forState:UIControlStateNormal];
//       [self.serviceScore setTitleColor: COLOR_STR(0xEE7D2E) forState:UIControlStateNormal];
//       self.serviceScore.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)];
//       [self.serviceScore setImage:[UIImage imageNamed:@"equal_bg"] forState:UIControlStateNormal];
//       [self.serviceScore layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleRight imageTitleSpace:3];
//
    //服务态度
//          UILabel *label3 =[UILabel new];
//          [self.backView addSubview:label3];
//          [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
//              make.centerY.mas_equalTo(label1.mas_centerY).offset(0);
//              make.right.mas_equalTo(self.mas_right).offset(-26);
//          }];
//          label3.text = @"物流服务";
//          label3.textColor = COLOR_STR(0x999999);
//          label3.font =[UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)];
//
//          self.logisticsScore = [UIButton new];
//          [self.backView addSubview:self.logisticsScore];
//          [self.logisticsScore mas_makeConstraints:^(MASConstraintMaker *make) {
//              make.top.mas_equalTo(label3.mas_bottom).offset(5);
//              make.centerX.mas_equalTo(label3.mas_centerX).offset(0);
//          }];
//          [self.logisticsScore setTitle:@"5.0" forState:UIControlStateNormal];
//          [self.logisticsScore setTitleColor: COLOR_STR(0xED5F2B) forState:UIControlStateNormal];
//          self.logisticsScore.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)];
//          [self.logisticsScore setImage:[UIImage imageNamed:@"high_bg"] forState:UIControlStateNormal];
//          [self.logisticsScore layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleRight imageTitleSpace:3];
    
    
    self.enterStore.layer.cornerRadius = scale(10);
    self.enterStore.layer.masksToBounds = YES;
    [self.enterStore setTitle:@"进店" forState:UIControlStateNormal];
    [self.enterStore setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
    self.enterStore.titleLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)];
    [self.enterStore setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xDC4761)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
  
          
}
-(void)setIsCircle:(BOOL)isCircle
{
    _isCircle = isCircle;
    if (isCircle == YES) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: self.backView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(14,14)];
        //创建 layer
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.backView.bounds;
        //赋值
        maskLayer.path = maskPath.CGPath;
        self.backView.layer.mask = maskLayer;
    }
}
-(void)setStoreModel:(NSDictionary *)StoreModel
{
    if (isNotNull(StoreModel[@"shop__pict_url"])) {
         [self.storeIcon sd_setImageWithURL:[NSURL URLWithString:StoreModel[@"shop__pict_url"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
    }
   
    self.storeName.text = StoreModel[@"shop_title"];
    self.desScore.text = [NSString stringWithFormat:@"%.1f",[StoreModel[@"shop_dsr"] floatValue]/10000];
    
}
@end
