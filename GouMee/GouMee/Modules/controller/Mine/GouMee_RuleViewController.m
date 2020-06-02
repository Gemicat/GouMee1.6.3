//
//  GouMee_RuleViewController.m
//  GouMee
//
//  Created by 白冰 on 2019/12/17.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GouMee_RuleViewController.h"

@interface GouMee_RuleViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation GouMee_RuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_STR(0xEAA656);
    self.title = @"说明";
    
         _scrollView = [[UIScrollView alloc] init];
            _scrollView.backgroundColor =  COLOR_STR(0xEAA656);
            [self.view addSubview:_scrollView];
            [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.view.mas_top).offset(0);
                make.left.right.mas_equalTo(0);
                if (@available(iOS 11.0, *)) {
                    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0);
                } else {
                    make.bottom.equalTo(self.view.mas_bottom).offset(0);
                }
            }];

        //    _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight+300);
            _scrollView.bounces = false;
        UIView *containerView = [UIView new];
    containerView.backgroundColor = COLOR_STR(0xEAA656);
       [self.scrollView addSubview:containerView];
      [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.mas_equalTo(self.scrollView);
         make.width.mas_equalTo(self.scrollView);
     }];
    
    UIImageView *leftIcon = [UIImageView new];
       [containerView addSubview:leftIcon];
       [leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(0);
           make.top.mas_equalTo(containerView.mas_top).offset(scale(80));
       }];
       leftIcon.image = [UIImage imageNamed:@"rule_left"];
       
       UIImageView *rightIcon = [UIImageView new];
          [containerView addSubview:rightIcon];
          [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
              make.right.mas_equalTo(0);
              make.top.mas_equalTo(containerView.mas_top).offset(scale(24));
          }];
          rightIcon.image = [UIImage imageNamed:@"rule_right"];

    UILabel *lastLab = nil;
    NSArray *arr = @[
    @"今日新订单预计可赚取的佣金，新订单指下单并付款的订单（未扣除淘宝技术服务费）\n例如 12月1日，A用户购买一支口红下单并付款100元(佣金35元)，则12月1日的付款预估收入为35元，且会计入12月的付款预估收入",
    @"今日执行“确认收货”操作的订单预计可赚取的佣金（未扣除淘宝技术服务费），确认收货后假如发生退货，则无法获得对应的佣金，实际佣金以最终发入余额为准\n例如 上方例子中A用户于12月5日确认收货，则12月5日的结算预估收入为35元，且会计入12月的结算预估收入",
    @"当月确认收货的订单，将于次月25日进行结算，发放到余额，在扣除淘宝官方费用后的实际到手收入（即6月显示的实际结算收入对应的是在5月份确认收货的订单）\n例如 上方例子中A用户的订单35元佣金，假如未发生退款退货，将于1月25日，在扣除技术服务费3.5元后，发放到余额31.5元",
    @"· 技术服务费：结算预估收入的10%\n· 内容场景专项服务费：付款金额的6%",
    @"付款预估收入、结算预估收入是根据用户付款、确认收货行为发生的时间进行统计，同一时间段内的两项数据实际上统计的是不同的订单，所以存在差异属于正常现象\n例如 上方例子中A用户的订单付款预估收入会被统计到12月1日，结算预估收入会被统计到12月5日，实际结算收入会被展示到1月份中"
    ];
    NSArray *titleArr = @[@"付款预估收入",@"结算预估收入",@"实际结算收入",@"淘宝官方费用",@"特别说明"];
    [containerView addSubview:lastLab];
    for (int i = 0; i < arr.count; i++) {
        UILabel *label = [UILabel new];
        [containerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.left.mas_equalTo(scale(70));
            if (lastLab) {
                make.top.mas_equalTo(lastLab.mas_bottom).offset(scale(60));
                                                                
            }
            else
            {
                make.top.mas_equalTo(containerView.mas_top).offset(scale(60));
            }
        }];
        
        lastLab = label;
        label.text = arr[i];
        label.textColor = COLOR_STR(0xFAFAFC);
        label.numberOfLines = 0;
        
         NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
                paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
                paraStyle.alignment = NSTextAlignmentLeft;
//                paraStyle.lineSpacing = 2; //设置行间距
        [paraStyle setParagraphSpacing:scale(10)];
                paraStyle.hyphenationFactor = 1.0;
                paraStyle.firstLineHeadIndent = 0.0;
                paraStyle.paragraphSpacingBefore = 0.0;
                paraStyle.headIndent = 0;
                paraStyle.tailIndent = 0;
                //设置字间距 NSKernAttributeName:@1.5f
        NSDictionary *dic = @{NSFontAttributeName:font1(@"PingFangSC-Regular", scale(12)), NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f,NSForegroundColorAttributeName:COLOR_STR(0xffffff)
                                      };
                NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:label.text attributes:dic];
        label.attributedText = attributeStr;
        label.font = font1(@"PingFangSC-Regular", scale(12));
        UIView *Line = [UIView new];
        [containerView addSubview:Line];
        [Line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.left.mas_equalTo(label.mas_left).offset(20);
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(label.mas_top).offset(-scale(20));
        }];
        Line.backgroundColor = COLOR_STR(0xffffff);
        
        UILabel *titleLab = [UILabel new];
        [containerView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(Line.mas_centerY).offset(0);
            make.left.mas_equalTo(Line.mas_left).offset(50);
        }];
        titleLab.backgroundColor = COLOR_STR(0xEAA656);
        titleLab.text = titleArr[i];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = COLOR_STR(0xffffff);
        titleLab.font = font1(@"PingFangSC-Medium", scale(14));
        
        
        
    }
    
    UIView *line = [UIView new];
    [self.scrollView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastLab.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    line.backgroundColor = [UIColor clearColor];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(line.mas_bottom).offset(10);
            }];
 
    
    
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
