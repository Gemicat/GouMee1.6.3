//
//  LCBadgeBtn.m
//  ChaHuiTongH
//
//  Created by 锡哥 on 16/4/11.
//  Copyright © 2016年 ChaXinKeJi. All rights reserved.
//

#import "LCVerticalBadgeBtn.h"

@implementation LCVerticalBadgeBtn

- (void)setBadgeString:(NSString *)badgeString{
    _badgeString = badgeString;
    self.badgeLabel = [self viewWithTag:77];
    
    //NNSLog(@"label--%@",label);
    if (self.badgeString && ![self.badgeString isEqualToString:@"0"]) {
        
       // Drawing code
        if (self.badgeLabel) {
            [self.badgeLabel removeFromSuperview];
        }
            self.badgeLabel = [[UILabel alloc]init];
            self.badgeLabel.backgroundColor = COLOR_STR(0xE755B8);
            self.badgeLabel.tag = 77;
    

            self.badgeLabel.layer.masksToBounds = YES;
            self.badgeLabel.layer.cornerRadius = 9;
            self.badgeLabel.textColor = [UIColor whiteColor];
            self.badgeLabel.textAlignment = NSTextAlignmentCenter;
            self.badgeLabel.font = [UIFont systemFontOfSize:10];
         self.badgeLabel.layer.borderWidth = 1.5;
         self.badgeLabel.font = font(10);
                self.badgeLabel.layer.borderColor = [UIColor whiteColor].CGColor;
       
            self.badgeLabel.bounds = CGRectMake(0, 0, 18, 18);
        
            [self addSubview:self.badgeLabel];
        
        
        self.badgeLabel.text = badgeString;
        
        
    }else{
        self.badgeLabel.hidden = YES;
    }
}
-(void)setIsMessage:(NSInteger)isMessage
{
    if (isMessage == 1) {
         self.badgeLabel.backgroundColor = [UIColor whiteColor];
           self.badgeLabel.textColor = ThemeRedColor;
    }
    else if (isMessage == 3)
    {

        self.badgeLabel.backgroundColor =COLOR_STR(0xF93F5A);
        self.badgeLabel.textColor =[UIColor whiteColor];
        self.badgeLabel.layer.borderColor = [UIColor clearColor].CGColor;

    }
    else
    {
        self.badgeLabel.backgroundColor =COLOR_STR(0xF93F5A);
           self.badgeLabel.textColor =[UIColor whiteColor];
    }
  
}
-(void)layoutSubviews {
    [super layoutSubviews];
    
    // 更改image的坐标
    if (self.messageStr.length == 0) {
        CGPoint imageCenter = self.imageView.center;
           imageCenter.x = self.frame.size.width/2;
           imageCenter.y = (self.frame.size.height-self.imageView.frame.size.height)/2;
           self.imageView.center = imageCenter;
           
           // 更改label的坐标
           CGRect labelFrame = self.titleLabel.frame;
           labelFrame.origin.x = 0;
           labelFrame.origin.y = CGRectGetMaxY(self.imageView.frame) + 5;
           labelFrame.size.width = self.frame.size.width;

           self.titleLabel.frame = labelFrame;
           self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
   
    
    //NNSLog(@"btn:(%f,%f,%f,%f)",self.imageView.frame.origin.x,self.imageView.frame.origin.y,self.imageView.frame.size.width,self.imageView.frame.size.height);
    
    //image和label位置更换后，frame改变后再设置角标的值
    if ([self.messageStr isEqualToString:@"直播消息"]) {
        
    if (self.badgeString.length > 1) {
       
        self.badgeLabel.bounds = CGRectMake(0, 0, 28, 18);
           self.badgeLabel.center = CGPointMake(CGRectGetMaxX(self.imageView.frame)+scale(2), scale(8));
    }
    else
    {
        self.badgeLabel.bounds = CGRectMake(0, 0, 18, 18);
           self.badgeLabel.center = CGPointMake(CGRectGetMaxX(self.imageView.frame)-scale(2),scale(8));
    }
        
    }
    else
    {
        if (self.badgeString.length > 1) {
              
               self.badgeLabel.bounds = CGRectMake(0, 0, 28, 18);
                  self.badgeLabel.center = CGPointMake(CGRectGetMaxX(self.imageView.frame)+scale(2), scale(3));
           }
           else
           {
               self.badgeLabel.bounds = CGRectMake(0, 0, 18, 18);
                  self.badgeLabel.center = CGPointMake(CGRectGetMaxX(self.imageView.frame)-scale(2),scale(3));
           }
    }
   

}


@end
