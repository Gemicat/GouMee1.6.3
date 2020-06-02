//
//  GouMee_CertificationStatusViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/1/11.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GouMee_CertificationStatusViewController.h"
#import "GouMee_BalanceViewController.h"
#import "AccountMessageViewController.h"
#import "GouMee_AuthenticationViewController.h"
@interface GouMee_CertificationStatusViewController ()

@end

@implementation GouMee_CertificationStatusViewController

-(void)hahha
{
    for(UIViewController*controller in self.navigationController.viewControllers) {

    if([controller isKindOfClass:[GouMee_BalanceViewController class]]) {

       GouMee_BalanceViewController *revise =(GouMee_BalanceViewController *)controller;
    [self.navigationController popToViewController:revise animated:YES];

                }

        if([controller isKindOfClass:[AccountMessageViewController class]]) {

               AccountMessageViewController *vc=(AccountMessageViewController *)controller;
            [self.navigationController popToViewController:vc animated:YES];

                        }


            }

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"实名认证";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *topIcon = [UIImageView new];
    [self.view addSubview:topIcon];
    [topIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(50));
        make.centerX.mas_equalTo(0);
    }];
    UIImage *img = [[UIImage imageNamed:@"nav"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(hahha)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel *tips = [UILabel new];
    [self.view addSubview:tips];
   
    tips.textColor = COLOR_STR(0x333333);
    tips.font = font1(@"PingFangSC-Regular", scale(15));
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topIcon.mas_bottom).offset(20);
        make.centerX.mas_equalTo(0);
    }];
    
    UILabel *tipss = [UILabel new];
       [self.view addSubview:tipss];
       tipss.text = @"失败原因";
    tipss.numberOfLines = 0;
       tipss.textColor = COLOR_STR(0x999999);
       tipss.font = font1(@"PingFangSC-Regular", scale(15));
       [tipss mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(tips.mas_bottom).offset(20);
           make.centerX.mas_equalTo(0);
           make.left.mas_equalTo(30);
           
       }];
    tipss.textAlignment = NSTextAlignmentCenter;
    
    
    UIButton *certainBtn = [UIButton new];
    [self.view addSubview:certainBtn];
    
    [certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerX.mas_equalTo(0);
              make.left.mas_equalTo(30);
              make.height.mas_equalTo(scale(44));
              make.top.mas_equalTo(tipss.mas_bottom).offset(scale(66));
          }];
          [certainBtn setTitle:@"重新认证" forState:UIControlStateNormal];
          [certainBtn setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xDC4761)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
          certainBtn.layer.cornerRadius = scale(22);
          certainBtn.layer.masksToBounds = YES;
          [certainBtn addTarget:self action:@selector(certainss) forControlEvents:UIControlEventTouchUpInside];
    
     NSInteger status = [self.model[@"identity_status"] intValue];
    if (status == 2) {
       certainBtn.hidden = NO;
             tipss.hidden = NO;
             tipss.text = self.model[@"identity_fail_reasons"];
             topIcon.image = [UIImage imageNamed:@"auth_fail"];
         tips.text = @"您的实名认证资料审核未通过";
    
    }
    else
    {
        certainBtn.hidden = YES;
               tipss.hidden = YES;
         tips.text = @"您的实名认证资料正在审核中";
               topIcon.image = [UIImage imageNamed:@"auth_success"];
        
        
      
    }
}
-(void)certainss
{
    [Network GET:@"api/v1/user/fail-reasons/read/" paramenters:nil success:^(id data) {
        [self jumpViewControllerAndCloseSelf:[[GouMee_AuthenticationViewController alloc]init]];
    } error:^(id data) {
        
    }];
}
-(void)jumpViewControllerAndCloseSelf:(UIViewController *)vc{

        NSArray *viewControlles = self.navigationController.viewControllers;

        NSMutableArray *newviewControlles = [NSMutableArray array];

        if ([viewControlles count] > 0) {

                for (int i=0; i < [viewControlles count]-1; i++) {

                        [newviewControlles addObject:[viewControlles objectAtIndex:i]];

                    }

            }

        [newviewControlles addObject:vc];

        [self.navigationController setViewControllers:newviewControlles animated:YES];

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
