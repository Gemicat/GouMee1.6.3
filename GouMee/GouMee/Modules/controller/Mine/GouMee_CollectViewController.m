//
//  GouMee_CollectViewController.m
//  GouMee
//
//  Created by 白冰 on 2019/12/18.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GouMee_CollectViewController.h"
#import "MineCollectViewCell.h"
#import "NullView.h"
#import "CollectGoodsViewCell.h"
#import "GouMee_GoodsDetailViewController.h"
#import "GouMee_LoginViewController.h"
#import "GouMee_LiveDetailViewController.h"
@interface GouMee_CollectViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger isPage;
}
@property (nonatomic, strong)NullView *nullView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *sourceArr;

@end

@implementation GouMee_CollectViewController
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
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, SW, SH-[self navHeight]-10)];
            _tableView.backgroundColor = viewColor;
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
    self.title = @"收藏夹";
    [self.view addSubview:self.tableView];
    isPage = 1;
    [self getVollectUrl:1];
    [self.tableView addHeaderRefresh:YES animation:NO headerAction:^{
        [self getVollectUrl:1];
        
    }];
    [self.tableView addFooterRefresh:NO footerAction:^(NSInteger pageIndex) {
        if (pageIndex <= isPage) {
             [self getVollectUrl:pageIndex+1];
        }
       
    }];
}
-(void)getVollectUrl:(NSInteger)page
{
  
   NSMutableDictionary *parm = [NSMutableDictionary dictionary];
       [parm setObject:@(page) forKey:@"page"];
       [parm setObject:@(10) forKey:@"page_size"];
   
    
     NSDictionary *loginModel = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    [Network GET:[NSString stringWithFormat:@"api/v1/favorites/?user=%@",loginModel[@"id"]] paramenters:parm success:^(id data) {
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
                                  [self getView];
                                  if (self.sourceArr.count == [data[@"data"][@"count"] intValue] && isNotNull(data[@"data"])) {
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
    } error:^(id data) {
        
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.sourceArr.count > 0) {
        NSDictionary *model = self.sourceArr[indexPath.section];
               if (isNotNull(model[@"live_group_info"])) {
                   if ([model[@"live_group_info"][@"live_type"] intValue] == 1) {
                       
                       GouMee_LiveDetailViewController *vc = [[GouMee_LiveDetailViewController alloc]init];
                       if ([model[@"is_invalid"] intValue] == 0) {
                           vc.ID = model[@"live_group_info"][@"id"];
                               [self.navigationController pushViewController:vc animated:YES];
                       }
                       else
                       {
                           [Network showMessage:@"该商品已失效" duration:1.0];
                       }
                       
                       
                     
                   }
                   else
                   {
                      GouMee_GoodsDetailViewController *vc = [[GouMee_GoodsDetailViewController alloc]init];
                        NSDictionary *model = self.sourceArr[indexPath.section][@"good"];
                       vc.isFree = 1;
                      if ([model[@"is_invalid"] intValue] == 0) {
                         vc.goodId = [NSString stringWithFormat:@"%@",model[@"id"]];
                              [self.navigationController pushViewController:vc animated:YES];
                      }
                      else
                      {
                          [Network showMessage:@"该商品已失效" duration:1.0];
                      }
                   }
                  
               }
               else
               {
                  GouMee_GoodsDetailViewController *vc = [[GouMee_GoodsDetailViewController alloc]init];
                    NSDictionary *model = self.sourceArr[indexPath.section][@"good"];
                  if ([model[@"is_invalid"] intValue] == 0) {
                     vc.goodId = [NSString stringWithFormat:@"%@",model[@"id"]];
                          [self.navigationController pushViewController:vc animated:YES];
                  }
                  else
                  {
                      [Network showMessage:@"该商品已失效" duration:1.0];
                  }
                   
               }
    }
     
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.devices.count;
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.sourceArr.count > 0) {
        NSDictionary *model = self.sourceArr[indexPath.section];
               if (isNotNull(model[@"live_group_info"])) {
                   if ([model[@"live_group_info"][@"live_type"] intValue] == 1) {
                        NSString *CellIdentifier = [NSString stringWithFormat:@"MineCollectViewCell%ld%ld",indexPath.section,indexPath.row];
                          CollectGoodsViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                          if (cell1 == nil) {
                              cell1 = [[CollectGoodsViewCell alloc]
                                       initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:CellIdentifier];
                          }
                          cell1.selectionStyle = UITableViewCellSelectionStyleNone;
                          if (isNotNull(self.sourceArr)) {
                              [cell1 addModel1:self.sourceArr[indexPath.section]];
                          }
                       
                          cell1.collectBtn.tag = indexPath.section;
                          [cell1.collectBtn addTarget:self action:@selector(deletUrl:) forControlEvents:UIControlEventTouchUpInside];
                          return cell1;

                   }
                   else
                   {
                         NSString *CellIdentifier = [NSString stringWithFormat:@"MineCollectViewCell%ld%ld",indexPath.section,indexPath.row];
                         MineCollectViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                         if (cell1 == nil) {
                             cell1 = [[MineCollectViewCell alloc]
                                      initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:CellIdentifier];
                         }
                         cell1.selectionStyle = UITableViewCellSelectionStyleNone;
                         if (isNotNull(self.sourceArr)) {
                             [cell1 addMOdel:self.sourceArr[indexPath.section]];
                         }
                       cell1.FreeIcon.hidden = NO;
                         cell1.moneyNum.tag = indexPath.section;
                         [cell1.moneyNum addTarget:self action:@selector(deletUrl:) forControlEvents:UIControlEventTouchUpInside];
                         return cell1;

                   }
                  
               }
               else
               {
                  NSString *CellIdentifier = [NSString stringWithFormat:@"MineCollectViewCell%ld%ld",indexPath.section,indexPath.row];
                    MineCollectViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    if (cell1 == nil) {
                        cell1 = [[MineCollectViewCell alloc]
                                 initWithStyle:UITableViewCellStyleValue1
                                 reuseIdentifier:CellIdentifier];
                    }
                    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
                    if (isNotNull(self.sourceArr)) {
                        [cell1 addMOdel:self.sourceArr[indexPath.section]];
                    }
                   cell1.FreeIcon.hidden = YES;
                    cell1.moneyNum.tag = indexPath.section;
                    [cell1.moneyNum addTarget:self action:@selector(deletUrl:) forControlEvents:UIControlEventTouchUpInside];
                    return cell1;

                   
               }
    }
    
  
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"MineCollectViewCell%ld%ld",indexPath.section,indexPath.row];
    MineCollectViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        cell1 = [[MineCollectViewCell alloc]
                 initWithStyle:UITableViewCellStyleValue1
                 reuseIdentifier:CellIdentifier];
    }
    return cell1;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sourceArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.sourceArr.count > 0) {
                       NSDictionary *model = self.sourceArr[indexPath.section];
                              if (isNotNull(model[@"live_group_info"])) {
                                  if ([model[@"live_group_info"][@"live_type"] intValue] == 1) {
                                      return scale(240);
                                  }
                                  else
                                  {
                                      return scale(210);
                                  }
                                 
                              }
                              else
                              {
                                  return scale(210);
                                  
                              }
                   }
          
          
          
          return scale(0);

   
}


-(void)deletUrl:(UIButton *)sender
{
    NSDictionary *goodModel = self.sourceArr[sender.tag];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
      [parm setObject:goodModel[@"good"][@"id"] forKey:@"good"];
       [parm setObject:@(0) forKey:@"is_active"];
       
       [Network POST:@"api/v1/favorites/" paramenters:parm success:^(id data) {
           if ([data[@"success"] intValue] == 1) {
               [Network showMessage:@"取消收藏成功" duration:2.0];
               [self.sourceArr removeObject:goodModel];
               [self getView];
               [self.tableView reloadData];
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
          
       } error:^(id data) {
           
       }];
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
