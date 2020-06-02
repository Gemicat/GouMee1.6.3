//
//  GouMee_AddressViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/3/9.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GouMee_AddressViewController.h"
#import "Goumee_AddressViewCell.h"
#import "Goumee_AddAreaViewController.h"
#import "NullView.h"
#import "GouMee_LoginViewController.h"
@interface GouMee_AddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dates;
@property (nonatomic, strong)NullView *nullView;
@end

@implementation GouMee_AddressViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
     [self json:1];
}
-(NSMutableArray *)dates
{
    if (!_dates) {
        _dates = [NSMutableArray array];
    }
   return  _dates;
    
}
-(NullView *)nullView
{
    if (!_nullView) {
        _nullView = [[NullView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-150)];
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
                            self.nullView.nullTitle.text = @"暂无地址";
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
                [self json:1];
            };
        }
        
    }
  
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收货地址";
    self.view.backgroundColor = COLOR_STR(0xffffff);
    _dates = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    UIButton *certainBtn = [UIButton new];
    [self.view addSubview:certainBtn];
    [certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scale(15));
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(scale(44));
        if (@available(iOS 11.0, *)) {
                         make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-scale(10));
                         } else {
                         make.bottom.equalTo(self.view.mas_bottom).offset(-scale(10));
                         }
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(certainBtn.mas_top).offset(scale(-10));
    }];
    certainBtn.layer.cornerRadius = 22;
    certainBtn.layer.masksToBounds = YES;
    [certainBtn setTitle:@"添加地址" forState:UIControlStateNormal];
    [certainBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
    certainBtn.titleLabel.font = font(12);
    certainBtn.backgroundColor = COLOR_STR(0xD72E51);
    [certainBtn addTarget:self action:@selector(xxxx) forControlEvents:UIControlEventTouchUpInside];
   
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addressNotification:) name:@"delAddress" object:nil];
    [self.tableView addHeaderRefresh:YES animation:NO headerAction:^{
        [self json:1];
    }];
  
}
-(void)addressNotification:(NSNotification *)n
{
    NSDictionary *model = [n object];
//    [self.dates removeObject:model];
//    [self.tableView reloadData];
    
    [self json:1];
}
-(void)json:(NSInteger)page
{
   
     NSDictionary *loginModel = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:loginModel[@"id"] forKey:@"user"];
       [parm setObject:@(page) forKey:@"page"];
       [parm setObject:@(20) forKey:@"page_size"];
       
       [Network GET:@"api/v1/addresses/" paramenters:parm success:^(id data) {
           if (isNotNull(data[@"data"])) {
               if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
                   [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
                   [[NSUserDefaults standardUserDefaults]synchronize];
                   [Network showMessage:data[@"message"] duration:2.0];
                   GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                   [self.navigationController pushViewController:vc animated:YES];
                   return;
               }
               else
               {
               if (page == 1) {
                      _dates = [NSMutableArray array];
                  }
               for (NSDictionary *model in data[@"data"][@"results"]) {
                   if (isNotNull(self.addressModel)) {
                       if ([self.addressModel[@"id"] isEqual:model[@"id"]]) {
                           [_dates insertObject:model atIndex:0];
                       }
                       else
                       {
                           [_dates addObject:model];
                       }
                   }
                   else
                   {
                   
                   [_dates addObject:model];
                   }
               }
               [self getView:0];
               [self.tableView reloadData];
           }
           }
       } error:^(id data) {
           [self getView:1];
           
       }];
    
}
-(void)xxxx
{
    if (self.dates.count >=20) {
        [Network showMessage:@"收货地址最多只能创建20条，如需继续创建可先删除不常用地址" duration:2.0];
    }
    else
    {
    Goumee_AddAreaViewController *vc = [[Goumee_AddAreaViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    }
}
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.backgroundColor = COLOR_STR(0xf5f5f5);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
      
    }
    
    return _tableView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.click) {
        self.click(_dates[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.devices.count;
 
    return _dates.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
   
        static NSString *CellIdentifier = @"Goumee_AddressViewCell";
              Goumee_AddressViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                 if (cell1 == nil) {
                     cell1 = [[Goumee_AddressViewCell alloc]
                              initWithStyle:UITableViewCellStyleValue1
                              reuseIdentifier:CellIdentifier];
                 }
     cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    cell1.editBtn.tag = indexPath.row;
    [cell1.editBtn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_dates.count > 0) {
        
        NSDictionary *model = _dates[indexPath.row];
        [cell1 addModel:model];
        if (self.addressModel) {
            if (indexPath.row == 0) {
                       cell1.chooseBool = 1;
                   }
                   else
                   {
                       cell1.chooseBool = 0;
                   }
        }
        else
        {
             cell1.chooseBool = 0;
        }
       
    }
               return cell1;

}
-(void)edit:(UIButton *)sender
{
    Goumee_AddAreaViewController *vc = [[Goumee_AddAreaViewController alloc]init];
    vc.model = _dates[sender.tag];
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return scale(68);
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
