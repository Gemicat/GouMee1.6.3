//
//  PID_SheetView.m
//  GouMee
//
//  Created by 白冰 on 2019/12/19.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "PID_SheetView.h"

@implementation PID_SheetView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, SW, SH);
               self.backgroundColor = COLOR_STR1(0, 0, 0, 0.3);
        [self creaView];
        
    }
    return self;
}
-(void)creaView
{
    
    _backView = [UIView new];
    [self addSubview:_backView];
    _backView.layer.cornerRadius = 8;
    _backView.layer.masksToBounds = YES;
    _backView.backgroundColor = [UIColor whiteColor];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).offset(scaleH(0));
               make.height.mas_equalTo(200);
               make.left.mas_equalTo(80);
               make.centerX.mas_equalTo(0);
    }];
    _topIcon = [UIImageView new];
    [_backView addSubview:_topIcon];
    _topIcon.backgroundColor = [UIColor clearColor];
    [_topIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_backView.mas_top).offset(scaleH(20));
        make.centerX.mas_equalTo(0);

    }];
    _topIcon.image = [UIImage imageNamed:@"sheet_pid"];
    _closeBtn = [UIButton new];
    [_backView addSubview:_closeBtn];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.width.mas_equalTo(30);
    }];
    [_closeBtn setImage:[UIImage imageNamed:@"sheet_close"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(closeclick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _contextLab = [UILabel new];
    [_backView addSubview:_contextLab];
    _contextLab.textColor = COLOR_STR(0x333333);
    _contextLab.font = font1(@"PingFangSC-Semibold", scale(14));
    _contextLab.numberOfLines = 0;
    _contextLab.text = @"您尚未分配淘宝PID，无法\n正常计算返利，请联系下方\n微信获取。";
    _contextLab.attributedText = [self setSpace:5 withFont:font1(@"PingFangSC-Semibold", scale(14)) withstr:_contextLab.text];
    [_contextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topIcon.mas_bottom).offset(scaleH(20));
        make.centerX.mas_equalTo(0);
    }];
    
    _wxBtn = [UIButton new];
    [_backView addSubview:_wxBtn];
    [_wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contextLab.mas_bottom).offset(15);
        make.centerX.mas_equalTo(0);
    }];
   
    [_wxBtn setTitle:@"微信号：18405816254" forState:UIControlStateNormal];
    [_wxBtn setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
    _wxBtn.titleLabel.font = font1(@"PingFangSC-Semibold", scale(12));
    
    
    _copysBtn = [UIButton new];
    [_backView addSubview:_copysBtn];
    [_copysBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_wxBtn.mas_bottom).offset(15);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(_contextLab.mas_left).offset(scale(15));
        make.height.mas_equalTo(scale(30));
    }];
    _copysBtn.layer.cornerRadius = scale(15);
    _copysBtn.layer.masksToBounds = YES;
    _copysBtn.backgroundColor = COLOR_STR(0xD72E51);
   
    [_copysBtn setTitle:@"复制微信号" forState:UIControlStateNormal];
    [_copysBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
    _copysBtn.titleLabel.font = font1(@"PingFangSC-Regular", scale(14));
    [_copysBtn addTarget:self action:@selector(copyclick:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)setContext:(NSString *)context
{
    _context = context;
    _contextLab.text = context;
    if ([context containsString:@"淘口令已复制成功"]) {
        _contextLab.font = font1(@"PingFangSC-Semibold", scale(15));
        _contextLab.textAlignment = NSTextAlignmentCenter;
        [_contextLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(70);
        }];
        _wxBtn.hidden = YES;
      
        [_copysBtn setTitle:@"去抖音上架" forState:UIControlStateNormal];
        [_copysBtn mas_updateConstraints:^(MASConstraintMaker *make) {
              make.top.mas_equalTo(_contextLab.mas_bottom).offset(15);
              make.centerX.mas_equalTo(0);
              make.left.mas_equalTo(_backView.mas_left).offset(scale(30));
              make.height.mas_equalTo(scale(30));
          }];
        [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
                 make.centerY.mas_equalTo(self.mas_centerY).offset(scaleH(0));
                 make.left.mas_equalTo(_contextLab.mas_left).offset(-20);
                 make.centerX.mas_equalTo(0);
                 make.bottom.mas_equalTo(_copysBtn.mas_bottom).offset(15);
             }];
        
    }
    else if ([context containsString:@"图片内容识别失败"])
    {
        [_topIcon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.centerX.mas_equalTo(0);
            make.width.height.mas_equalTo(0);
        }];
        _contextLab.textAlignment = NSTextAlignmentLeft;
              [_contextLab mas_updateConstraints:^(MASConstraintMaker *make) {
                  make.left.mas_equalTo(20);
              }];
              _wxBtn.hidden = YES;
            
              [_copysBtn setTitle:@"知道了" forState:UIControlStateNormal];
              [_copysBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_contextLab.mas_bottom).offset(15);
                    make.centerX.mas_equalTo(0);
                    make.left.mas_equalTo(_backView.mas_left).offset(scale(30));
                    make.height.mas_equalTo(scale(30));
                }];
        [_backView mas_updateConstraints:^(MASConstraintMaker *make) {
                 make.top.mas_equalTo(self.mas_top).offset(scaleH(160));
                 make.left.mas_equalTo(_contextLab.mas_left).offset(-20);
                 make.centerX.mas_equalTo(0);
                 make.bottom.mas_equalTo(_copysBtn.mas_bottom).offset(15);
             }];
        
    }
    else
    {
        _contextLab.numberOfLines = 0;
         [_wxBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleLeft imageTitleSpace:5];
        [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
                 make.top.mas_equalTo(self.mas_top).offset(scaleH(160));
                 make.left.mas_equalTo(_contextLab.mas_left).offset(-20);
                 make.centerX.mas_equalTo(0);
                 make.bottom.mas_equalTo(_copysBtn.mas_bottom).offset(15);
             }];
      
    }
  
    
}
-(void)setContexts:(NSString *)contexts
{
    _contexts = contexts;
       _contextLab.text = contexts;
    UILabel *tips = [UILabel new];
    [_backView addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_closeBtn.mas_centerY).offset(10);
        make.centerX.mas_equalTo(0);
    }];
    tips.textColor = COLOR_STR(0x333333);
    tips.text = @"提现失败";
    _closeBtn.hidden = YES;
    tips.font = font1(@"PingFangSC-Medium", scale(17));
           [_topIcon mas_updateConstraints:^(MASConstraintMaker *make) {
               make.top.mas_equalTo(20);
               make.centerX.mas_equalTo(0);
               make.width.height.mas_equalTo(0);
           }];
           _contextLab.textAlignment = NSTextAlignmentCenter;
                 [_contextLab mas_updateConstraints:^(MASConstraintMaker *make) {
                     make.left.mas_equalTo(20);
                 }];
                 _wxBtn.hidden = YES;
               
                 [_copysBtn setTitle:@"知道了" forState:UIControlStateNormal];
                 [_copysBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                       make.top.mas_equalTo(_contextLab.mas_bottom).offset(15);
                       make.centerX.mas_equalTo(0);
                       make.left.mas_equalTo(60);
                       make.height.mas_equalTo(28);
                   }];
           [_backView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.mas_top).offset(scaleH(160));
                    make.left.mas_equalTo(_contextLab.mas_left).offset(-20);
                    make.centerX.mas_equalTo(0);
                    make.bottom.mas_equalTo(_copysBtn.mas_bottom).offset(15);
                }];
           
     
    
}
-(void)closeclick
{
    [self removeFromSuperview];
}
-(void)copyclick:(UIButton *)sender
{
    
    [self removeFromSuperview];
    if ([sender.titleLabel.text isEqualToString:@"去抖音上架" ]) {
        if (self.click) {
            self.click();
        }
    }
    else
    {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
       pasteboard.string = @"18405816254";
    }
}
-(NSAttributedString *)setSpace:(CGFloat)space withFont:(UIFont*)font withstr:(NSString *)context {
    
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paraStyle.alignment = NSTextAlignmentLeft;
        paraStyle.lineSpacing = space; //设置行间距
        paraStyle.hyphenationFactor = 1.0;
        paraStyle.firstLineHeadIndent = 0.0;
        paraStyle.paragraphSpacingBefore = 0.0;
        paraStyle.headIndent = 0;
        paraStyle.tailIndent = 0;
        //设置字间距 NSKernAttributeName:@1.5f
        NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
                              };
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:context attributes:dic];
    return attributeStr;
        
}
@end
