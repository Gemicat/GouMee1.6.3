//
//  SquareViewController.m
//  KuRanApp
//
//  Created by 白冰 on 2020/2/7.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "SquareViewController.h"
#import "TypeGoodsViewCell.h"
#import "HomeGoodsViewCell.h"
#import "NullView.h"
#import "GSCollectionViewFlowLayout.h"
#import "GouMee_LoginViewController.h"
#import "HomeGoodsPuViewCell.h"
#import "GouMee_GoodsListViewController.h"
#import "GouMee_GoodsDetailViewController.h"
#import "Home_FuctionViewCell.h"
#import "GouMee_LiveViewController.h"
#import "UIButton+WebCache.h"
#import "HomeGoodsPinViewCell.h"
#import "GouMee_GoodsDetailViewController.h"
#import "GoumeeRegisterWebViewController.h"
#import "GouMee_LiveDetailViewController.h"
#import "HomeRecomandViewCell.h"
@interface SquareViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger isPage;
    UICollectionReusableView *headerView;

}
@property (nonatomic, strong)NullView *nullView;
@property (nonatomic, strong)UICollectionView *collectView;
@property (nonatomic, strong)NSMutableDictionary *sources;
@property (nonatomic, strong)NSMutableArray *dates;

@property (nonatomic, strong)NSDictionary *bannerDate;
@property (nonatomic, strong)NSMutableArray *bannerArr;
@end

@implementation SquareViewController
-(NSMutableArray *)dates
{
    if (!_dates) {
        _dates = [NSMutableArray array];
    }
    return  _dates;
}
-(NSMutableArray *)bannerArr
{
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return  _bannerArr;
}
-(NullView *)nullView
{
    if (!_nullView) {
        _nullView = [[NullView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
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
            self.nullView.refreshBtn.hidden = NO;
            self.nullView.click = ^{
                [self getBannerJson];
                [self typeList];
                [self getHomePage:1];
            };
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
-(NSMutableDictionary *)sources
{
    if (!_sources) {
        _sources = [NSMutableDictionary dictionary];
    }
    return  _sources;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_STR(0xf4f6f6);
   
    GSCollectionViewFlowLayout *cellLay = [[GSCollectionViewFlowLayout alloc]init];
    cellLay.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

    cellLay.minimumLineSpacing = 0;

    cellLay.minimumInteritemSpacing = 0;
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(15,scale(0), self.view.bounds.size.width-30,self.view.frame.size.height) collectionViewLayout:cellLay];
    self.collectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.collectView registerClass:[HomeGoodsPinViewCell class] forCellWithReuseIdentifier:@"HomeGoodsPinViewCell"];
      [self.collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"titleCell"];
     [self.collectView registerClass:[TypeGoodsViewCell class] forCellWithReuseIdentifier:@"TypeGoodsViewCell"];
     [self.collectView registerClass:[Home_FuctionViewCell class] forCellWithReuseIdentifier:@"Home_FuctionViewCell"];
     [self.collectView registerClass:[HomeGoodsPuViewCell class] forCellWithReuseIdentifier:@"HomeGoodsPuViewCell"];
      [self.collectView registerClass:[HomeRecomandViewCell class] forCellWithReuseIdentifier:@"HomeRecomandViewCell"];

       [self.collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headReusableView"];
    self.collectView.dataSource = self;
    self.collectView.delegate = self;
    self.collectView.backgroundColor = [UIColor clearColor];
    self.collectView.alwaysBounceVertical = YES;
    self.collectView.showsVerticalScrollIndicator = NO;
    self.collectView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectView];
    [self netWorkView];

    if (@available(iOS 11.0, *)) {

        self.collectView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.collectView addHeaderRefresh:YES animation:NO headerAction:^{
       
        [self getBannerJson];
        [self typeList];
         [self getHomePage:1];
    }];
    [self.collectView addFooterRefresh:YES  footerAction:^(NSInteger pageIndex) {
        if (pageIndex <= isPage) {
            [self getHomePage:pageIndex+1];
        }

    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeGoodsNotification:) name:@"changeGoodDetail100" object:nil];

}
-(void)netWorkView
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    // 监听网络状态
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                [self getBannerJson];
                [self typeList];
                [self getHomePage:1];

                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"暂无网络");
                [self getView:1];


                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"4G");
                [self getBannerJson];
                [self typeList];
                [self getHomePage:1];


                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                [self getBannerJson];
                [self typeList];
                [self getHomePage:1];

                break;

            default:
                break;
        }

    }];

    // 开启监测
    [manager startMonitoring];
}
-(void)changeGoodsNotification:(NSNotification *)n
{
    [self getHomePage:1];
}
-(void)getBannerJson
{
    [Network GET:@"api/consumer/v1/custom-module/" paramenters:@{@"id":@(1)} success:^(id data) {


        if (isNotNull(data)) {
            self.bannerArr = [NSMutableArray arrayWithArray:data[@"data"][@"frontend_settings"]];

        }
        [self.collectView reloadData];
         [self endRefrsh:self.collectView];
    } error:^(id data) {


         [self endRefrsh:self.collectView];
    }];
  
}
-(void)getHomePage:(NSInteger)page
{
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:@(page) forKey:@"page"];
    [parm setObject:@(10) forKey:@"page_size"];

  
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
              dispatch_main_async_safe(^{
                            [self.collectView reloadData];
             });
            if (self.dates.count == [data[@"data"][@"count"] intValue]) {
                [self.collectView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        else
        {
            if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
                AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                if (appDelegate.auditStatus == 1) {
                }
                else
                {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [Network showMessage:@"登录超时，请重新登录" duration:2.0];
                    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                    if (app.loginStatus == 0) {
                        app.loginStatus = 1;
                        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];

                    }
                }
            }
            else
            {
                [Network showMessage:data[@"message"] duration:2.0];
            }
        }
        if (self.dates.count == 0) {
            [self getView:0];
        }
        [self endRefrsh:self.collectView];
    } error:^(id data) {
        [self endRefrsh:self.collectView];
        [self getView:1];
    }];

}
-(void)typeList
{
    [Network GET:@"api/v1/goods-index/" paramenters:nil success:^(id data) {
        if ([data[@"success"] intValue] == 1) {
            _sources = [NSMutableDictionary dictionaryWithDictionary:data[@"data"]];
              dispatch_main_async_safe(^{
                            [self.collectView reloadData];
             });
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
 [self endRefrsh:self.collectView];
    } error:^(id data) {

 [self endRefrsh:self.collectView];
    }];

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        Home_FuctionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Home_FuctionViewCell" forIndexPath:indexPath];
//        [cell.rightBtn addTarget:self action:@selector(rightA) forControlEvents:UIControlEventTouchUpInside];
//        [cell.leftBtn addTarget:self action:@selector(leftA) forControlEvents:UIControlEventTouchUpInside];
//        if (self.bannerDate.count > 0) {
//            [cell.rightBtn sd_setImageWithURL:[NSURL URLWithString:self.bannerDate[@"bairenpinbo"][@"pic_url"]]  forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"goods_bg"]];
//            [cell.leftBtn sd_setImageWithURL:[NSURL URLWithString:self.bannerDate[@"mianfeijiyang"][@"pic_url"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"goods_bg"]];
//        }
//        return cell;
//    }
//   else if (indexPath.section == 1) {
//        if (indexPath.row == 4) {
//            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCell" forIndexPath:indexPath];
//
//            if (self.dates.count > 0) {
//
//            UIImageView *backImg = [UIImageView new];
//            [cell addSubview:backImg];
//            [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(15);
//                make.bottom.mas_equalTo(0);
//            }];
//            backImg.image = [UIImage imageNamed:@"jingpin"];
//            UILabel *tips = [UILabel new];
//            [cell addSubview:tips];
//            [tips mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(backImg.mas_right).offset(7);
//                make.bottom.mas_equalTo(backImg.mas_bottom).offset(2);
//            }];
//             AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
//            if (app.auditStatus == 0) {
//                 tips.text = @"直播特价，赚取佣金";
//            }
//            else
//            {
//              tips.text = @"直播特价";
//            }
//
//            tips.textColor = COLOR_STR(0x999999);
//            tips.font = font(12);
//            }
//
//            return cell;
//        }
//
//       TypeGoodsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeGoodsViewCell" forIndexPath:indexPath];
//
//      AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
//       if (isNotNull(_sources)) {
//
//        if (indexPath.row == 0) {
//
//            if (isNotNull(_sources[@"volume"])) {
//                  cell.rightIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"type_%ld",indexPath.row+1]];
//                cell.topView.backgroundColor = COLOR_STR(0xE84C71);
//
//                cell.titleLab.text = @"爆品库";
//                cell.contextLab.text = @"全网销量TOP，大众的选择，安全";
//                  cell.sources = _sources[@"volume"];
//            }
//            else
//            {
//
//            }
//
//        }
//        if (indexPath.row == 1) {
//
//              if (isNotNull(_sources[@"commission_rate"])) {
//                    cell.rightIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"type_%ld",indexPath.row+1]];
//                  cell.topView.backgroundColor = COLOR_STR(0xEA5C4F);
//                  if (app.auditStatus == 0) {
//                      cell.titleLab.text = @"高佣榜";
//                      cell.contextLab.text = @"佣金多，大赚";
//
//                  }
//                  else
//                  {
//                      cell.titleLab.text = @"上新";
//                      cell.contextLab.text = @"新品上架";
//                  }
//             cell.sources = _sources[@"commission_rate"];
//              }
//              else
//              {
//
//              }
//        }
//        if (indexPath.row == 2) {
//
//              if (isNotNull(_sources[@"douyin"])) {
//                    cell.rightIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"type_%ld",indexPath.row+1]];
//                  cell.topView.backgroundColor = COLOR_STR(0xECB53E);
//                  cell.titleLab.text = @"抖音热销";
//                  cell.contextLab.text = @"符合抖音粉丝喜好，精准";
//             cell.sources = _sources[@"douyin"];
//              }
//              else
//              {
//
//              }
//        }
//        if (indexPath.row == 3) {
//
//              if (isNotNull(_sources[@"discount"])) {
//                    cell.rightIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"type_%ld",indexPath.row+1]];
//                  cell.topView.backgroundColor = COLOR_STR(0x92D2C2);
//                  cell.titleLab.text = @"高折扣榜";
//                  cell.contextLab.text = @"折扣比例高，优惠大，实惠";
//                  cell.sources = _sources[@"discount"];
//              }
//            else
//            {
//
//            }
//        }
//
//       }
//        cell.click = ^(NSDictionary *model) {
//            [self pushDetail:model];
//        };
//        cell.moreBtn.tag = indexPath.row;
//        [cell.moreBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//
//        return cell;
//    }
    if (self.bannerArr.count == 0) {
        if (self.dates.count > 0) {
            NSDictionary *model = self.dates[indexPath.row];
            if (isNotNull(model[@"live_group_info"])) {
                if ([model[@"live_group_info"][@"live_type"] intValue] == 1) {
                    HomeGoodsPuViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeGoodsPuViewCell" forIndexPath:indexPath];

                    [cell addModel1:model];

                    return cell;
                }
                else
                {
                    NSString *identifier=[NSString stringWithFormat:@"HomeGoodsPinViewCell%ld%ld",(long)indexPath.section,(long)indexPath.row];

                    [self.collectView registerClass:[HomeGoodsPinViewCell class] forCellWithReuseIdentifier:identifier];

                    HomeGoodsPinViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

                    cell.FreeIcon.hidden = NO;
                    [cell addModel:model];

                    return cell;
                }

            }
            else
            {
                NSString *identifier=[NSString stringWithFormat:@"HomeGoodsPinViewCell%ld%ld",(long)indexPath.section,(long)indexPath.row];

                [self.collectView registerClass:[HomeGoodsPinViewCell class] forCellWithReuseIdentifier:identifier];

                HomeGoodsPinViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
                cell.FreeIcon.hidden = YES;

                [cell addModel:model];

                return cell;

            }
        }

        HomeGoodsPinViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsssViewCell" forIndexPath:indexPath];

        return cell;
    }
    if (indexPath.section < self.bannerArr.count) {
         NSDictionary *model = self.bannerArr[indexPath.section];
        if ([model[@"type"] isEqualToString:@"recommendGoods"] ||[model[@"type"] isEqualToString:@"highDiscount"]||[model[@"type"] isEqualToString:@"douyinHotSale"]||[model[@"type"] isEqualToString:@"highCommission"]||[model[@"type"] isEqualToString:@"hotSale"]) {
                   TypeGoodsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeGoodsViewCell" forIndexPath:indexPath];

                  AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                        if ([model[@"type"] isEqualToString:@"hotSale"]) {
                              cell.moreBtn.tag = 0;
                              cell.rightIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"type_%ld",indexPath.row+1]];
                            cell.topView.backgroundColor = COLOR_STR(0xE84C71);

                            cell.titleLab.text = @"爆品库";
                            cell.contextLab.text = @"全网销量TOP，大众的选择，安全";
                              cell.sources = _sources[@"volume"];
                        }
                        else
                        {

                        }


                          if ([model[@"type"] isEqualToString:@"highCommission"]) {
                                cell.moreBtn.tag = 1;
                                cell.rightIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"type_%ld",indexPath.row+1]];
                              cell.topView.backgroundColor = COLOR_STR(0xEA5C4F);
                              if (app.auditStatus == 0) {
                                  cell.titleLab.text = @"高佣榜";
                                  cell.contextLab.text = @"佣金多，大赚";

                              }
                              else
                              {
                                  cell.titleLab.text = @"上新";
                                  cell.contextLab.text = @"新品上架";
                              }
                         cell.sources = _sources[@"commission_rate"];
                          }
                          else
                          {

                          }

                          if ([model[@"type"] isEqualToString:@"douyinHotSale"]) {
                                cell.rightIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"type_%ld",indexPath.row+1]];
                              cell.topView.backgroundColor = COLOR_STR(0xECB53E);
                              cell.titleLab.text = @"抖音热销";
                              cell.contextLab.text = @"符合抖音粉丝喜好，精准";
                         cell.sources = _sources[@"douyin"];
                                cell.moreBtn.tag = 2;
                          }
                          else
                          {

                          }


                          if ([model[@"type"] isEqualToString:@"highDiscount"]) {
                                cell.rightIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"type_%ld",indexPath.row+1]];
                              cell.topView.backgroundColor = COLOR_STR(0x92D2C2);
                              cell.titleLab.text = @"高折扣榜";
                              cell.contextLab.text = @"折扣比例高，优惠大，实惠";
                              cell.sources = _sources[@"discount"];
                                cell.moreBtn.tag = 3;
                          }
                        else
                        {

                        }

                    cell.click = ^(NSDictionary *model) {
                        [self pushDetail:model];
                    };

                    [cell.moreBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

                    return cell;
            //    }
        }
        else
        {

        Home_FuctionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Home_FuctionViewCell" forIndexPath:indexPath];

            if ([model[@"type"] isEqualToString:@"app-swiper"]) {
                cell.rightBtn.hidden = YES;
                cell.customCellScrollViewDemo.hidden = NO;
                [cell addModel:model];
                cell.click = ^(NSDictionary *selectM) {
                    [self pushView:selectM];
                };
            }
            else
            {
                cell.rightBtn.hidden = NO;
                cell.customCellScrollViewDemo.hidden = YES;
            [cell.rightBtn sd_setImageWithURL:[NSURL URLWithString:model[@"items"][indexPath.row][@"imgUrl"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
            }
             return cell;

        }


    }
    else if (indexPath.section == self.bannerArr.count)
    {
        HomeRecomandViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeRecomandViewCell" forIndexPath:indexPath];

                    return cell;
                }

    if (self.dates.count > 0) {
        NSDictionary *model = self.dates[indexPath.row];
               if (isNotNull(model[@"live_group_info"])) {
                   if ([model[@"live_group_info"][@"live_type"] intValue] == 1) {
                        HomeGoodsPuViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeGoodsPuViewCell" forIndexPath:indexPath];
                                                             
                                                                   [cell addModel1:model];
                                              
                                                               return cell;
                   }
                   else
                   {
                       NSString *identifier=[NSString stringWithFormat:@"HomeGoodsPinViewCell%ld%ld",(long)indexPath.section,(long)indexPath.row];
                          
                          [self.collectView registerClass:[HomeGoodsPinViewCell class] forCellWithReuseIdentifier:identifier];
                          
                       HomeGoodsPinViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
                                         
                       cell.FreeIcon.hidden = NO;
                                         [cell addModel:model];
                                         
                                          return cell;
                   }
                  
               }
               else
               {
                  NSString *identifier=[NSString stringWithFormat:@"HomeGoodsPinViewCell%ld%ld",(long)indexPath.section,(long)indexPath.row];
                                           
                                           [self.collectView registerClass:[HomeGoodsPinViewCell class] forCellWithReuseIdentifier:identifier];
                                           
                                        HomeGoodsPinViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
                                                      cell.FreeIcon.hidden = YES;
                                                              
                                                          [cell addModel:model];
                                                          
                                                           return cell;
                   
               }
    }
    
    HomeGoodsPinViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeGoodsPinViewCell" forIndexPath:indexPath];

    return cell;


}
-(void)click:(UIButton *)sender
{
        GouMee_GoodsListViewController *list = [[GouMee_GoodsListViewController alloc]init];
            NSArray *arr = @[@"volume",@"commission_rate",@"douyin",@"discount"];
            NSArray *arr1 = @[@"爆品库",@"高佣榜",@"抖音热销",@"高折扣榜"];
            list.title = arr1[sender.tag];
            list.ordering = arr[sender.tag];
            [self.navigationController pushViewController:list animated:YES];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.bannerArr.count == 0) {
        return 1;
    }
    return self.bannerArr.count+2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.bannerArr.count == 0) {
       return  self.dates.count;
    }
    if (section < self.bannerArr.count) {
        NSDictionary *model = self.bannerArr[section];
        if ([model[@"type"] isEqualToString:@"app-swiper"]) {
            return 1;
        }
         if ([model[@"type"] isEqualToString:@"recommendGoods"] ||[model[@"type"] isEqualToString:@"highDiscount"]||[model[@"type"] isEqualToString:@"douyinHotSale"]||[model[@"type"] isEqualToString:@"highCommission"]||[model[@"type"] isEqualToString:@"hotSale"])
         {
             if ([model[@"type"] isEqualToString:@"recommendGoods"]) {
                 return 0;
             }
             return 1;
         }
        return [self.bannerArr[section][@"items"] count];
    }
    else if (section == self.bannerArr.count)
    {
        return 1;
    }

    return self.dates.count;



}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == self.bannerArr.count) {
//
//        if (self.bannerDate.count > 0) {
//            NSDictionary *model = self.bannerDate[@"bairenpinbo"];
//            CGFloat height = [model[@"height"] intValue];
//            CGFloat width = [model[@"weight"] intValue];
//            return CGSizeMake(SW, (SW/2.0-25)*height/width+scale(8));
//        }
//
//        return CGSizeMake(SW,0.f);
//    }
//    if (indexPath.section == 1) {
//        if (indexPath.row == 4) {
//            return CGSizeMake(SW,scale(30));
//        }
//       else if (indexPath.row == 0) {
//
//            if (!isNotNull(_sources[@"volume"])) {
//                return CGSizeMake(0,scale(0));
//            }
//             return CGSizeMake(SW,scale(228));
//
//        }
//       else if (indexPath.row == 1) {
//            if (!isNotNull(_sources[@"commission_rate"])) {
//                return CGSizeMake(SW,0.f);
//            }
//             return CGSizeMake(SW,scale(228));
//
//        }
//       else if (indexPath.row == 2) {
//            if ( !isNotNull(_sources[@"douyin"])) {
//                return CGSizeMake(0,0.f);
//            }
//             return CGSizeMake(SW,scale(228));
//
//        }
//       else if (indexPath.row == 3) {
//
//            if (!isNotNull(_sources[@"discount"])) {
//                return CGSizeMake(0,0.f);
//            }
//             return CGSizeMake(SW,scale(228));
//
//        }
//          return CGSizeMake(0,scale(0));
//
//    }
    if (self.bannerArr.count == 0) {
        if (self.dates.count > 0) {
            NSDictionary *model = self.dates[indexPath.row];
            if (isNotNull(model[@"live_group_info"])) {
                if ([model[@"live_group_info"][@"live_type"] intValue] == 1) {
                    return CGSizeMake(SW-30,scale(196));
                }
                else
                {
                    return CGSizeMake(SW-30,scale(210));
                }

            }
            else
            {
                return CGSizeMake(SW-30,scale(210));

            }
        }



        return CGSizeMake(SW-30,scale(0));
    }
    if (indexPath.section < self.bannerArr.count) {
                    NSDictionary *model = self.bannerArr[indexPath.section];
        if ([model[@"type"] isEqualToString:@"recommendGoods"] ||[model[@"type"] isEqualToString:@"highDiscount"]||[model[@"type"] isEqualToString:@"douyinHotSale"]||[model[@"type"] isEqualToString:@"highCommission"]||[model[@"type"] isEqualToString:@"hotSale"]) {
            if ([model[@"type"] isEqualToString:@"recommendGoods"]) {
                return CGSizeMake(0,scale(0));
            }
              return CGSizeMake(SW,scale(210));
        }
        else
        {

            CGFloat height = [model[@"height"] intValue];
            CGFloat width = [model[@"width"] intValue];
            NSInteger count = [model[@"split"] intValue];

         if (count == 2)
        {

        return CGSizeMake((SW/2.0-15), (SW/2.0-15)*height/width);


        }
        else if (count == 3)
        {

            return CGSizeMake((SW/3.0-10), (SW/3.0-10)*height/width);
        }

                return CGSizeMake(SW-30, (SW-30)*height/width);
        }

    }
    else if (indexPath.section == self.bannerArr.count)
    {
        if (self.dates.count > 0) {
             return CGSizeMake(SW-30,scale(20));
        }
 return CGSizeMake(0,scale(0));
    }

    if (self.dates.count > 0) {
                 NSDictionary *model = self.dates[indexPath.row];
                        if (isNotNull(model[@"live_group_info"])) {
                            if ([model[@"live_group_info"][@"live_type"] intValue] == 1) {
                              return CGSizeMake(SW-30,scale(196));
                            }
                            else
                            {
                             return CGSizeMake(SW-30,scale(210));
                            }
                           
                        }
                        else
                        {
                         return CGSizeMake(SW-30,scale(210));
                            
                        }
             }
    
    
    
    return CGSizeMake(SW,scale(0));

}
-(void)leftA
{
    GouMee_LiveViewController *vc = [[GouMee_LiveViewController alloc]init];
    vc.moduleType = 1;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)rightA
{
    self.tabBarController.selectedIndex = 1;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == self.bannerArr.count+1) {
        
        if (self.dates.count > 0) {
               NSDictionary *model = self.dates[indexPath.row];
            [self pushDetail:model];
           }

    }
    else if (indexPath.section < self.bannerArr.count)
    {

   NSDictionary *model = self.bannerArr[indexPath.section][@"items"][indexPath.row];
        [self pushView:model];

        NSLog(@"----------------%@",model);




    }
}
-(void)pushView:(NSDictionary *)model
{
    NSString *str = [NSString stringWithFormat:@"%@",model[@"value"]];
    if ([str isEqualToString:@"pinbo"]) {
        [self rightA];
    }
    if ([str isEqualToString:@"sample"]) {
        [self leftA];
    }
    if ([model[@"type"] isEqualToString:@"link"]) {
        GoumeeRegisterWebViewController *web = [[GoumeeRegisterWebViewController alloc]init];
        web.urlStr = model[@"value"];
        [self.navigationController pushViewController:web animated:YES];
    }
    if ([model[@"type"] isEqualToString:@"goods"]) {
        //            GouMee_GoodsDetailViewController *goods = [[GouMee_GoodsDetailViewController alloc]init];
        [self getgoodsUrl:model[@"value"]];
        //            goods.goodId = model[@"value"];
        //            [self.navigationController pushViewController:goods animated:YES];
    }

}
-(void)getgoodsUrl:(NSString *)ID
{
    [Network GET:[NSString stringWithFormat:@"api/v1/good-items/?item_id=%@",ID] paramenters:nil success:^(id data) {
        if ([data[@"success"] integerValue] == 1) {
            if (isNotNull(data[@"data"][@"results"])) {
                NSDictionary *model = [data[@"data"][@"results"] lastObject];
                [self pushDetail:model];
            }
        }
    } error:^(id data) {

    }];

}
-(void)pushDetail:(NSDictionary *)model
{
    if (isNotNull(model[@"live_group_info"])) {
                            if ([model[@"live_group_info"][@"live_type"] intValue] == 1) {
                                GouMee_LiveDetailViewController *vc = [[GouMee_LiveDetailViewController alloc]init];
                                vc.ID = model[@"live_group_info"][@"id"];
                                vc.postStr = @"changeGoodDetail100";
                                [self.navigationController pushViewController:vc animated:YES];
                            }
                            else
                            {
                               GouMee_GoodsDetailViewController *vc = [[GouMee_GoodsDetailViewController alloc]init];
                                vc.isFree = 1;
                               vc.goodId = [NSString stringWithFormat:@"%@",model[@"id"]];
                               [self.navigationController pushViewController:vc animated:YES];
                            }
                           
                        }
                        else
                        {
                           GouMee_GoodsDetailViewController *vc = [[GouMee_GoodsDetailViewController alloc]init];
                           vc.goodId = [NSString stringWithFormat:@"%@",model[@"id"]];
                           [self.navigationController pushViewController:vc animated:YES];
                            
                        }
    
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0,0);
}
////设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{

        return 0;

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{

    return 0;


}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    if (self.bannerArr.count > 0) {
        if (section < self.bannerArr.count) {
 return CGSizeMake(SW, scale(10));
        }
         return CGSizeMake(SW, scale(0));
    }
     return CGSizeMake(SW, scale(0));

}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headReusableView" forIndexPath:indexPath];
        headerView.backgroundColor = viewColor;

        return headerView;

    return nil;
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
