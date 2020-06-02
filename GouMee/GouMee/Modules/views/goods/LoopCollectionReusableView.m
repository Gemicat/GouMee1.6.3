//
//  LoopCollectionReusableView.m
//  xiaolvlan
//
//  Created by mac on 2019/3/7.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "LoopCollectionReusableView.h"
#import "LoopGoodsImgView.h"
#import "BigImageView.h"
#import "UIView+Gradient.h"
#import "SDCycleScrollView.h"
@interface LoopCollectionReusableView ()<PlanADScrollViewDelegate,SDCycleScrollViewDelegate>
{
    UILabel *brandLab;//标签
    UILabel *goodsName;//商品名称
    UILabel *newPrice;//券后价格
    UILabel *moneyLab;//佣金
    UILabel *oldPrice;//券前价格
    UILabel *saleNum;//月售
    UILabel *typeLab;//券后价
    UILabel *packageLab;//包邮
    UILabel *markLab;

}
@property (nonatomic, strong)SDCycleScrollView *customCellScrollViewDemo;
@property (nonatomic, strong) LoopGoodsImgView *ad;

@end

@implementation LoopCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addTexts:self];

    }
    return self;
}



-(void)setImageUrls:(NSArray *)imageUrls
{
    _imageUrls = imageUrls;
//     [self addLoopImg:self imageUrls:imageUrls];
     _customCellScrollViewDemo.imageURLStringsGroup = imageUrls;
}
- (void)addTexts:(UIView*)view {
    

    _customCellScrollViewDemo = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SW, SW) delegate:self placeholderImage:[UIImage imageNamed:@"goods_bg"]];
//    _customCellScrollViewDemo.currentPageDotImage = [UIImage imageNamed:@"banner_select"];
//    _customCellScrollViewDemo.pageDotImage = [UIImage imageNamed:@"banner_normal"];

    [self addSubview:_customCellScrollViewDemo];
    goodsName = [UILabel new];
    [self addSubview:goodsName];
    goodsName.font =  [UIFont fontWithName:@"PingFangSC-Medium" size:scale(16)];
    goodsName.numberOfLines = 2;
    goodsName.text = @"          ";
    goodsName.textColor = COLOR_STR(0x333333);
    [goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SW+10);
        make.left.mas_equalTo(scale(12));
        make.centerX.mas_equalTo(0);
    }];
    
//    brandLab = [UILabel new];
//    [goodsName addSubview:brandLab];
//    [brandLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(goodsName.mas_top).offset(2);
//        make.left.mas_equalTo(0);
//        make.height.mas_equalTo(15);
//        make.width.mas_equalTo(38);
//    }];


    newPrice = [UILabel new];
    [self addSubview:newPrice];
    [newPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(goodsName.mas_bottom).offset(scale(6));
        make.left.mas_equalTo(goodsName.mas_left).offset(0);
    }];
    newPrice.textColor = ThemeRedColor;

    oldPrice = [UILabel new];
    [self addSubview:oldPrice];
    [oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(newPrice.mas_right).offset(scale(8));
        make.bottom.mas_equalTo(newPrice.mas_bottom).offset(scale(-3));
    }];
    oldPrice.textColor = COLOR_STR(0x8c8c8c);
       oldPrice.font = font(12);
     
    saleNum = [UILabel new];
    [self addSubview:saleNum];
    [saleNum mas_makeConstraints:^(MASConstraintMaker *make) {
       make.bottom.mas_equalTo(newPrice.mas_bottom).offset(scale(-3));
        make.right.mas_equalTo(goodsName.mas_right).offset(0);
    }];
    saleNum.textColor = COLOR_STR(0x999999);
    saleNum.font = font(11);
    saleNum.text = @"  ";
    

    UIView *line1 = [UIView new];
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    line1.backgroundColor = viewColor;

    
}
- (void)addLoopImg:(UIView*)view imageUrls:(NSArray *)imageUrls {
    _ad = [[LoopGoodsImgView alloc] initWithFrame:CGRectMake(0, 0, SW,SW) imageUrls:imageUrls placeholderimage:[UIImage imageNamed:@"goods_bg"]];
    [view addSubview:_ad];
    _ad.pageContolStyle = PlanPageContolStyleNone;
    _ad.delegate = self;

}
- (void)PlanADScrollViewdidSelectAtIndex:(NSInteger)index {
    NSLog(@"点击了第%ld图片", index);
    
    BigImageView *big = [[BigImageView alloc]initWithFrame:CGRectMake(0, 0, SW, SH)];
       big.modelArray = _imageUrls;
        big.count = index;
       [[UIApplication sharedApplication].delegate.window addSubview:big];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    BigImageView *big = [[BigImageView alloc]initWithFrame:CGRectMake(0, 0, SW, SH)];
    big.modelArray = _imageUrls;
    big.count = index;
    [[UIApplication sharedApplication].delegate.window addSubview:big];

}
-(void)setGoodsDTO:(NSDictionary *)goodsDTO
{
   
     NSMutableAttributedString *maTitleString = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@" %@",goodsDTO[@"title"]]];
    UIImage *image;
    if ([goodsDTO[@"user_type"] intValue] == 1) {
        image = [UIImage imageNamed:@"tianmao_icon"];

    }
    else
    {

        image = [UIImage imageNamed:@"taobao_icon"];

    }
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.bounds = CGRectMake(0, -2.5, 36, 16); //这个-2.5是为了调整下标签跟文字的位置
    attach.image = image;
    //添加到富文本对象里
    NSAttributedString * imageStr = [NSAttributedString attributedStringWithAttachment:attach];
    [maTitleString insertAttributedString:imageStr atIndex:0];//加入文字前面

    goodsName.attributedText = maTitleString;

    NSDictionary *fuli = goodsDTO[@"kurangoods"];
    if ([fuli[@"data_source"] integerValue] == 1) {
        if (isNotNull(goodsDTO[@"coupon_amount"])){
            NSString *afterPrice =[NSString stringWithFormat:@"券后价¥%@",[Network removeSuffix:goodsDTO[@"final_price"]]];
            NSMutableAttributedString *newprice = [[NSMutableAttributedString alloc] initWithString:afterPrice];
            [newprice addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)] range:NSMakeRange(2, 1)];
             [newprice addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, 3)];
              [newprice addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:scale(14)] range:NSMakeRange(0, 3)];
            [newprice addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(3, 1)];
            [newprice addAttribute:NSKernAttributeName value:@(4.0) range:NSMakeRange(2, 1)];
            [newprice addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:scale(16)] range:NSMakeRange(4, afterPrice.length-4)];
            newPrice.attributedText = newprice;

            NSString *oldStr =[NSString stringWithFormat:@"现价¥%@",[Network removeSuffix:goodsDTO[@"zk_final_price"]]];
            NSMutableAttributedString *oldprice = [[NSMutableAttributedString alloc] initWithString:oldStr];
            [oldprice addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, oldStr.length )];
            oldPrice.attributedText = oldprice;

        }
        else
        {
            oldPrice.text = @"";
            NSString *afterPrice =[NSString stringWithFormat:@"现价¥%@",[Network removeSuffix:goodsDTO[@"zk_final_price"]]];
            NSMutableAttributedString *newprice = [[NSMutableAttributedString alloc] initWithString:afterPrice];
            [newprice addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)] range:NSMakeRange(2, 1)];
            [newprice addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, 2)];
            [newprice addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:scale(14)] range:NSMakeRange(0, 2)];
            [newprice addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(2, 1)];
            [newprice addAttribute:NSKernAttributeName value:@(4.0) range:NSMakeRange(1, 1)];
            [newprice addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:scale(16)] range:NSMakeRange(3, afterPrice.length-3)];
            newPrice.attributedText = newprice;

        }


    }
    else
    {

        NSString *afterPrice =[NSString stringWithFormat:@"库然价¥%@",[Network removeSuffix:fuli[@"kuran_price"]]];
        NSMutableAttributedString *newprice = [[NSMutableAttributedString alloc] initWithString:afterPrice];
        [newprice addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)] range:NSMakeRange(3, 1)];
        [newprice addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, 3)];
        [newprice addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:scale(14)] range:NSMakeRange(0, 3)];
        [newprice addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(3, 1)];
        [newprice addAttribute:NSKernAttributeName value:@(4.0) range:NSMakeRange(2, 1)];
        [newprice addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:scale(16)] range:NSMakeRange(4, afterPrice.length-4)];
        newPrice.attributedText = newprice;

        NSNumber *a=[NSNumber numberWithFloat:[fuli[@"kuran_price"] floatValue]];
        NSNumber *b=[NSNumber numberWithFloat:[goodsDTO[@"zk_final_price"] floatValue]];
        if ([a compare:b]==NSOrderedAscending) {
       
            NSString *oldStr =[NSString stringWithFormat:@"现价¥%@",[Network removeSuffix:goodsDTO[@"zk_final_price"]]];

            NSMutableAttributedString *oldprice = [[NSMutableAttributedString alloc] initWithString:oldStr];
              [newprice addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(1, 1)];
            oldPrice.attributedText = oldprice;

        }
        else
        {
            oldPrice.text = @"";
        }





    }

     if ([goodsDTO[@"volume"] integerValue] < 10000) {
           saleNum.text = [NSString stringWithFormat:@"月销%@",goodsDTO[@"volume"]];
       }
       else
       {
           
           saleNum.text = [NSString stringWithFormat:@"月销%@万",[Network notRounding:[goodsDTO[@"volume"] floatValue] afterPoint:2]];
       }

}
@end
