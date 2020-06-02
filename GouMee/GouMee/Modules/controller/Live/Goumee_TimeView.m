//
//  Goumee_TimeView.m
//  GouMee
//
//  Created by 白冰 on 2020/3/11.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "Goumee_TimeView.h"
#import "ShuKeTimerPickerView.h"
#import "CXDatePickerView.h"
@interface Goumee_TimeView ()<ShuKeTimerPickerViewDelegate>
{
    UILabel *timeLab;
    NSString *timeStr;
    NSString *lowStr;
    NSString *highStr;
    NSString *setBool;
    
}
@property (nonatomic, strong) ShuKeTimerPickerView *pickerView;
@end


@implementation Goumee_TimeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_STR1(0, 0, 0, 0.3);
        [self createInterface];
    }
    return self;
}

-(void)createInterface
{
    
  
    setBool = @"0";
    UIView *backView =[UIView new];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
        make.width.mas_equalTo(scale(210));
    }];
    backView.backgroundColor = COLOR_STR(0xffffff);
    
    UIView *sheetView = [UIView new];
      [self addSubview:sheetView];
      sheetView.backgroundColor = self.backgroundColor;
    [sheetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
        make.right.mas_equalTo(backView.mas_left).offset(0);
    }];
       UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
          [sheetView addGestureRecognizer:tap];
    
    UILabel *tip = [UILabel new];
    [backView addSubview:tip];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backView.mas_left).offset(scale(10));
        make.top.mas_equalTo(backView.mas_top).offset([UIApplication sharedApplication].statusBarFrame.size.height+20);
    }];
    tip.textColor = COLOR_STR(0x999999);
    tip.font = font(12);
    tip.text = @"开播日期";
    
    UIView *views = [UIView new];
    [backView addSubview:views];
    views.userInteractionEnabled =YES;
    backView.userInteractionEnabled = YES;
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tip.mas_bottom).offset(scale(20));
        make.left.mas_equalTo(scale(10));
        make.centerX.mas_equalTo(backView.mas_centerX).offset(0);
        make.height.mas_equalTo(scale(30));
    }];
    views.layer.cornerRadius = scale(15);
    views.layer.masksToBounds = YES;
    views.backgroundColor =viewColor;
    
    timeLab = [UILabel new];
    [ views addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(scale(20));
    }];
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"shuai_day"];
    if (isNotNull(str)) {
        timeLab.text = str;
        timeStr = str;
         timeLab.textColor = COLOR_STR(0x333333);
    }
    else
    {
    timeLab.text = @"选择日期";
         timeLab.textColor = COLOR_STR(0xcccccc);
    }
    timeLab.font = font(10);
   
    timeLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *timeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(times)];
    [timeLab addGestureRecognizer:timeTap];
    UIView *line = [UIView new];
    [backView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(views.mas_bottom).offset(scale(20));
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    line.backgroundColor = COLOR_STR(0xf5f5f5);
    
    
    UILabel *tips = [UILabel new];
    [backView addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(scale(15));
        make.left.mas_equalTo(tip.mas_left).offset(0);
    }];
    tips.textColor = COLOR_STR(0x999999);
       tips.font = font(12);
       tips.text = @"开播时间";
    
    
    UIButton *lastBtn = nil;
    [backView addSubview:lastBtn];
    NSArray *arr = @[@"00:00-12:00",@"12:00-18:00",@"18:00-24:00"];
    NSString *times = [[NSUserDefaults standardUserDefaults]objectForKey:@"shuai_time"];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton new];
        [backView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i < 2) {
                make.top.mas_equalTo(tips.mas_bottom).offset(scale(10));
                if (lastBtn) {
                    make.left.mas_equalTo(backView.mas_centerX).offset(scale(5));
                    make.right.mas_equalTo(backView.mas_right).offset(scale(-10));
                }
                else
                {
                    make.left.mas_equalTo(backView.mas_left).offset(scale(10));
                    make.right.mas_equalTo(backView.mas_centerX).offset(scale(-5));
                }
                
            }
            else
            {
                make.top.mas_equalTo(lastBtn.mas_bottom).offset(scale(5));
                make.left.mas_equalTo(backView.mas_left).offset(scale(10));
                make.right.mas_equalTo(backView.mas_centerX).offset(scale(-5));
            }
            make.height.mas_equalTo(scale(30));
        }];
        button.tag = i+3000;
        lastBtn = button;
        
        UIImageView *righticon = [UIImageView new];
        [button addSubview:righticon];
        [righticon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(0);
        }];
        righticon.image = [UIImage imageNamed:@"select_bg"];
        if (isNotNull(times)) {
            if ([times isEqualToString:arr[i]]) {
                righticon.hidden = NO;
                if (i == 0) {
                       lowStr = @"00:00";
                       highStr = @"12:00";
                      
                   }
                   else if (i == 1)
                   {
                       lowStr = @"12:00";
                       highStr = @"18:00";
                    
                   }
                   else
                   {
                       lowStr = @"18:00";
                       highStr = @"00:00";
                     
                   }
                button.backgroundColor = COLOR_STR1(215, 46, 81, 0.2);
                  
                   [button setTitleColor:ThemeRedColor forState:UIControlStateNormal];
              
            }
            else
            {
                righticon.hidden = YES;
                button.backgroundColor = COLOR_STR(0xE6E6E6);
                       
                       [button setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
            }
        }
        else
        {
        righticon.hidden = YES;
            button.backgroundColor = COLOR_STR(0xE6E6E6);
                   
                   [button setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
        }
        righticon.tag = 4000+i;
       
        button.layer.cornerRadius = 2.5;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = font(11);
        [button setTitle:arr[i] forState:UIControlStateNormal];
       
        [button addTarget:self action:@selector(xxx:) forControlEvents:UIControlEventTouchUpInside];
        
    }

    UIView *bottomView = [UIView new];
       [backView addSubview:bottomView];
       [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
           if (@available(iOS 11.0, *)) {
                      make.bottom.equalTo(backView.mas_safeAreaLayoutGuideBottom).offset(-20);
                  } else {
                      make.bottom.equalTo(backView.mas_bottom).offset(-20);
                  }
           make.left.mas_equalTo(backView.mas_left).offset(52);
           make.right.mas_equalTo(backView.mas_right).offset(-15);
           make.height.mas_equalTo(scale(35));
       }];
       bottomView.layer.cornerRadius = scale(35)/2.0;
       bottomView.layer.masksToBounds = YES;
       
       UIButton *sureBtn = [UIButton new];
       [bottomView addSubview:sureBtn];
       [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.right.bottom.mas_equalTo(0);
           make.left.mas_equalTo(bottomView.mas_centerX).offset(0);
           
       }];
       [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
       [sureBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
       sureBtn.titleLabel.font = font(12);
       [sureBtn setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xD72E51)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
       [sureBtn addTarget:self action:@selector(zzzz) forControlEvents:UIControlEventTouchUpInside];
       UIButton *cancelBtn = [UIButton new];
       [bottomView addSubview:cancelBtn];
       [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.left.bottom.mas_equalTo(0);
           make.right.mas_equalTo(bottomView.mas_centerX).offset(0);
           
       }];
       [cancelBtn setTitle:@"重置" forState:UIControlStateNormal];
       [cancelBtn setTitleColor:COLOR_STR(0x999999) forState:UIControlStateNormal];
       cancelBtn.titleLabel.font = font(12);
       cancelBtn.backgroundColor = COLOR_STR(0xf2f2f2);
       [cancelBtn addTarget:self action:@selector(xxxx) forControlEvents:UIControlEventTouchUpInside];
  
}
-(void)zzzz
{
    if (timeStr.length == 0) {
        timeStr = @"";
    }
    if (lowStr.length == 0) {
        lowStr = @"";
        highStr = @"";
    }
    if ([setBool isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"shuai_day"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shuai_time"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
        
        if (self.click) {
               self.click(timeStr, lowStr, highStr);
           }
   
   
    [self removeFromSuperview];
    
}
-(void)xxxx
{
   for (int i = 0; i < 3; i++) {
        UIButton *button = [self viewWithTag:3000+i];
        button.backgroundColor = COLOR_STR(0xE6E6E6);
        
        [button setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
        UIImageView *img = [self viewWithTag:4000+i];
        img.hidden = YES;
    }
    timeStr = @"";
    lowStr = @"";
    highStr = @"";
    timeLab.text = @"选择日期";
    setBool = @"1";
    
}
-(void)times
{
 CXDatePickerView *vc = [[CXDatePickerView alloc]initWithDateStyle:CXDateStyleShowYearMonthDay CompleteBlock:^(NSDate *date) {
      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateFormat:@"yyyy-MM-dd"];
      NSString *strDate = [dateFormatter stringFromDate:date];
      NSLog(@"--------%@", strDate);
     timeLab.text = strDate;
     timeStr = strDate;
     timeLab.textColor = COLOR_STR(0x333333);
     [[NSUserDefaults standardUserDefaults] setObject:strDate forKey:@"shuai_day"];
        [[NSUserDefaults standardUserDefaults] synchronize];
     
 }];
    vc.hideBackgroundYearLabel = YES;
 [vc show];
      
}
-(void)xxx:(UIButton *)sender
{
   
    for (int i = 0; i < 3; i++) {
        UIButton *button = [self viewWithTag:3000+i];
        button.backgroundColor = COLOR_STR(0xE6E6E6);
        
        [button setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
        UIImageView *img = [self viewWithTag:4000+i];
        img.hidden = YES;
    }
    sender.backgroundColor = COLOR_STR1(215, 46, 81, 0.2);
   
    [sender setTitleColor:ThemeRedColor forState:UIControlStateNormal];
    UIImageView *imgs = [self viewWithTag:sender.tag+1000];
           imgs.hidden = NO;
    if (sender.tag == 3000) {
        lowStr = @"00:00";
        highStr = @"12:00";
        [[NSUserDefaults standardUserDefaults] setObject:@"00:00-12:00" forKey:@"shuai_time"];
           [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if (sender.tag == 3001)
    {
        lowStr = @"12:00";
        highStr = @"18:00";
        [[NSUserDefaults standardUserDefaults] setObject:@"12:00-18:00" forKey:@"shuai_time"];
           [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        lowStr = @"18:00";
        highStr = @"00:00";
        [[NSUserDefaults standardUserDefaults] setObject:@"18:00-24:00" forKey:@"shuai_time"];
           [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
-(void)back
{
    [self removeFromSuperview];
}
- (NSString *)getNowDate:(NSString*)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *datenow = [NSDate date];
    return [formatter stringFromDate:datenow];
}
- (void)toobarDonBtnHaveClick:(ShuKeTimerPickerView *)pickView resultString:(NSString *)resultString atIndexof:(NSInteger)indexRow
{
    timeStr = resultString;
    timeLab.textColor = COLOR_STR(0x333333);
    timeLab.text = resultString;
   
 
}

- (void)toobarCancelBtn {
    NSLog(@" ==== delegate => toobarCancelBtn");
}
@end
