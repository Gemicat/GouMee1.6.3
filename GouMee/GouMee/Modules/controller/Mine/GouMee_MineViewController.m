//
//  GouMee_MineViewController.m
//  GouMee
//
//  Created by 白冰 on 2019/12/11.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GouMee_MineViewController.h"
#import "Mine_InfoViewCell.h"
#import "PerformanceViewCell.h"
#import "ToolsViewCell.h"
#import "FeedBackViewController.h"
#import "HelpViewCell.h"
#import "MineReusableView.h"
#import "GouMee_PerformanceCenterViewController.h"
#import "GouMee_CollectViewController.h"
#import "GouMee_PIDViewController.h"
#import "GouMee_LoginViewController.h"
#import "GouMee_SelVideoViewController.h"
#import "GouMee_BalanceViewController.h"
#import "GouMee_AuthenticationViewController.h"
#import "GouMee_SetViewController.h"
#import "LCVerticalBadgeBtn.h"
#import "OrderViewCell.h"
#import "GoumeeRegisterWebViewController.h"
#import "Goumee_OrderViewController.h"
#import "Goumee_ScheduleViewController.h"
@interface GouMee_MineViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIActionSheetDelegate>


@property (nonatomic, strong)UICollectionView *mineCollectView;
@property (nonatomic, strong)NSDictionary *userInfo;
@property (nonatomic, strong)NSDictionary *moneyInfo;
@property (nonatomic, strong)NSDictionary *orderInfo;
@end

@implementation GouMee_MineViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self resetMinesNavBar];
    self.navigationController.navigationBarHidden = NO;
    NSDictionary *loginModel = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    if (loginModel.count > 0) {
        
         dispatch_group_t group = dispatch_group_create();
            dispatch_queue_t searialQueue = dispatch_queue_create("com.hmc.www", DISPATCH_QUEUE_SERIAL);
            
            dispatch_group_enter(group);
            dispatch_group_async(group, searialQueue, ^{
                // 网络请求一
                [Network GET:[NSString stringWithFormat:@"api/v1/users/%@/",loginModel[@"id"]] paramenters:nil success:^(id data) {
                            if ([data[@"success"] intValue] == 1) {
                                self->_userInfo = [NSDictionary dictionaryWithDictionary:data[@"data"]];
                                if (isNotNull(self->_userInfo[@"pid"])) {
                                    [[NSUserDefaults standardUserDefaults]setObject:self->_userInfo[@"pid"] forKey:@"user_pid"];
                                    [[NSUserDefaults standardUserDefaults]synchronize];
                                                            }
                                                           
                
                                                        }
                    else
                    {
                        if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
                            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                            [Network showMessage:data[@"message"] duration:2.0];
                            AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                            if (app.loginStatus == 0) {
                                app.loginStatus = 1;
                                GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                                [self.navigationController pushViewController:vc animated:YES];

                            }
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
            [Network GET:[NSString stringWithFormat:@"api/v1/user-achievements/%@/",loginModel[@"id"]] paramenters:nil success:^(id data) {
                                      if ([data[@"success"] intValue] == 1) {
                                          self->_moneyInfo = [NSDictionary dictionaryWithDictionary:data[@"data"]];
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
                        [self.mineCollectView reloadData];
                    });
                });
            });
        
        dispatch_group_enter(group);
                   dispatch_group_async(group, searialQueue, ^{
                   [Network GET:@"api/consumer/v1/sample-center/" paramenters:nil success:^(id data) {
                       
                       
                                             if ([data[@"success"] intValue] == 1) {
                                                self->_orderInfo = [NSDictionary dictionaryWithDictionary:data[@"data"]];
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
                               [self.mineCollectView reloadData];
                           });
                       });
                   });
        
       

//

    
 
    }
    else
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            return ;
        });

    }
    
}
-(void)setXXX
{
    if (isNotNull([self userId])) {

    GouMee_SetViewController *vc = [[GouMee_SetViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
        
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"";
    self.view.backgroundColor= COLOR_STR(0xf5f5f5);
    self.navigationItem.leftBarButtonItem = nil;
    UIButton *setButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    //设置UIButton的图像
    [setButton setImage:[UIImage imageNamed:@"set_bg"] forState:UIControlStateNormal];
    //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
    [setButton addTarget:self action:@selector(setXXX) forControlEvents:UIControlEventTouchUpInside];
    //然后通过系统给的自定义BarButtonItem的方法创建BarButtonItem
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:setButton];
    //覆盖返回按键
    self.navigationItem.rightBarButtonItem = backItem;
  UICollectionViewFlowLayout *cellLay = [[UICollectionViewFlowLayout alloc]init];
    self.mineCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, SH-[self navHeight]-[self tabBarHeight]) collectionViewLayout:cellLay];
           [self.mineCollectView registerClass:[MineReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MineReusableView"];
    [self.mineCollectView registerClass:[Mine_InfoViewCell class] forCellWithReuseIdentifier:@"Mine_InfoViewCell"];
     [self.mineCollectView registerClass:[PerformanceViewCell class] forCellWithReuseIdentifier:@"PerformanceViewCell"];
     [self.mineCollectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"logoutViewCell"];
     [self.mineCollectView registerClass:[ToolsViewCell class] forCellWithReuseIdentifier:@"ToolsViewCell"];
     [self.mineCollectView registerClass:[HelpViewCell class] forCellWithReuseIdentifier:@"HelpViewCell"];
     [self.mineCollectView registerClass:[OrderViewCell class] forCellWithReuseIdentifier:@"OrderViewCell"];
           self.mineCollectView.dataSource = self;
           self.mineCollectView.delegate = self;
           self.mineCollectView.backgroundColor = COLOR_STR(0xf5f5f5);
           self.mineCollectView.alwaysBounceVertical = YES;
           [self.view addSubview:self.mineCollectView];
    
    
//    LCVerticalBadgeBtn *button = [LCVerticalBadgeBtn new];
//    [self.view addSubview:button];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(100);
//        make.centerX.mas_equalTo(0);
//        make.height.width.mas_equalTo(50);
//    }];
//    [button setImage:[UIImage imageNamed:@"square_s"] forState:UIControlStateNormal];
//    [button setTitle:@"代付款" forState:UIControlStateNormal];
//    button.badgeString = @"111";
    
      
       }
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {

    Mine_InfoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Mine_InfoViewCell" forIndexPath:indexPath];
        if (isNotNull(_userInfo)) {
            cell.userName.text =[_userInfo[@"mobile"] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            cell.balanceLab.text = [NSString stringWithFormat:@"余额：%@",_userInfo[@"can_use_money"]];
        }
        if (isNotNull(_moneyInfo)) {

        [cell.willDay setTitle:[NSString stringWithFormat:@"%@",_moneyInfo[@"day_paid_pre"]] forState:UIControlStateNormal];
        [cell.willMonth setTitle:[NSString stringWithFormat:@"%@",_moneyInfo[@"month_paid_pre"]] forState:UIControlStateNormal];
        [cell.sumMoney setTitle:[NSString stringWithFormat:@"%@",_moneyInfo[@"sum_settled_income"]] forState:UIControlStateNormal];
        }
        cell.setBlock = ^{

        };
        cell.click = ^{

            GouMee_PerformanceCenterViewController *vc = [[GouMee_PerformanceCenterViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        cell.clickBlock  = ^{
            GouMee_BalanceViewController *vc = [[GouMee_BalanceViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];

        };
    return cell;
    }
    else if (indexPath.section == 1)
    {
        OrderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OrderViewCell" forIndexPath:indexPath];
        if (isNotNull(self.orderInfo)) {
            if ([self.orderInfo[@"audited_count"] intValue] > 99) {
                cell.collectBtn.badgeString = @"99+";
            }
            else
            {
            cell.collectBtn.badgeString =[NSString stringWithFormat:@"%@",self.orderInfo[@"audited_count"]] ;
            }
            if ([self.orderInfo[@"receiving_count"] intValue] > 99) {
                cell.BoBtn.badgeString = @"99+";
            }
            else
            {
            cell.BoBtn.badgeString = [NSString stringWithFormat:@"%@",self.orderInfo[@"receiving_count"]];
            }
            if ([self.orderInfo[@"send_count"] intValue] > 99) {
                cell.PidBtn.badgeString = @"99+";
            }
            else
            {
            cell.PidBtn.badgeString = [NSString stringWithFormat:@"%@",self.orderInfo[@"send_count"]];
            }
            if ([self.orderInfo[@"back_count"] intValue] > 99) {
                           cell.SendBtn.badgeString = @"99+";
                       }
                       else
                       {
                       cell.SendBtn.badgeString = [NSString stringWithFormat:@"%@",self.orderInfo[@"back_count"]];
                       }
           
            
        }
        cell.click = ^(NSInteger tag) {
            if (isNotNull([self userId])) {
            Goumee_OrderViewController *vc = [[Goumee_OrderViewController alloc]init];
                vc.count = tag;
            [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }
        };
           return cell;
    }
    else if (indexPath.section == 2)
       {
           ToolsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ToolsViewCell" forIndexPath:indexPath];

           cell.clickBlock = ^(NSInteger tag) {
               if (isNotNull([self userId])) {
               if (tag == 1) {
                   GouMee_CollectViewController *vc = [[GouMee_CollectViewController alloc]init];
                   [self.navigationController pushViewController:vc animated:YES];
               }
               if (tag == 2) {
                   GouMee_PIDViewController *vc = [[GouMee_PIDViewController alloc]init];
                   vc.userInfo = _userInfo;
                   [self.navigationController pushViewController:vc animated:YES];
               }
               if (tag == 3) {
                   Goumee_ScheduleViewController *vc = [[Goumee_ScheduleViewController alloc]init];
                   [self.navigationController pushViewController:vc animated:YES];
               }
               }
               else
               {
                   GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                   [self.navigationController pushViewController:vc animated:YES];
                   return;
               }
           };

              return cell;
       }
  else if (indexPath.section == 3)
        {
           HelpViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HelpViewCell" forIndexPath:indexPath];
    NSArray *arr = @[@"open_icon",@"bangding_icon",@"shangjia_icon",@"use_bg"];
             NSArray *titleArr = @[@"如何绑定抖音商品橱窗?",@"如何绑定抖音淘宝PID?",@"如何上架商品到抖音?",@"如何使用库然APP？"];
            cell.name.text = titleArr[indexPath.row];
 
        cell.backView.image = [UIImage imageNamed:arr[indexPath.row]];

              return cell;
        }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"logoutViewCell" forIndexPath:indexPath];
    
    UILabel *label = [UILabel new];
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
    }];
    label.font = font1(@"PingFangSC-Medium", scale(15));
    label.textColor = COLOR_STR(0x999999);
    label.text = @"退出登录";
      
                 return cell;

}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0 || section == 4 || section == 1 || section == 2) {
        return 1;
    }
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.auditStatus == 0) {
        return 4;
    }
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 ) {
          AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        if (appDelegate.auditStatus == 0) {
             return CGSizeMake(SW,scale(235));
        }
        else
        {
          return CGSizeMake(SW,scale(61));
        }
        
    }
    else if (indexPath.section == 4)
    {
        return CGSizeMake(SW,scale(80));
    }
    else if(indexPath.section == 1)
    {
      return CGSizeMake(SW,scale(130));
    }
    else if (indexPath.section == 2)
    {
      return CGSizeMake(SW,scale(170));
    }
     return CGSizeMake(SW/2.0-scale(20),scale(94));
   
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
//        GouMee_PerformanceCenterViewController *vc = [[GouMee_PerformanceCenterViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
//            GouMee_CollectViewController *vc = [[GouMee_CollectViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 1) {
//            GouMee_PIDViewController *vc = [[GouMee_PIDViewController alloc]init];
//            vc.userInfo = _userInfo;
//            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section == 4) {
//        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
        
         UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:@"是否要退出登录"
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:@"确定"
                                          otherButtonTitles:nil,nil];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
       
    
    }
    if (indexPath.section == 3) {
        NSArray *urlArr = @[@"https://kuran-s2b.oss-cn-hangzhou.aliyuncs.com/kaitong-chuchuang.mp4",
        @"https://kuran-s2b.oss-cn-hangzhou.aliyuncs.com/taobao-pid.mp4",
        @"https://kuran-s2b.oss-cn-hangzhou.aliyuncs.com/shangjia-douyin.mp4",
                            @"https://kuran.goumee.com/h5/guide.html"];
        if (indexPath.row < 3) {
            GouMee_SelVideoViewController *vc = [[GouMee_SelVideoViewController alloc]init];
            vc.urlString = urlArr[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            GoumeeRegisterWebViewController *vc = [[GoumeeRegisterWebViewController alloc]init];
            vc.urlStr =  @"https://kuran.goumee.com/h5/guide.html";
            vc.title = @"新手教程";
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
        [[NSUserDefaults standardUserDefaults]synchronize];
       GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
       
    }else
    {
        
    }
 
}
- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
 
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
 
}
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 3) {
         return UIEdgeInsetsMake(10.f,scale(15),10.f,scale(15));
    }
        return UIEdgeInsetsMake(0.f,0.f,0.f,0.f);
}
       ////设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 3) {
        return scale(10);
    }
     return 0.f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 3) {
        return scale(10);
    }
    return 0.f;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 4) {
       
          return CGSizeMake(SW, 0);
            
    }
    return CGSizeMake(SW, 0);
}


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
   
     MineReusableView   *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MineReusableView" forIndexPath:indexPath];
    
    if (indexPath.section == 1) {
        headerView.textLab.text = @"业绩中心";
    }
    if (indexPath.section == 2) {
        headerView.textLab.text = @"我的工具";
    }
    if (indexPath.section == 3) {
     
       
    }
            return headerView;
    

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
