//
//  GouMee_PerformanceCenterViewController.m
//  GouMee
//
//  Created by 白冰 on 2019/12/17.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GouMee_PerformanceCenterViewController.h"
#import "PerformRecordViewCell.h"
#import "QFDatePickerView.h"
#import "GouMee_RuleViewController.h"
#import "GouMee_LoginViewController.h"
@interface GouMee_PerformanceCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *payMoneyLab;
    UILabel *willsettleLab;
    UILabel *didsettleLab;
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dates;
@property (nonatomic, strong) NSDictionary *moneyInfo;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat contentY;
@end

@implementation GouMee_PerformanceCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = viewColor;
    self.title = @"业绩中心";
    self.contentY = 0;
    [self.view addSubview:self.scrollView];
   
     [self.view addSubview:self.tableView];

     [self.scrollView addSubview:self.tableView];
     [self addHeadView];
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | //年
    NSMonthCalendarUnit | //月份
    NSDayCalendarUnit | //日
    NSHourCalendarUnit |  //小时
    NSMinuteCalendarUnit |  //分钟
    NSSecondCalendarUnit;  // 秒
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:nowDate];

    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    [self getMoneyUrl:year monthWith:month];
    
   
}
-(void)getMoneyUrl:(NSInteger)year monthWith:(NSInteger)month
{
     NSDictionary *loginModel = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    
    dispatch_group_t group = dispatch_group_create();
               dispatch_queue_t searialQueue = dispatch_queue_create("com.hmc.www", DISPATCH_QUEUE_SERIAL);
               
               dispatch_group_enter(group);
               dispatch_group_async(group, searialQueue, ^{
                   // 网络请求一
                   [Network GET:@"api/v1/pre-statistics/" paramenters:@{@"user":loginModel[@"id"],@"date__year":@(year),@"date__month":@(month)} success:^(id data) {
                              if ([data[@"success"] intValue] == 1) {
                                  self->_dates = [NSMutableArray arrayWithArray:data[@"data"][@"results"]];
                                   [self addTableView];
                              }
                       else
                       {
                           if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
                               [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
                               [[NSUserDefaults standardUserDefaults]synchronize];
                               [Network showMessage:data[@"message"] duration:2.0];
                               GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                               [self.navigationController pushViewController:vc animated:YES];
                           }
                           else
                           {
                           [Network showMessage:data[@"message"] duration:2.0];
                           }
                       }
                        dispatch_group_leave(group);
                              
                                      } error:^(id data) {
                                           dispatch_group_leave(group);
                                      }];
                   
               });
           
            dispatch_group_enter(group);
               dispatch_group_async(group, searialQueue, ^{
               [Network GET:@"api/v1/user-achievements-month/" paramenters:@{@"date__year":@(year),@"date__month":@(month)} success:^(id data) {
                                            if ([data[@"success"] intValue] == 1) {
                                                self->_moneyInfo = [NSDictionary dictionaryWithDictionary:data[@"data"]];
                                              
                                            }
                   else
                   {
                       if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
                           [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
                           [[NSUserDefaults standardUserDefaults]synchronize];
                           [Network showMessage:data[@"message"] duration:2.0];
                           GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                           [self.navigationController pushViewController:vc animated:YES];
                       }
                       else
                       {
                       [Network showMessage:data[@"message"] duration:2.0];
                       }
                   }
                                      dispatch_group_leave(group);
                                            
                                                    } error:^(id data) {
                                                         dispatch_group_leave(group);
                                                    }];
               });
           
            dispatch_group_notify(group, searialQueue, ^{
                   dispatch_async(dispatch_get_global_queue(0, 0), ^{
                       dispatch_async(dispatch_get_main_queue(), ^{
                           // 刷新UI
                           self->payMoneyLab.text = [NSString stringWithFormat:@"%@",self->_moneyInfo[@"paid_pre_income__sum"]];
                           self->willsettleLab.text = [NSString stringWithFormat:@"%@",self->_moneyInfo[@"settled_pre_income__sum"]];
                           self->didsettleLab.text = [NSString stringWithFormat:@"%@",self->_moneyInfo[@"settled_income__sum"]];
                           [self.tableView reloadData];
                       });
                   });
               });

    
}
- (void)updateScrollViewContentSize {
    
    if (self.contentY <= self.scrollView.frame.size.height) {
        
        self.contentY = self.scrollView.frame.size.height + 1;
    }
    
    self.scrollView.contentSize = CGSizeMake(SW, self.contentY+20);
}
-(void)addHeadView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, scale(140))];
    [self.scrollView addSubview:headView];
    
    UIImageView *topView = [UIImageView new];
    [headView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(scale(115));
    }];
    [topView setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xDC4761)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    UIButton *dateBtn  =[UIButton new];
    [headView addSubview:dateBtn];
    [dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headView.mas_centerX).offset(0);
        make.top.mas_equalTo(scale(15));
        
    }];
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | //年
    NSMonthCalendarUnit | //月份
    NSDayCalendarUnit | //日
    NSHourCalendarUnit |  //小时
    NSMinuteCalendarUnit |  //分钟
    NSSecondCalendarUnit;  // 秒
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:nowDate];

    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    [dateBtn setTitle:[NSString stringWithFormat:@"%ld年%ld月",year,month] forState:UIControlStateNormal];
    [dateBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
    dateBtn.titleLabel.font = font1(@"PingFangSC-Medium", scale(18));
    [dateBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *ruleBtn = [UIButton new];
    [headView addSubview:ruleBtn];
    [ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(dateBtn.mas_centerY).offset(0);
        make.right.mas_equalTo(headView.mas_right).offset(-15);
        
    }];
    [ruleBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
    [ruleBtn setTitle:@"说明" forState:UIControlStateNormal];
    [dateBtn setImage:[UIImage imageNamed:@"time_down"] forState:UIControlStateNormal];
    [ruleBtn addTarget:self action:@selector(rule) forControlEvents:UIControlEventTouchUpInside];
    ruleBtn.titleLabel.font = font1(@"PingFangSC-Regular", scale(12));
    [dateBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleRight imageTitleSpace:5];
//    UIImageView *leftIcon = [UIImageView new];
//    [headView addSubview:leftIcon];
//    [leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(headView.left).offset(15);
//        make.centerY.mas_equalTo(dateBtn.mas_centerY).offset(0);
//    }];
//    leftIcon.image = [UIImage imageNamed:@"per_clock"];
//    UIImageView *toppView = [UIImageView new];
//       [headView addSubview:toppView];
//       [toppView mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.top.mas_equalTo(ruleBtn.mas_bottom).offset(scale(-5));
//           make.left.mas_equalTo(headView.mas_left).offset(10);
//           make.centerX.mas_equalTo(0);
//           make.height.mas_equalTo(scale(30));
//       }];
//    toppView.image = [UIImage imageNamed:@"top_icon"];
    UIImageView *backView = [[UIImageView alloc]init];
    [headView addSubview:backView];
    backView.frame = CGRectMake(10, scale(49), SW-20, scale(20));
    backView.image = [UIImage imageNamed:@"kuang_icon"];
    [UIView animateWithDuration:0.5 animations:^{
        backView.frame = CGRectMake(10, scale(49), SW-20, scale(120));
    }];
//
    UILabel *lastLab = nil;
    [backView addSubview:lastLab];
    NSArray *titleArr = @[@"付款预估收入",@"结算预估收入",@"实际结算收入"];
    for (int i= 0; i < 3; i++) {
        UILabel *label = [UILabel new];
        [backView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topView.mas_bottom).offset(0);
            make.width.mas_equalTo(SW/3.0-10);
            if (lastLab) {
                make.left.mas_equalTo(lastLab.mas_right).offset(0);
            }
            else
            {
                make.left.mas_equalTo(backView.mas_left).offset(5);
            }
        }];
        lastLab = label;
        label.textColor = COLOR_STR(0x999999);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = font1(@"PingFangSC-Regular", scale(12));
       
       
        
        UILabel *markLab = [UILabel new];
        [backView addSubview:markLab];
        [markLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(label.mas_top).offset(scale(-15));
            make.centerX.mas_equalTo(label.mas_centerX).offset(0);
            make.left.mas_equalTo(label.mas_left).offset(0);
        }];
        markLab.textColor = COLOR_STR(0x333333);
               markLab.textAlignment = NSTextAlignmentCenter;
               markLab.font = font1(@"PingFangSC-Medium", scale(18));
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    label.text = titleArr[i];
                   });
       
        if (i== 0) {
            payMoneyLab = markLab;
        }
        if (i == 1) {
            willsettleLab = markLab;
        }
        if (i == 2) {
            didsettleLab = markLab;
        }
        
    }
    
       self.contentY += scale(140) + scale(10);
    
}
-(void)rule
{
    GouMee_RuleViewController *vc = [[GouMee_RuleViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)click:(UIButton *)sender
{
    QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithSUperView:self.view response:^(NSString *str) {
        [sender setTitle:str forState:UIControlStateNormal];
       NSString  *str1 = [str stringByReplacingOccurrencesOfString:@"年" withString:@""];;
       NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"月" withString:@""];
        NSInteger year = [[str2 substringToIndex:4] intValue];
         NSInteger month = [[str2 substringFromIndex:4] intValue];
        [self getMoneyUrl:year monthWith:month];
        
        
        
        
        
        
       }];
       [datePickerView show];
}
-(void)addTableView
{
    
    if (self.dates.count > 0) {
         self.tableView.frame = CGRectMake(18.5, scale(175), SW-37, scale(40)*self.dates.count+scale(30));
         self.contentY = scale(40)*self.dates.count +scale(60)+scale(175);
    }
    else
    {
         self.tableView.frame = CGRectMake(18.5, 0, 0,0);
    }
     [self updateScrollViewContentSize];
}
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SW, SH - [self navHeight])];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(SW, SH - [self navHeight] + 1);
        _scrollView.userInteractionEnabled = YES;
        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    
    return _scrollView;
}
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.layer.cornerRadius = 8;
        _tableView.layer.masksToBounds = YES;
        _tableView.scrollEnabled = NO;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.layer.shadowColor = COLOR_STR1(0, 4, 9, 0.1).CGColor;
        //    阴影偏移量
        _tableView.layer.shadowOffset = CGSizeMake(0, 0);
        //    阴影透明度
        _tableView.layer.shadowOpacity = 1;
        //    阴影半径
        _tableView.layer.shadowRadius = 5;
    }
    
    return _tableView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.devices.count;
    if (self.dates.count > 0) {
        return self.dates.count+1;
    }
    return 0;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"PerformRecordViewCell";

    PerformRecordViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        cell1 = [[PerformRecordViewCell alloc]
                 initWithStyle:UITableViewCellStyleValue1
                 reuseIdentifier:CellIdentifier];
    }
    if (indexPath.row == 0) {
        cell1.dateLab.text = @"日期";
        cell1.payNum.text = @"付款笔数";
        cell1.payMoney.text = @"付款预估收入";
        cell1.settleMoney.text = @"结算预估收入";
        cell1.dateLab.textColor = cell1.payMoney.textColor = cell1.payNum.textColor = cell1.settleMoney.textColor = COLOR_STR(0x333333);
        cell1.line.hidden = YES;
    }
    else
    {
         cell1.dateLab.textColor = cell1.payMoney.textColor = cell1.payNum.textColor = cell1.settleMoney.textColor = COLOR_STR(0x999999);
        if (indexPath.row == self.dates.count) {
            cell1.line.hidden = YES;
        }
        else
        {
        cell1.line.hidden = NO;
        }
        if (self.dates) {
            cell1.dateLab.text = _dates[indexPath.row-1][@"date"];
            cell1.payNum.text =[NSString stringWithFormat:@"%@", _dates[indexPath.row-1][@"paid_num"]];
                   cell1.payMoney.text = [NSString stringWithFormat:@"%@",_dates[indexPath.row-1][@"paid_pre_income"]];
                   cell1.settleMoney.text = [NSString stringWithFormat:@"%@",_dates[indexPath.row-1][@"settled_pre_income"]];
        }
    }

   
    return cell1;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return scale(30);
    }
    return scale(40);
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
