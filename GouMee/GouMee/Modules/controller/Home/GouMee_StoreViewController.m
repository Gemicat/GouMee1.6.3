//
//  GouMee_StoreViewController.m
//  GouMee
//
//  Created by 白冰 on 2019/12/16.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GouMee_StoreViewController.h"
#import "StoreDetailView.h"
#import "GouMee_LoginViewController.h"
#import "GoodsssViewCell.h"
#import "FreeGoodsViewCell.h"
#import "GouMee_LiveDetailViewController.h"
#import "GouMee_GoodsDetailViewController.h"
@interface GouMee_StoreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *dates;
    NSInteger isPage;
    StoreDetailView *views;
}


@property (nonatomic, strong)UICollectionView *ListCollectView;


@end

@implementation GouMee_StoreViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
     [self resetWhiteNavBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"店铺详情";
    dates = [NSMutableArray array];
    self.view.backgroundColor = viewColor;

    views = [[StoreDetailView alloc]initWithFrame:CGRectMake(0, 0, SW, 100)];
    views.isCircle = YES;
    views.enterStore.hidden = YES;
    [self.view addSubview:views];
    if (_shopInfo) {
        views.StoreModel = _shopInfo;
    }
    UICollectionViewFlowLayout *cellLay = [[UICollectionViewFlowLayout alloc]init];
        self.ListCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,100, self.view.bounds.size.width, SH-[self navHeight]-100) collectionViewLayout:cellLay];
      
        [self.ListCollectView registerClass:[GoodsssViewCell class] forCellWithReuseIdentifier:@"GoodsssViewCell"];
        self.ListCollectView.dataSource = self;
        self.ListCollectView.delegate = self;
     [self.ListCollectView registerClass:[FreeGoodsViewCell class] forCellWithReuseIdentifier:@"FreeGoodsViewCell"];
     [self.ListCollectView registerClass:[UICollectionReusableView class]
              forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FilterReusableView"];
        self.ListCollectView.backgroundColor = viewColor;
        self.ListCollectView.alwaysBounceVertical = YES;
        [self.view addSubview:self.ListCollectView];
    [self getHomePage:1];
   [self.ListCollectView addHeaderRefresh:YES animation:NO headerAction:^{
           [self getHomePage:1];
       }];
       [self.ListCollectView addFooterRefresh:YES footerAction:^(NSInteger pageIndex) {
             if (pageIndex <= isPage) {
           [self getHomePage:pageIndex];
           }
           
       }];
    }

-(void)getHomePage:(NSInteger)page
{
    NSDictionary *parm;
   
      parm= @{@"page":@(page),@"page_size":@(10),@"seller_id":self.storeId};
  
    
    [Network GET:@"api/v1/goods/" paramenters:parm success:^(id data) {
        if ([data[@"success"] intValue] == 1) {
            if (page == 1) {
                  [dates removeAllObjects];
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
                                       [self->dates addObject:model];
                                   }
                                    [self.ListCollectView reloadData];
                        
                                   if (dates.count == [data[@"data"][@"count"] intValue]) {
                                       [self.ListCollectView.mj_footer endRefreshingWithNoMoreData];
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
       
    } error:^(id data) {
        
    }];
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
    {
       
       if (dates.count > 0) {
            NSDictionary *model = dates[indexPath.row];
                   if (isNotNull(model[@"live_group_info"])) {
                       if ([model[@"live_group_info"][@"live_type"] intValue] == 1) {
                            FreeGoodsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FreeGoodsViewCell" forIndexPath:indexPath];
                                                                 
                                                                       [cell addModel1:model];
                                                  
                                                                   return cell;
                       }
                       else
                       {
                           GoodsssViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsssViewCell" forIndexPath:indexPath];
                                             
                                  cell.FreeIcon.hidden = NO;
                                             [cell addModel:model];
                                             
                                              return cell;
                       }
                      
                   }
                   else
                   {
                      GoodsssViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsssViewCell" forIndexPath:indexPath];
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
        return dates.count;
    }

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
    {
        return CGSizeMake(SW,scale(210));

    }
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
    {
         if (dates.count > 0) {
                   NSDictionary *model = dates[indexPath.row];
                          if (isNotNull(model[@"live_group_info"])) {
                              if ([model[@"live_group_info"][@"live_type"] intValue] == 1) {
                                  GouMee_LiveDetailViewController *vc = [[GouMee_LiveDetailViewController alloc]init];
                                  vc.ID = model[@"live_group_info"][@"id"];
                                  [self.navigationController pushViewController:vc animated:YES];
                              }
                              else
                              {
                                 GouMee_GoodsDetailViewController *vc = [[GouMee_GoodsDetailViewController alloc]init];
                                 NSDictionary *model = dates[indexPath.row];
                                  vc.isFree = 1;
                                 vc.goodId = [NSString stringWithFormat:@"%@",model[@"id"]];
                                 [self.navigationController pushViewController:vc animated:YES];
                              }
                             
                          }
                          else
                          {
                             GouMee_GoodsDetailViewController *vc = [[GouMee_GoodsDetailViewController alloc]init];
                             NSDictionary *model = dates[indexPath.row];
                             vc.goodId = [NSString stringWithFormat:@"%@",model[@"id"]];
                             [self.navigationController pushViewController:vc animated:YES];
                              
                          }
               }
    }

    //设置每个item的UIEdgeInsets
    - (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
    {
    
     return UIEdgeInsetsMake(0.f,0.f,0.f,0.f);
    

    }
    ////设置每个item垂直间距
    - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
    {
       
        return 0.f;

    }
    - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
    {
       
        return 0.f;

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
