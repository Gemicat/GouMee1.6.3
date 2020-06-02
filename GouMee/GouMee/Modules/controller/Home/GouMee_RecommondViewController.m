//
//  GouMee_RecommondViewController.m
//  GouMee
//
//  Created by 白冰 on 2019/12/11.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GouMee_RecommondViewController.h"
#import "GoodsViewCell.h"
#import "BannerViewCell.h"
#import "GouMee_GoodsDetailViewController.h"
#import "GouMee_StoreViewController.h"
#import "NullView.h"
#import "GouMee_SearchResultViewController.h"
#import "GouMee_GoodsListViewController.h"
#import "GouMee_LoginViewController.h"
#import "ConditionsView.h"
#import "GoodsssViewCell.h"
#import "FreeGoodsViewCell.h"
#import "GouMee_LiveDetailViewController.h"
@interface GouMee_RecommondViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSString *final_price__lte;
       NSString *final_price__gte;
       NSString *commission_rate__gte;
    NSString *orderString;
    NSInteger isPage;
    CGFloat selectHigh;
    
}
@property (nonatomic, assign)CGFloat threshold;
// 记录scrollView.contentInset.top
@property (nonatomic, assign)CGFloat marginTop;
@property (nonatomic, strong)NullView *nullView;
@property (nonatomic, strong)NSMutableArray *dates;
@property (nonatomic, strong)UICollectionView *ListCollectView;

@end

@implementation GouMee_RecommondViewController

-(NullView *)nullView
{
    if (!_nullView) {
        _nullView = [[NullView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-[self tabBarHeight])];
    }
    return _nullView;
    
}
-(void)getView:(NSInteger)networkCode
{
    if (networkCode == 0) {
          if (self.dates.count == 0) {
              [self.view addSubview:self.nullView];
              self.nullView.nullIocn.image = [UIImage imageNamed:@"null_icon"];
              self.nullView.nullTitle.text = @"暂无商品，去其他地方看看吧";
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
                [self getHomePage:1];
            };
        }
        
    }
  
    
}
-(NSMutableArray *)dates
{
    if (!_dates) {
        _dates = [NSMutableArray array];
    }
   return  _dates;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (self.marginTop != scrollView.contentInset.top) {
        self.marginTop = scrollView.contentInset.top;
    }
    CGPoint point = [scrollView.panGestureRecognizer translationInView:scrollView];
    CGFloat offsetYs = point.y;
     NSMutableDictionary *model  = [NSMutableDictionary dictionary];
    if (offsetYs < selectHigh) {
        /// 上滑
         [model setObject:@"1" forKey:@"haha"];

 selectHigh = 0;
    } else {
        /// 下滑
 [model setObject:@"0" forKey:@"haha"];
         selectHigh = offsetYs;

    }


//    CGFloat offsetY = scrollView.contentOffset.y;
//    CGFloat newoffsetY = offsetY + self.marginTop;
//    NSMutableDictionary *model  = [NSMutableDictionary dictionary];
//    // 临界值150，向上拖动时变透明
//    if (newoffsetY >= 0 && newoffsetY <= 44) {
//        [model setObject:@"0" forKey:@"haha"];
//
//    }else if (newoffsetY > 44){
//        [model setObject:@"1" forKey:@"haha"];
//
//    }else{
//        [model setObject:@"0" forKey:@"haha"];
//    }

    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenHeadViews" object:model];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    final_price__gte = @"";
       final_price__lte = @"";
       commission_rate__gte = @"";
    orderString = @"";
    isPage = 1;
     self.view.backgroundColor = COLOR_STR1(247, 247, 247, 1.0);
    [self getUVJson:self.title];
     UICollectionViewFlowLayout *cellLay = [[UICollectionViewFlowLayout alloc]init];
    if (self.type > 0) {
        AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.freeStatus = 99;
        ConditionsView *cvs = [[ConditionsView alloc]initWithFrame:CGRectMake(0, 0, SW, 44)];
        cvs.backgroundColor = COLOR_STR(0xf2f2f2);
             cvs.click = ^(NSString * _Nonnull orderStr) {
                 orderString = orderStr;

                 
                     [self.ListCollectView.mj_header beginRefreshing];
                 };
                 cvs.clicks = ^(NSString * _Nonnull lowStr, NSString * _Nonnull highStr, NSString * _Nonnull liStr) {
                     self->final_price__lte = highStr;
                     self->final_price__gte = lowStr;
                     self->commission_rate__gte = liStr;
                    [self.ListCollectView.mj_header beginRefreshing];
                 };
             [self.view addSubview:cvs];
          self.ListCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,44, self.view.bounds.size.width, self.view.frame.size.height-44) collectionViewLayout:cellLay];
    }
    else
    {
       self.ListCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width,self.view.frame.size.height-44) collectionViewLayout:cellLay];
        
    }

    self.ListCollectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.ListCollectView registerClass:[GoodsssViewCell class] forCellWithReuseIdentifier:@"GoodsssViewCell"];
 [self.ListCollectView registerClass:[FreeGoodsViewCell class] forCellWithReuseIdentifier:@"FreeGoodsViewCell"];
    self.ListCollectView.dataSource = self;
    self.ListCollectView.delegate = self;
    self.ListCollectView.backgroundColor = [UIColor clearColor];
    self.ListCollectView.alwaysBounceVertical = YES;
    [self.view addSubview:self.ListCollectView];
    [self getHomePage:1];
      [self.ListCollectView addHeaderRefresh:YES animation:NO headerAction:^{
          [self getHomePage:1];
      }];
      [self.ListCollectView addFooterRefresh:NO footerAction:^(NSInteger pageIndex) {
            if (pageIndex <= isPage) {
          [self getHomePage:pageIndex+1];
          }
          
      }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeGoodsNotification:) name:[NSString stringWithFormat:@"changeGoodDetails%ld",self.type] object:nil];

}
-(void)changeGoodsNotification:(NSNotification *)n
{

    [self getHomePage:1];
}
-(void)getHomePage:(NSInteger)page
{
    [self showHub];
   NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:@(page) forKey:@"page"];
    [parm setObject:@(10) forKey:@"page_size"];
    if (self.type > 0) {
        if (orderString.length > 0) {
               [parm setObject:orderString forKey:@"ordering"];
           }
        [parm setObject:@(self.type) forKey:@"custom_cat"];
        if (final_price__lte.length > 0) {
                 [parm setObject:final_price__lte forKey:@"final_price__lte"];
             }
          if (final_price__gte.length > 0) {
                 [parm setObject:final_price__gte forKey:@"final_price__gte"];
             }
          if (commission_rate__gte.length > 0) {
                 [parm setObject:commission_rate__gte forKey:@"commission_rate__gte"];
             }
    }
    else
    {
       
    }
   
    [Network GET:@"api/v1/goods/" paramenters:parm success:^(id data) {
        if ([data[@"success"] intValue] == 1) {
            if (page == 1) {
                   [_dates removeAllObjects];
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
                           [self->_dates addObject:model];
                       }
                        [self.ListCollectView reloadData];
                       [self getView:0];
                       if (self.dates.count == [data[@"data"][@"count"] intValue]) {
                           [self.ListCollectView.mj_footer endRefreshingWithNoMoreData];
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
        [self endRefrsh:self.ListCollectView];
        [self hiddenHub];
    } error:^(id data) {
        [self getView:1];
        [self endRefrsh:self.ListCollectView];
        [self hiddenHub];
    
        
    }];
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
if (self.dates.count > 0) {
      NSDictionary *model = self.dates[indexPath.row];
             if (isNotNull(model[@"live_group_info"])) {
                 if ([model[@"live_group_info"][@"live_type"] intValue] == 1) {
                      FreeGoodsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FreeGoodsViewCell" forIndexPath:indexPath];
                                                           
                                                                 [cell addModel1:model];
                                            
                                                             return cell;
                 }
                 else
                 {
                     NSString *identifier=[NSString stringWithFormat:@"GoodsssViewCell%ld%ld%@",(long)indexPath.section,(long)indexPath.row,orderString];
                                              
                                              [self.ListCollectView registerClass:[GoodsssViewCell class] forCellWithReuseIdentifier:identifier];
                                              
                                           GoodsssViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
                                                  cell.FreeIcon.hidden = NO;
                                                                 
                                                             [cell addModel:model];
                                                             
                                                              return cell;
                 }
                
             }
             else
             {
                NSString *identifier=[NSString stringWithFormat:@"GoodsssViewCell%ld%ld%@",(long)indexPath.section,(long)indexPath.row,orderString];
                                         
                                         [self.ListCollectView registerClass:[GoodsssViewCell class] forCellWithReuseIdentifier:identifier];
                                         
                                      GoodsssViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
                                                        cell.FreeIcon.hidden = YES;
                                                            
                                                        [cell addModel:model];
                                                        
                                                         return cell;
                 
             }
  }
  
  GoodsssViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsssViewCell" forIndexPath:indexPath];
    
    return cell;

}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.dates.count;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.dates.count > 0) {
                    NSDictionary *model = self.dates[indexPath.row];
                           if (isNotNull(model[@"live_group_info"])) {
                               if ([model[@"live_group_info"][@"live_type"] intValue] == 1) {
                                 return CGSizeMake(SW,scale(196));
                               }
                               else
                               {
                                return CGSizeMake(SW,scale(210));
                               }
                              
                           }
                           else
                           {
                            return CGSizeMake(SW,scale(210));
                               
                           }
                }
       
       
       
       return CGSizeMake(SW,scale(0));

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
if (self.dates.count > 0) {
              NSDictionary *model = self.dates[indexPath.row];
                     if (isNotNull(model[@"live_group_info"])) {
                         if ([model[@"live_group_info"][@"live_type"] intValue] == 1) {
                             GouMee_LiveDetailViewController *vc = [[GouMee_LiveDetailViewController alloc]init];
                             vc.ID = model[@"live_group_info"][@"id"];
                             vc.postStr = [NSString stringWithFormat:@"changeGoodDetails%ld",self.type];
                             [self.navigationController pushViewController:vc animated:YES];
                         }
                         else
                         {
                            GouMee_GoodsDetailViewController *vc = [[GouMee_GoodsDetailViewController alloc]init];
                            NSDictionary *model = _dates[indexPath.row];
                             vc.isFree = 1;
                            vc.goodId = [NSString stringWithFormat:@"%@",model[@"id"]];
                            [self.navigationController pushViewController:vc animated:YES];
                         }
                        
                     }
                     else
                     {
                        GouMee_GoodsDetailViewController *vc = [[GouMee_GoodsDetailViewController alloc]init];
                        NSDictionary *model = _dates[indexPath.row];
                        vc.goodId = [NSString stringWithFormat:@"%@",model[@"id"]];
                        [self.navigationController pushViewController:vc animated:YES];
                         
                     }
          }
//    }
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
//    if (section == 0) {
//        if (self.type == 0) {
//
//                  return UIEdgeInsetsMake(10.f,15.f,10.f,15.f);
//              }
//         return UIEdgeInsetsMake(0.f,0.f,0.f,0.f);
//    }
//    else
//    {
 return UIEdgeInsetsMake(0.f,0.f,0.f,0.f);
//    }

}
////设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
//    if (section == 0) {
//        if (self.type == 0) {
//            return 10.f;
//        }
//        return 0.f;
//    }
    return 0.f;

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
//    if (section == 0) {
//         if (self.type == 0) {
//                  return 10.f;
//              }
//    }
    return 0.f;

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
//    if (section == 2) {
//         return CGSizeMake(SW, 30);
//    }
//    else
//    {
      return CGSizeMake(SW, 0);
//    }

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
