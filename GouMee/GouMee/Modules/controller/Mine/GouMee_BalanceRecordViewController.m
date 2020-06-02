//
//  GouMee_BalanceRecordViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/1/9.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GouMee_BalanceRecordViewController.h"
#import "NullView.h"
#import "Balance_RecordViewCell.h"
#import "GouMee_LoginViewController.h"
@interface GouMee_BalanceRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger isPage;
}
@property (nonatomic, strong)NullView *nullView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *sourceArr;

@end

@implementation GouMee_BalanceRecordViewController
-(NSMutableArray *)sourceArr
{
    if (!_sourceArr) {
        _sourceArr = [NSMutableArray array];
    }
    return _sourceArr;
}
-(NullView *)nullView
{
    if (!_nullView) {
        _nullView = [[NullView alloc]initWithFrame:self.view.frame];
    }
    return _nullView;
    
}
- (UITableView *)tableView {
        
        if (!_tableView) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SW, SH-[self navHeight])];
            _tableView.backgroundColor =viewColor;
            _tableView.delegate = self;
            _tableView.dataSource = self;
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        
        return _tableView;
    }
-(void)getView
{
    if (self.sourceArr.count == 0) {
        [self.view addSubview:self.nullView];
        self.nullView.nullIocn.image = [UIImage imageNamed:@"null_icon"];
        self.nullView.nullTitle.text = @"这里空空如也，啥也没有";
        self.nullView.refreshBtn.hidden = YES;
    }
    else
    {
        [self.nullView removeFromSuperview];
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = viewColor;
    self.title = @"余额明细";
    [self.view addSubview:self.tableView];
    isPage = 1;
    
    [self getUrl:1];
         [self.tableView addHeaderRefresh:YES animation:NO headerAction:^{
             [self getUrl:1];
         }];
         [self.tableView addFooterRefresh:YES footerAction:^(NSInteger pageIndex) {
               if (pageIndex <= isPage) {
             [self getUrl:pageIndex];
             }
             
         }];
    
}
-(void)getUrl:(NSInteger)page
{
     NSDictionary *loginModel = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
       [parm setObject:@(page) forKey:@"page"];
       [parm setObject:@(10) forKey:@"page_size"];
    [parm setValue:loginModel[@"id"] forKey:@"user"];
      
     
       [Network GET:@"api/v1/money-logs/" paramenters:parm success:^(id data) {
           if ([data[@"success"] intValue] == 1) {
               if (page == 1) {
                        [_sourceArr removeAllObjects];
                    }
               isPage = [data[@"data"][@"count"] intValue]%10;
                          if (isPage == 0) {
                              isPage =  [data[@"data"][@"count"] intValue]/10;
                          }
                          else
                          {
                              isPage = [data[@"data"][@"count"] intValue]/10 +1;
                          }
                          for (NSDictionary *model in data[@"data"][@"results"]) {
                              [self->_sourceArr addObject:model];
                          }
                           [self.tableView reloadData];
                        
                          if (self.sourceArr.count == [data[@"data"][@"count"] intValue]) {
                              [self.tableView.mj_footer endRefreshingWithNoMoreData];
                          }
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
           [self getView];
           [self endRefrsh:self.tableView];
       } error:^(id data) {
    
           [self endRefrsh:self.tableView];
           
       }];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
   
     
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.devices.count;
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"With_RecordCell";

    Balance_RecordViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        cell1 = [[Balance_RecordViewCell alloc]
                 initWithStyle:UITableViewCellStyleValue1
                 reuseIdentifier:CellIdentifier];
    }
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    if (isNotNull(self.sourceArr)) {
        [cell1 addModel:self.sourceArr[indexPath.section]];
    }
    return cell1;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sourceArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return scale(50);
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end
