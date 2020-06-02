//
//  GouMee_MyLiveViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/3/31.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GouMee_MyLiveViewController.h"
#import "NullView.h"
#import "MyLiveViewCell.h"
#import "GouMee_LiveDetailViewController.h"
@interface GouMee_MyLiveViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *bottomView;
    BOOL isManager;
    NSMutableDictionary *dic;
    BOOL isAppleee;
    NSMutableDictionary *selectModel;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dates;
@property (nonatomic, strong) NullView *nullView;
@property (nonatomic, strong) UIButton *managerBtn;
@end

@implementation GouMee_MyLiveViewController
-(NullView *)nullView
{
    if (!_nullView) {
        _nullView = [[NullView alloc]initWithFrame:CGRectMake(0, scale(36), self.view.frame.size.width, self.view.frame.size.height-scale(36))];
        _nullView.backgroundColor = [UIColor clearColor];
    }
    return _nullView;
    
}
-(void)getView:(NSInteger)networkCode
{
    if (networkCode == 0) {
          if (self.dates.count == 0) {
              [self.view addSubview:self.nullView];
              self.nullView.nullIocn.image = [UIImage imageNamed:@"null_icon"];
                self.nullView.nullTitle.text = @"暂无已报名的拼播活动";
              self.nullView.refreshBtn.hidden = YES;
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
            self.nullView.refreshBtn.hidden = NO;
            self.nullView.click = ^{
                [self liveJson:1];
            };
        }
        
    }
  
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的拼播";

    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"isfinish"];
       if (isNotNull(str)) {
           isAppleee = YES;
       }
       else
       {
       isAppleee = NO;
       }
    self.view.backgroundColor = viewColor;
    [self.view addSubview:self.tableView];
    _dates = [NSMutableArray array];
  [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
             if (@available(iOS 11.0, *)) {
                                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0);
                                } else {
                                make.bottom.equalTo(self.view.mas_bottom).offset(0);
                                }
             make.left.right.top.mas_equalTo(0);
         }];
    isManager = NO;
    
    dic = [NSMutableDictionary dictionary];
    [self liveJson:1];
    [self.tableView addHeaderRefresh:YES animation:NO headerAction:^{
        [self liveJson:1];
    }];
    [self.tableView addFooterRefresh:NO footerAction:^(NSInteger pageIndex) {
        [self liveJson:pageIndex+1];
    }];
    
    
    _managerBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 40, 40)];
                       //设置UIButton的图像
    [_managerBtn addTarget:self action:@selector(managerAction:) forControlEvents:UIControlEventTouchUpInside];
       _managerBtn.titleLabel.font = font(14);
          [_managerBtn setTitle:@"编辑" forState:UIControlStateNormal];
     [_managerBtn setTitle:@"完成" forState:UIControlStateSelected];
    [_managerBtn setTitleColor:ThemeRedColor forState:UIControlStateSelected];
          [_managerBtn setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];

                 //设置UIButton的图
                 UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:_managerBtn];
                 //覆盖返回按键
                 self.navigationItem.rightBarButtonItem = backItem;

    
         
    bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
                     make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0);
                     } else {
                     make.bottom.equalTo(self.view.mas_bottom).offset(0);
                     }
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(49);
    }];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.hidden = YES;
    UIButton *certainBtn = [UIButton new];
    [bottomView addSubview:certainBtn];
    [certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(scale(34));
        make.left.mas_equalTo(scale(15));
    }];
    [certainBtn setTitle:@"取消报名" forState:UIControlStateNormal];
    certainBtn.titleLabel.font = font(14);
    certainBtn.backgroundColor = ThemeRedColor;
    certainBtn.layer.cornerRadius = scale(17);
    certainBtn.layer.masksToBounds = YES;
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIView *line = [UIView new];
    [bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = COLOR_STR1(0, 0, 0, 0.08);
    [certainBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
   
    }
-(void)liveJson:(NSInteger)page
{
    [self showHub];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:@(page) forKey:@"page"];
    [parm setObject:@(20) forKey:@"page_size"];
    [Network GET:@"api/consumer/v1/my-live-groups/" paramenters:parm success:^(id data) {
        [self hiddenHub];
        if ([data[@"success"] integerValue] == 1) {


            if (page == 1) {
                self.dates = [NSMutableArray array];
                
            }
            for (NSDictionary *model in data[@"data"][@"results"]) {
                [self.dates addObject:model];
            }

        }

        [self.tableView reloadData];
        if ([data[@"data"][@"results"] count] <10 && self.dates.count > 0) {
            UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 100)];
            self.tableView.tableFooterView = footView;
            UIImageView *moreView = [UIImageView new];
            [footView addSubview:moreView];
            [moreView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(0);
                make.centerY.mas_equalTo(0);
            }];
            moreView.image = [UIImage imageNamed:@"more_message"];
        }
        if (self.dates.count == 0) {
            [self getView:0];
        }
    } error:^(id data) {
        [self hiddenHub];
    }];
    
}
-(void)cancelAction
{
    if (isNotNull(selectModel)) {

    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"确认要取消本场拼播的报名？" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    NSLog(@"点击了Cancel");
    [alertVC dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [Network POST:@"api/consumer/v1/cancel-live/" paramenters:@{@"id":selectModel[@"id"]} success:^(id data) {
            if ([data[@"success"] intValue] == 1) {
                [self.dates removeObject:selectModel];
                [dic removeAllObjects];
                [self getView:0];
                [self.tableView reloadData];
                 [alertVC dismissViewControllerAnimated:YES completion:nil];
                [Network showMessage:@"已取消报名" duration:2.0];
            }
            else
            {
                [Network showMessage:data[@"message"] duration:2.0];
            }
            
            
        } error:^(id data) {
            
        }];
   
    }];
   
    [cancelAction setValue:COLOR_STR(0x333333) forKey:@"titleTextColor"];
    [okAction setValue:ThemeRedColor forKey:@"titleTextColor"];
   [alertVC addAction: okAction];
     [alertVC addAction: cancelAction];
   [self presentViewController: alertVC animated: YES completion: nil];
    }
    else
    {
        
        [Network showMessage:@"请先选择要取消报名的场次" duration:2.0];
    }
}
-(void)managerAction:(UIButton *)sender
{
    selectModel = nil;
    if (sender.selected == YES) {
        sender.selected = NO;
        bottomView.hidden = YES;
        isManager = NO;
        dic = nil;
    }
    else
    {
        sender.selected = YES;
        bottomView.hidden = NO;
        isManager = YES;
        for (int i = 0; i <4; i++) {
            [dic setObject:@"0" forKey:[NSString stringWithFormat:@"%d",i]];
        }
    }
    [self.tableView reloadData];
    
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = viewColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
       
      
    }
    
    return _tableView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (isManager == YES) {
        
    MyLiveViewCell *cell = (MyLiveViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
                              
    
        dic = [NSMutableDictionary dictionary];
    
       if (cell.chooseBtn.selected == NO) {
           cell.chooseBtn.selected = YES;
           [dic setObject:@"1" forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
           selectModel = self.dates[indexPath.row];
       }
       else
       {
           cell.chooseBtn.selected = NO;
            [dic setObject:@"0" forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
           selectModel = nil;
       }
       [self.tableView reloadData];
    }
    else
    {

             NSDictionary *model = self.dates[indexPath.row];
        if (isNotNull(model)) {
            GouMee_LiveDetailViewController *vc = [[GouMee_LiveDetailViewController alloc]init];
            vc.ID = model[@"id"];
            [self.navigationController pushViewController:vc animated:YES];
        }

        
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.devices.count;
   
    return self.dates.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
   
         static NSString *CellIdentifier = @"MyLiveViewCell";
    MyLiveViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        cell1 = [[MyLiveViewCell alloc]
                 initWithStyle:UITableViewCellStyleValue1
                 reuseIdentifier:CellIdentifier];
    }
         cell1.selectionStyle = UITableViewCellSelectionStyleNone;
   
    if (isManager == YES) {
        cell1.chooseBtn.hidden = NO;
        NSString *str = [dic objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
        if ([str intValue] == 0) {
            cell1.chooseBtn.selected = NO;
        }
        else
        {
            cell1.chooseBtn.selected = YES;
        }
    }
    else
    {
        cell1.chooseBtn.hidden = YES;
    }
    cell1.chooseBtn.tag = indexPath.row;
    [cell1.chooseBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    if (isNotNull(_dates)) {
        NSDictionary *model = self.dates[indexPath.row];
        [cell1 addModel:model];
    }
    return cell1;
        

}
-(void)chooseAction:(UIButton *)sender
{
    
    [dic removeAllObjects];
    if (sender.selected == NO) {
        sender.selected = YES;
        [dic setObject:@"1" forKey:[NSString stringWithFormat:@"%ld",sender.tag]];
        selectModel = self.dates[sender.tag];
    }
    else
    {
        sender.selected = NO;
         [dic setObject:@"0" forKey:[NSString stringWithFormat:@"%ld",sender.tag]];
        selectModel = nil;
          
    }
    [self.tableView reloadData];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     
    return scale(196);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (isAppleee== NO) {
        
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, scale(36))];
    headView.backgroundColor = COLOR_STR(0xFFF8F0);
    headView.userInteractionEnabled = YES;
    UIImageView *leftIcon = [UIImageView new];
    [headView addSubview:leftIcon];
    [leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(headView.mas_left).offset(scale(12));
    }];
    leftIcon.image = [UIImage imageNamed:@"guangbo_icon"];
    
    UIButton *rightBtn = [UIButton new];
    [headView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headView.mas_right).offset(scale(-12));
        make.centerY.mas_equalTo(0);
    }];
    [rightBtn setImage:[UIImage imageNamed:@"close_live"] forState:UIControlStateNormal];
    
    UILabel *label = [UILabel new];
    [headView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(leftIcon.mas_right).offset(scale(6));
    }];
    label.textColor = COLOR_STR(0xF38544);
    label.font = font(12);
    label.text = @"已组团成功的拼播会进入样品订单和直播排期列表中";
    [rightBtn addTarget:self action:@selector(closes:) forControlEvents:UIControlEventTouchUpInside];
    
    return headView;
    }
    return nil;
    
    
}
-(void)closes:(UIButton *)sender
{
    
    [[NSUserDefaults standardUserDefaults]setObject:@"11111" forKey:@"isfinish"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    isAppleee = YES;
    [self.tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (isAppleee == NO) {
         return scale(36);
    }
    return scale(0);
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
