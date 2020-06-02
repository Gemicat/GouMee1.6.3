//
//  ServiceMessageViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/3/30.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "ServiceMessageViewController.h"
#import "ServiceMessageViewCell.h"
#import "NullView.h"
#import "Goumee_OrderDetailViewController.h"
@interface ServiceMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat cellHeight;
    
}
@property (nonatomic, strong)UITableView *messageTableView;
@property (nonatomic, strong) NSMutableArray *dates;
@property (nonatomic, strong) NullView *nullView;
@end

@implementation ServiceMessageViewController

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
    self.title = @"服务通知";
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
        [parm setObject:@(3) forKey:@"notice_type"];
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
     NSString *CellIdentifier =[NSString stringWithFormat:@"ServiceMessageViewCell%ld%ld",indexPath.section,indexPath.row] ;
    ServiceMessageViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        cell1 = [[ServiceMessageViewCell alloc]
                 initWithStyle:UITableViewCellStyleValue1
                 reuseIdentifier:CellIdentifier];
    }
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    if (isNotNull(self.dates)) {
        [cell1 addModel:self.dates[indexPath.section]];
         cell1.frame = CGRectMake(0, 0, SW, [cell1 height]);
    }
   cell1.nextBtn.tag = indexPath.section;
      [cell1.nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    return cell1;

}
-(void)next:(UIButton *)sender
{
    Goumee_OrderDetailViewController *vc = [[Goumee_OrderDetailViewController alloc]init];
           vc.ID = [NSString stringWithFormat:@"%@",self.dates[sender.tag][@"resource_id"]];
           [self.navigationController pushViewController:vc animated:YES];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dates.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceMessageViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.height;
   
}

@end
