//
//  MessageViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/3/30.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageViewCell.h"
#import "DateTranslate.h"
#import "AccountMessageViewController.h"
#import "JiYangMessageViewController.h"
#import "ServiceMessageViewController.h"
#import "NullView.h"
@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger types;
    
}
@property (nonatomic, strong)UITableView *messageTableView;
@property (nonatomic, strong) NSMutableArray *dates;
@property (nonatomic, strong)NullView *nullView;
@end

@implementation MessageViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
  [self getMessageJson];
    
}
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
                [self getMessageJson];
            };
        }
        
    }
  
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息中心";
    types = 0;
    self.view.backgroundColor = COLOR_STR(0xF4F6F6);
    [self.view addSubview:self.messageTableView];
      UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 40, 40)];
        //设置UIButton的图像
    [cancelButton setTitle:@"全部已读" forState:UIControlStateNormal];
    [cancelButton setTitleColor:ThemeRedColor forState:UIControlStateNormal];
    cancelButton.titleLabel.font = font(14);
        //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
        [cancelButton addTarget:self action:@selector(cancelRead) forControlEvents:UIControlEventTouchUpInside];
        //然后通过系统给的自定义BarButtonItem的方法创建BarButtonItem
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:cancelButton];
        //覆盖返回按键
        self.navigationItem.rightBarButtonItem = backItem;
   
}
-(void)getMessageJson
{
    [Network GET:@"api/consumer/v1/notice-center/" paramenters:nil success:^(id data) {
        if (isNotNull(data[@"data"]) && [data[@"success"] intValue] == 1) {
            self.dates = [NSMutableArray arrayWithArray:data[@"data"]];
            [self.messageTableView reloadData];
        }
        [self getView:0];
    } error:^(id data) {
        [self getView:1];
    }];
    
}
-(void)cancelRead
{
    if (types == 1) {
         [Network PUT:@"api/consumer/v1/notice-read/" paramenters:nil success:^(id data) {
               if ([data[@"success"] intValue] == 1) {
                   types = 2;
                          [self getMessageJson];
                   [Network showMessage:@"已全部标为已读" duration:2.0];
                      }
           } error:^(id data) {
               
           }];
    }
    else
    {
        [Network showMessage:@"暂无未读消息" duration:2.0];
    }
   
  
}
- (UITableView *)messageTableView {
    
    if (!_messageTableView) {
        _messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, scale(12), SW, self.view.frame.size.height-scale(12)-[self navHeight])];
        _messageTableView.backgroundColor = [UIColor clearColor];
        _messageTableView.delegate = self;

        _messageTableView.dataSource = self;
        _messageTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return _messageTableView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
     NSInteger type = [self.dates[indexPath.row][@"type"] intValue];
    if (type == 1) {
        
    AccountMessageViewController *vc = [[AccountMessageViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    }else if (type == 2)
    {
     JiYangMessageViewController *vc = [[JiYangMessageViewController alloc]init];
     [self.navigationController pushViewController:vc animated:YES];
        
    }
    else
    {
     ServiceMessageViewController *vc = [[ServiceMessageViewController alloc]init];
     [self.navigationController pushViewController:vc animated:YES];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.devices.count;
   
    return self.dates.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MessageViewCell";

    MessageViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        cell1 = [[MessageViewCell alloc]
                 initWithStyle:UITableViewCellStyleValue1
                 reuseIdentifier:CellIdentifier];
    }

    if (indexPath.row == 2) {
        cell1.line.hidden = YES;
    }
    else
    {
        cell1.line.hidden = NO;
    }
    if (isNotNull(self.dates)) {
        NSDictionary *model = self.dates[indexPath.row];
        cell1.context.text = model[@"title"];
        
        if ([model[@"count"] intValue] > 99) {
            cell1.leftBtn.badgeString = @"99+";
        }
        else
        {
        cell1.leftBtn.badgeString = [NSString stringWithFormat:@"%@",model[@"count"]];
        }
        if ([model[@"count"] intValue] > 0) {
            types = 1;
        }
        
        NSString *time = [Network timestampSwitchTime:[model[@"create_time"] integerValue] andFormatter:@"YYYY.MM.dd HH:mm"];
             cell1.timeLab.text = [DateTranslate cellformateDate:time withFormate:@"YYYY.MM.dd HH:mm"];
        NSInteger type = [model[@"type"] intValue];
        switch (type) {
              case 1:
                  [cell1.leftBtn setImage:[UIImage imageNamed:@"account_message"] forState:UIControlStateNormal];
                 
                  cell1.titleLab.text = @"账户通知";
                  break;
                  case 2:
                             [cell1.leftBtn setImage:[UIImage imageNamed:@"jiyang_message"] forState:UIControlStateNormal];
                           
                  cell1.titleLab.text = @"寄样申请";
                             break;
                  case 3:
                             [cell1.leftBtn setImage:[UIImage imageNamed:@"service_message"] forState:UIControlStateNormal];
                  cell1.titleLab.text = @"服务通知";
                             break;
                  
              default:
                  break;
          }
        
        
    }
     cell1.selectionStyle = UITableViewCellSelectionStyleNone;
     cell1.leftBtn.isMessage = 2;
    return cell1;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return scale(79);
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
