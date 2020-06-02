//
//  WelfareViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/4/18.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "WelfareViewController.h"
#import "YinHotViewController.h"
@interface WelfareViewController ()
{

    NSInteger closeBool;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat contentY;
@end

@implementation WelfareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = viewColor;
    self.title = @"库然专享福利";
    self.contentY = 0;
    [self.view addSubview:self.scrollView];
    [self creatGoodsView];
    [self creatWalView];
    [self creatCouponsView];

    [Network GET:@"api/v1/system-config/close_yinhoc_button/" paramenters:nil success:^(id data) {
        if ([data[@"success"] integerValue] == 1) {

            closeBool = [data[@"data"][@"int_value"] integerValue];

        }
        [self creatCommissionView];
        [self updateScrollViewContentSize];

    } error:^(id data) {

    }];





}
-(void)creatGoodsView
{
    self.contentY = scale(10);
    UIView *goodsView= [[UIView alloc]initWithFrame:CGRectMake(scale(12), self.contentY, SW-scale(24), scale(144))];
    goodsView.backgroundColor = [UIColor whiteColor];
    goodsView.layer.cornerRadius = scale(6);
    goodsView.layer.masksToBounds = YES;
    [self.scrollView addSubview:goodsView];

    UIView *line = [UIView new];
    [goodsView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(33));
        make.left.mas_equalTo(scale(11));
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(scale(0.5));

    }];
    line.backgroundColor = COLOR_STR(0xEFEFEF);

    UILabel *timeLab = [UILabel new];
    [goodsView addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line.mas_left).offset(0);
        make.top.mas_equalTo(goodsView.mas_top).offset(0);
        make.bottom.mas_equalTo(line.mas_top).offset(0);
    }];
    timeLab.font = font(12);
    timeLab.textColor = COLOR_STR(0x333333);


    UILabel *statusLab = [UILabel new];
    [goodsView addSubview:statusLab];
    [statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(line.mas_right).offset(0);
        make.top.mas_equalTo(goodsView.mas_top).offset(0);
        make.bottom.mas_equalTo(line.mas_top).offset(0);
    }];
    statusLab.font = font(12);
    statusLab.textColor = ThemeRedColor;

     statusLab.font= font1(@"PingFangSC-Medium", scale(12));

    UIImageView *goodsIcon = [UIImageView new];
    [goodsView addSubview:goodsIcon];
    [goodsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(scale(12));
        make.bottom.mas_equalTo(goodsView.mas_bottom).offset(scale(-12));
        make.left.mas_equalTo(line.mas_left).offset(scale(0));
        make.width.mas_equalTo(goodsIcon.mas_height);
    }];
    goodsIcon.layer.cornerRadius = scale(6);
    goodsIcon.layer.masksToBounds = YES;


    UILabel *goodsName = [UILabel new];
    [goodsView addSubview:goodsName];
    [goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(goodsIcon.mas_top).offset(0);
        make.left.mas_equalTo(goodsIcon.mas_right).offset(scale(8));
        make.right.mas_equalTo(goodsView.mas_right).offset(scale(-11));
    }];
    goodsName.textColor = COLOR_STR(0x333333);
    goodsName.font = font(14);

    goodsName.numberOfLines = 2;

  UILabel  *currentPrice = [UILabel new];
    [goodsView addSubview:currentPrice];
    [currentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(goodsName.mas_bottom).offset(scale(10));
        make.left.mas_equalTo(goodsName.mas_left).offset(0);
    }];
    currentPrice.textColor = ThemeRedColor;
    currentPrice.font = font1(@"PingFangSC-Medium", scale(21));

    UILabel *oldPrice = [UILabel new];
    [goodsView addSubview:oldPrice];
    oldPrice.font = font(12);
    oldPrice.textColor = COLOR_STR(0x999999);
    [oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(currentPrice.mas_bottom).offset(scale(-4));
        make.left.mas_equalTo(currentPrice.mas_right).offset(6);
    }];
    goodsName.text = self.model[@"good_info"][@"title"];
    if (isNotNull(self.model[@"good_info"][@"white_image"])) {
        [goodsIcon sd_setImageWithURL:[NSURL URLWithString:self.model[@"good_info"][@"white_image"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
    }
    else
    {
        [goodsIcon sd_setImageWithURL:[NSURL URLWithString:self.model[@"good_info"][@"pict_url"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
    }

    NSInteger apply_status = [self.model[@"apply_status"] intValue];
    switch (apply_status) {

        case 1:
        {
            statusLab.text = @"未发货";
            statusLab.textColor =ThemeRedColor;
        }
            break;
        case 2:
            statusLab.text = @"途中";
            statusLab.textColor =COLOR_STR(0x1B9747);
            break;
        case 3:
            statusLab.text = @"已到样";
            statusLab.textColor =COLOR_STR(0x1B9747);
            break;


        default:
            break;
    }



    NSInteger status = [self.model[@"live_type"] intValue];
    NSDictionary *fuli = self.model[@"kurangoods"];

    if (status == 1) {

        NSArray *arr = self.model[@"price_json"];
        NSString *price;
        if (arr.count == 1) {
            price =[NSString stringWithFormat:@"¥%@", [Network removeSuffix:arr.firstObject[@"price"]]] ;
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:price];
            // 需要改变的区间(第一个参数，从第几位起，长度)
            NSRange range = NSMakeRange(0, 1);
            // 改变字体大小及类型
            [noteStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, 1)];
            [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:range];
            currentPrice.attributedText = noteStr;
            NSNumber *a=[NSNumber numberWithFloat:[self.model[@"good_info"][@"zk_final_price"] floatValue]];
            NSNumber *b=[NSNumber numberWithFloat:[arr.firstObject[@"price"] floatValue]];
            if ([a compare:b]==1) {
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",[Network removeSuffix:self.model[@"good_info"][@"zk_final_price"] ]]];
                [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
                oldPrice.attributedText = str;
            }
            else
            {
                oldPrice.text = @"";
            }
        }
        else
        {
            NSMutableArray *priceArr = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                [priceArr addObject:[Network removeSuffix:dic[@"price"]]];
            }
            CGFloat max =[[priceArr valueForKeyPath:@"@max.floatValue"] floatValue];
            CGFloat min =[[priceArr valueForKeyPath:@"@min.floatValue"] floatValue];
            price =[NSString stringWithFormat:@"¥%@起", [Network removeSuffix:[priceArr valueForKeyPath:@"@min.doubleValue"]]] ;
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:price];
            // 需要改变的区间(第一个参数，从第几位起，长度)
            NSRange range = NSMakeRange(0, 1);
            // 改变字体大小及类型
            [noteStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, 1)];
            [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:range];
             [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:NSMakeRange(price.length-1, 1)];
            currentPrice.attributedText = noteStr;

            NSNumber *a=[NSNumber numberWithFloat:[self.model[@"good_info"][@"zk_final_price"] floatValue]];
            NSNumber *b=[NSNumber numberWithFloat:min];
            if ([a compare:b]==1) {
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",[Network removeSuffix:self.model[@"good_info"][@"zk_final_price"] ]]];
                [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
                oldPrice.attributedText = str;
            }
            else
            {
                oldPrice.text = @"";
            }

        }



    }
    else
    {

        if ([fuli[@"data_source"] integerValue] != 1) {
            NSString *price =[NSString stringWithFormat:@"¥%@", [Network removeSuffix:fuli[@"kuran_price"]]] ;
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:price];
            // 需要改变的区间(第一个参数，从第几位起，长度)
            NSRange range = NSMakeRange(0, 1);
            // 改变字体大小及类型
            [noteStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, 1)];
            [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:range];
            currentPrice.attributedText = noteStr;

            NSNumber *a=[NSNumber numberWithFloat:[fuli[@"kuran_price"] floatValue]];
            NSNumber *b=[NSNumber numberWithFloat:[self.model[@"good_info"][@"zk_final_price"] floatValue]];
            if ([a compare:b]==-1) {
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",[Network removeSuffix:self.model[@"good_info"][@"zk_final_price"] ]]];
                [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
                oldPrice.attributedText = str;
            }
            else
            {
                oldPrice.text = @"";
            }

        }
        else
        {
            NSString  *price =[NSString stringWithFormat:@"¥%@", [Network removeSuffix:self.model[@"good_info"][@"final_price"] ]] ;
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:price];
            // 需要改变的区间(第一个参数，从第几位起，长度)
            NSRange range = NSMakeRange(0, 1);
            // 改变字体大小及类型
            [noteStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, 1)];
            [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:range];
            currentPrice.attributedText = noteStr;


            if (isNotNull(self.model[@"good_info"][@"coupon_amount"])) {
                NSString *straa = [NSString stringWithFormat:@"￥%@",[Network removeSuffix:self.model[@"good_info"][@"zk_final_price"] ]];
                NSMutableAttributedString *strs = [[NSMutableAttributedString alloc] initWithString:straa];
                [strs addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, straa.length)];
            oldPrice.attributedText = strs;
            }

        }

    }

    NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:self.model[@"start_time"] andFormatter:@"YYY-MM-dd HH:mm:ss"] andFormatter:@"HH:mm"];
    timeLab.text = [NSString stringWithFormat:@"%@ 开播",time];


    self.contentY += scale(144);
}
-(void)creatWalView
{


 NSMutableArray *titleArr = [NSMutableArray array];
    NSMutableArray *contextArr = [NSMutableArray array];
    if (isNotNull(self.model[@"kurangoods"][@"reduction_amount"])) {
        [titleArr addObject:@"拍下立减"];
        [contextArr addObject:[NSString stringWithFormat:@"立减%@元",[Network removeSuffix:self.model[@"kurangoods"][@"reduction_amount"]]]];
    }
    if (isNotNull(self.model[@"kurangoods"][@"buy_send"])) {
        [titleArr addObject:@"拍下多发"];
        [contextArr addObject:[NSString stringWithFormat:@"拍%@发%@",self.model[@"kurangoods"][@"buy_send"][@"buy_count"],self.model[@"kurangoods"][@"buy_send"][@"send_count"]]];
    }
    if (isNotNull(self.model[@"kurangoods"][@"gift_info"])) {
        [titleArr addObject:@"专属赠品"];
        [contextArr addObject:self.model[@"kurangoods"][@"gift_info"]];
    }
    if (titleArr.count > 0) {
    self.contentY += scale(10);
    UIView *goodsView= [[UIView alloc]init];
    goodsView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:goodsView];
    goodsView.layer.cornerRadius = scale(6);
   goodsView.layer.masksToBounds = YES;

    UILabel *lastLab = nil;
    [goodsView addSubview:lastLab];
        CGFloat h = scale(0);
        CGSize baseSize = CGSizeMake(SW-scale(124), CGFLOAT_MAX);

    for (int i = 0; i <titleArr.count; i++) {

        UILabel *label = [UILabel new];
        [goodsView addSubview:label];
        label.numberOfLines = 0;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(scale(88));
            make.right.mas_equalTo(goodsView.mas_right).offset(scale(-12));
            if (lastLab) {
                make.top.mas_equalTo(lastLab.mas_bottom).offset(scale(12));
            }
            else
            {
                make.top.mas_equalTo(goodsView.mas_top).offset(scale(12));

            }
        }];
        label.text = contextArr[i];
        label.textColor = COLOR_STR(0x333333);
        label.font = font(14);
        lastLab = label;
          CGSize labelsize = [label sizeThatFits:baseSize];
        h = scale(12)+ labelsize.height+h;

        UILabel *markLab = [UILabel new];
        [goodsView addSubview:markLab];
        [markLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label.mas_top).offset(0);
            make.left.mas_equalTo(scale(12));
        }];
        markLab.text = titleArr[i];
        markLab.textColor = COLOR_STR(0x666666);
        markLab.font = font(14);
    }
        if (isNotNull(self.model[@"kurangoods"][@"buy_remark"])) {

            UILabel *label = [UILabel new];
            [goodsView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lastLab.mas_bottom).offset(scale(12));
                make.left.mas_equalTo(scale(12));
            }];
            label.textColor = COLOR_STR(0x333333);
            label.font = font1(@"PingFangSC-Semibold", scale(14));
            label.text = @"请在下单时备注：";
            CGSize labelsize = [label sizeThatFits:baseSize];
            h = scale(12)+ labelsize.height+h;
            UILabel *labels = [UILabel new];
            [goodsView addSubview:labels];
            [labels mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(label.mas_bottom).offset(scale(12));
                make.left.mas_equalTo(scale(12));
                make.centerX.mas_equalTo(0);
            }];
            labels.numberOfLines = 0;
            labels.textColor = COLOR_STR(0x333333);
            labels.font = font(14);
            labels.text = self.model[@"kurangoods"][@"buy_remark"];

            CGSize labelsize1 = [labels sizeThatFits:baseSize];
            h = scale(12)+ labelsize1.height+h;
        }



        goodsView.frame = CGRectMake(scale(12), self.contentY, SW-scale(24), h+scale(12));
         self.contentY += h+scale(12);
    }





}
-(void)creatCouponsView
{
    if (isNotNull(self.model[@"kurangoods"][@"coupon_amount"])) {

    self.contentY += scale(10);
    UIView *goodsView= [[UIView alloc]initWithFrame:CGRectMake(12, self.contentY, SW-scale(24), scale(84))];
    goodsView.backgroundColor = [UIColor whiteColor];
    goodsView.layer.cornerRadius = scale(6);
    goodsView.layer.masksToBounds = YES;
    [self.scrollView addSubview:goodsView];

    UILabel *label = [UILabel new];
    [goodsView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scale(12));
        make.top.mas_equalTo(scale(12));
        make.width.mas_equalTo(scale(68));
    }];
    label.textColor = COLOR_STR(0x666666);
    label.font = font(14);
    label.text = @"优惠券";

    UILabel *conpond = [UILabel new];
    [goodsView addSubview:conpond];
    [conpond mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_top).offset(0);
        make.left.mas_equalTo(label.mas_right).offset(scale(8));
        make.right.mas_equalTo(scale(-12));
    }];

    conpond.textColor = COLOR_STR(0x999999);
    conpond.font = font(14);
    NSString *num = [Network removeSuffix:self.model[@"kurangoods"][@"coupon_amount"]];
    if (isNotNull(self.model[@"kurangoods"][@"coupon_end_time"])) {
        NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:self.model[@"kurangoods"][@"coupon_end_time"] andFormatter:@"YYY-MM-dd"] andFormatter:@"YYY.MM.dd"];
        conpond.text =[NSString stringWithFormat:@"%@元（%@过期）",num,time] ;
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:conpond.text];
        [attriStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, num.length+1)];

        conpond.attributedText = attriStr;
    }
    else
    {
       conpond.text =[NSString stringWithFormat:@"%@元",num] ;
         conpond.textColor = COLOR_STR(0x333333);
    }



    UIButton *copyBtn = [UIButton new];
    [goodsView addSubview:copyBtn];
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(scale(12));
        make.left.mas_equalTo(conpond.mas_left).offset(0);
        make.width.mas_equalTo(scale(108));
        make.height.mas_equalTo(scale(30));
    }];
    copyBtn.layer.cornerRadius = scale(15);
    copyBtn.layer.masksToBounds = YES;
    copyBtn.layer.borderColor = ThemeRedColor.CGColor;
    copyBtn.layer.borderWidth = 1;
    [copyBtn setTitle:@"复制领券链接" forState:UIControlStateNormal];
    [copyBtn setTitleColor:ThemeRedColor forState:UIControlStateNormal];
    copyBtn.titleLabel.font = font(14);
        [copyBtn addTarget:self action:@selector(copyConpon) forControlEvents:UIControlEventTouchUpInside];


    self.contentY += scale(84);
    }

}
-(void)copyConpon
{
    if (isNotNull(self.model[@"kurangoods"][@"coupon_url"])) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];

        pasteboard.string = self.model[@"kurangoods"][@"coupon_url"];
        [Network showMessages:@"已复制优惠券领取链接" duration:2.0 picture:@"feed_success"];
    }

}
-(void)creatCommissionView
{

    if ([self.model[@"kurangoods"][@"commission"] floatValue] > 0) {

    self.contentY += scale(10);
    UIView *goodsView= [[UIView alloc]initWithFrame:CGRectMake(12, self.contentY, SW-scale(24), scale(89))];
    goodsView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:goodsView];
    goodsView.layer.cornerRadius = scale(6);
    goodsView.layer.masksToBounds = YES;
    UILabel *label = [UILabel new];
    [goodsView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scale(12));
        make.top.mas_equalTo(scale(10));
        make.width.mas_equalTo(scale(68));
    }];
    label.textColor = COLOR_STR(0x666666);
    label.font = font(14);
    label.text = @"库然高佣";

    UILabel *conpond = [UILabel new];
    [goodsView addSubview:conpond];
    [conpond mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_top).offset(0);
        make.left.mas_equalTo(label.mas_right).offset(scale(8));
        make.right.mas_equalTo(scale(-12));
    }];

    conpond.textColor = COLOR_STR(0x999999);
    conpond.font = font(14);
         NSArray *arr = self.model[@"price_json"];
    NSString *div_Money = [NSString stringWithFormat:@"%@%%",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([self.model[@"kurangoods"][@"commission_rate"] floatValue]/100)]]];
        NSString *aa;
        if ([self.model[@"live_type"] integerValue] == 2) {
 aa= [NSString stringWithFormat:@"%@",[Network removeSuffix:self.model[@"kurangoods"][@"commission"]]];
        }
        else
        {
        if (arr.count == 1) {

            aa= [NSString stringWithFormat:@"%@",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([div_Money floatValue]*[arr.firstObject[@"price"] floatValue]/100)]]];
        }
        else
        {
            NSMutableArray *priceArr = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                [priceArr addObject:[Network removeSuffix:dic[@"price"] ]];
            }
            CGFloat max =[[priceArr valueForKeyPath:@"@max.floatValue"] floatValue];
            CGFloat min =[[priceArr valueForKeyPath:@"@min.floatValue"] floatValue];

 aa= [NSString stringWithFormat:@"%@~%@",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",min*[div_Money floatValue]/100]],[NSString stringWithFormat:@"%.2f",max*[div_Money floatValue]/100]];

        }
        }
    conpond.text=[NSString stringWithFormat: @"%@（预计¥%@）",div_Money,aa];
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:conpond.text];
        [attriStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, div_Money.length)];

        conpond.attributedText = attriStr;
    UIButton *applyBtn = [UIButton new];
    [goodsView addSubview:applyBtn];

    applyBtn.layer.cornerRadius = scale(15);
    applyBtn.layer.masksToBounds = YES;
    applyBtn.backgroundColor = ThemeRedColor;
    [applyBtn setTitle:@"【萤火虫】一键申请" forState:UIControlStateNormal];
    [applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    applyBtn.titleLabel.font = font(14);
    [applyBtn addTarget:self action:@selector(zmmmm) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *rightIcon = [UIImageView new];
    [goodsView addSubview:rightIcon];

    rightIcon.image = [UIImage imageNamed:@"hot_icon"];

    UIButton *copyBtn = [UIButton new];
    [goodsView addSubview:copyBtn];
    if (closeBool == 1) {
        [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label.mas_bottom).offset(scale(12));
            make.left.mas_equalTo(conpond.mas_left).offset(0);
            make.width.mas_equalTo(scale(108));
            make.height.mas_equalTo(scale(30));
        }];
    }
    else
    {
    [applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(scale(17));
        make.left.mas_equalTo(goodsView.mas_left).offset(scale(30));
        make.width.mas_equalTo(scale(150));
        make.height.mas_equalTo(scale(30));
    }];
    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(applyBtn.mas_right).offset(scale(-12));
        make.bottom.mas_equalTo(applyBtn.mas_top).offset(scale(10));
    }];
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(scale(17));
        make.left.mas_equalTo(applyBtn.mas_right).offset(scale(33));
        make.width.mas_equalTo(scale(108));
        make.height.mas_equalTo(scale(30));
    }];
    }
    copyBtn.layer.cornerRadius = scale(15);
    copyBtn.layer.masksToBounds = YES;
    copyBtn.layer.borderColor = ThemeRedColor.CGColor;
    copyBtn.layer.borderWidth = 1;
    [copyBtn setTitle:@"复制申请链接" forState:UIControlStateNormal];
    [copyBtn setTitleColor:ThemeRedColor forState:UIControlStateNormal];
    copyBtn.titleLabel.font = font(14);
    [copyBtn addTarget:self action:@selector(copyApply) forControlEvents:UIControlEventTouchUpInside];


    self.contentY += scale(89);
    }

}
-(void)zmmmm
{
    YinHotViewController *vc = [[YinHotViewController alloc]init];

    [self.navigationController pushViewController:vc animated:YES];
}
-(void)copyApply
{
    if (isNotNull(self.model[@"kurangoods"][@"commission_url"])) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];

        pasteboard.string = self.model[@"kurangoods"][@"commission_url"];
        [Network showMessages:@"已复制申请链接" duration:2.0 picture:@"feed_success"];
    }

}
- (void)updateScrollViewContentSize {

    if (self.contentY <= self.scrollView.frame.size.height) {

        self.contentY = self.scrollView.frame.size.height + 1;
    }

    self.scrollView.contentSize = CGSizeMake(SW, self.contentY);
}

#pragma mark - getter
- (UIScrollView *)scrollView {

    if (!_scrollView) {

        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SW, self.view.frame.size.height)];
        _scrollView.backgroundColor = viewColor;
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.contentSize = CGSizeMake(SW, SH+ 1);
        _scrollView.userInteractionEnabled = YES;
        //        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }

    return _scrollView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
