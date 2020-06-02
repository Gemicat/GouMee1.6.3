//
//  AccountMessageViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/3/30.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "AccountMessageViewController.h"
#import "Message_AccountViewCell.h"
#import "DateTranslate.h"
#import "GouMee_AuthenticationViewController.h"
#import "GouMee_BalanceViewController.h"
#import "NullView.h"
#import "GouMee_LoginViewController.h"
@interface AccountMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat cellHeight;
    
}
@property (nonatomic, strong)UITableView *messageTableView;
@property (nonatomic, strong) NSMutableArray *dates;
@property (nonatomic, strong) NullView *nullView;

@end

@implementation AccountMessageViewController
-(NullView *)nullView
{
    if (!_nullView) {
        _nullView = [[NullView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _nullView.backgroundColor = [UIColor clearColor];
    }
    return _nullView;
    
}
-(void)getView:(NSInteger)networkCode
{
    if (networkCode == 0) {
          if (self.dates.count == 0) {
              [self.view addSubview:self.nullView];
              self.nullView.nullIocn.image = [UIImage imageNamed:@"message_null"];
                            self.nullView.nullTitle.text = @"您暂无消息通知";
              self.nullView.refreshBtn.hidden = YES;
              self.messageTableView.tableFooterView = nil;
          }
          else
          {
              [self.nullView removeFromSuperview];
              UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 100)];
                       self.messageTableView.tableFooterView = footView;
                       UIImageView *moreView = [UIImageView new];
                       [footView addSubview:moreView];
                       [moreView mas_makeConstraints:^(MASConstraintMaker *make) {
                           make.centerX.mas_equalTo(0);
                           make.centerY.mas_equalTo(0);
                       }];
                       moreView.image = [UIImage imageNamed:@"more_message"];
          }
    }
    else
    {
        if (self.dates.count == 0) {
             [self.view addSubview:self.nullView];
                         self.nullView.nullIocn.image = [UIImage imageNamed:@"null_network"];
                         self.nullView.nullTitle.text = @"暂时没有网络";
             self.messageTableView.tableFooterView = nil;
            self.nullView.refreshBtn.hidden = NO;
            self.nullView.click = ^{
              
            };
        }
        
    }
  
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账户通知";
    cellHeight = 0;
    self.view.backgroundColor = viewColor;
    [self.view addSubview:self.messageTableView];
   
    [self getMessageListJson:1];
    [self.messageTableView addHeaderRefresh:NO animation:NO headerAction:^{
        [self getMessageListJson:1];

    }];
    [self.messageTableView addFooterRefresh:NO footerAction:^(NSInteger pageIndex) {

        [self getMessageListJson:pageIndex+1];
    }];

}
-(void)getMessageListJson:(NSInteger)page
{
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:@(1) forKey:@"notice_type"];
    [parm setObject:@(page) forKey:@"page"];
    [parm setObject:@(10) forKey:@"page_size"];
    [Network GET:@"api/consumer/v1/notice-detail/" paramenters:parm success:^(id data) {
        if ([data[@"success"] intValue] == 1) {
            if (page == 1) {
                self.dates = [NSMutableArray array];
                   }
            for (NSDictionary *model in data[@"data"][@"results"]) {
                [self.dates addObject:model];
            }
        }
        if (!isNotNull(data[@"data"][@"results"])) {
            [self getView:0];
        }
        [self.messageTableView reloadData];
        
    } error:^(id data) {
        [self getView:1];
    }];
    
}
- (UITableView *)messageTableView {
    
    if (!_messageTableView) {
        _messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SW, self.view.frame.size.height-[self navHeight])];
        _messageTableView.backgroundColor = [UIColor clearColor];
        _messageTableView.delegate = self;

        _messageTableView.dataSource = self;
        _messageTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return _messageTableView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.devices.count;
   
    return 1;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSString *CellIdentifier =[NSString stringWithFormat:@"Message_AccountViewCell%ld%ld",indexPath.section,indexPath.row] ;
    Message_AccountViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        cell1 = [[Message_AccountViewCell alloc]
                 initWithStyle:UITableViewCellStyleValue1
                 reuseIdentifier:CellIdentifier];
    }
    if (isNotNull(self.dates)) {
          [cell1 addModel:self.dates[indexPath.section]];
         cell1.frame = CGRectMake(0, 0, SW, [cell1 height]);
    }
   cell1.selectionStyle = UITableViewCellSelectionStyleNone;
   cell1.nextBtn.tag = indexPath.section;
    [cell1.nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    return cell1;

}
-(void)next:(UIButton *)sender
{
    NSDictionary * model = self.dates[sender.tag];
    NSInteger status = [model[@"account_type"] intValue];
        NSInteger refuse = [model[@"refused"] boolValue];
      if (status == 1 && refuse == 1)
       {
//           GouMee_AuthenticationViewController *vc = [[GouMee_AuthenticationViewController alloc]init];
//           [self.navigationController pushViewController:vc animated:YES];
           [self getUserInfo];
       }
    
           else if (status == 3)
              {
                  GouMee_BalanceViewController *vc = [[GouMee_BalanceViewController alloc]init];
                  [self.navigationController pushViewController:vc animated:YES];
              }
       
    
}
-(void)getUserInfo
{
    [Network GET:[NSString stringWithFormat:@"api/v1/users/%@/",[self userId]] paramenters:nil success:^(id data) {
        if ([data[@"success"] intValue] == 1) {
        NSInteger status = [data[@"data"][@"identity_status"] intValue];
        if (status == 2) {
           GouMee_AuthenticationViewController *vc = [[GouMee_AuthenticationViewController alloc]init];
           [self.navigationController pushViewController:vc animated:YES];
                         }
            if (status == 1) {
                [Network showMessage:@"实名资料审核中" duration:2.0];
            }
            if (status == 3) {
                [Network showMessage:@"您已完成实名认证" duration:2.0];
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
        } error:^(id data) {}];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dates.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message_AccountViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.height;
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
