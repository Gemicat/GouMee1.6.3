//
//  Goumee_FreeListViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/3/13.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "Goumee_FreeListViewController.h"
#import "GoodsssViewCell.h"
#import "FreeGoodsViewCell.h"
#import "GouMee_LoginViewController.h"
#import "GouMee_GoodsDetailViewController.h"
#import "GouMee_LiveDetailViewController.h"
#import "ConditionsView.h"
#import "NullView.h"
#import "GouMee_SearchViewController.h"
@interface Goumee_FreeListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
 NSInteger isPage;
    NSString *final_price__lte;
    NSString *final_price__gte;
    NSString *commission_rate__gte;
    NSString *orderString;
    CGFloat  selectHigh;
}
@property (nonatomic, assign)CGFloat threshold;
// 记录scrollView.contentInset.top
@property (nonatomic, assign)CGFloat marginTop;
@property (nonatomic, strong)NSMutableArray *dates;
@property (nonatomic, strong)UICollectionView *ListCollectView;
@property (nonatomic, strong)NullView *nullView;
@end

@implementation Goumee_FreeListViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;


}
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
                [self json:1];
            };
        }

    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"免费寄样";
     isPage = 1;
    _dates = [NSMutableArray array];
    self.view.backgroundColor = COLOR_STR(0xf5f5f5);
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.freeStatus = 100;
    ConditionsView *cvs = [[ConditionsView alloc]initWithFrame:CGRectMake(0, 0, SW, 44)];
    cvs.backgroundColor = COLOR_STR(0xffffff);
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

     UICollectionViewFlowLayout *cellLay = [[UICollectionViewFlowLayout alloc]init];
    self.ListCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,44, self.view.bounds.size.width, SH -[self navHeight]-[self tabBarHeight]-44) collectionViewLayout:cellLay];

       self.ListCollectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
       [self.ListCollectView registerClass:[GoodsssViewCell class] forCellWithReuseIdentifier:@"GoodsssViewCell"];
    [self.ListCollectView registerClass:[FreeGoodsViewCell class] forCellWithReuseIdentifier:@"FreeGoodsViewCell"];

       self.ListCollectView.dataSource = self;
       self.ListCollectView.delegate = self;
       self.ListCollectView.backgroundColor = [UIColor clearColor];
       self.ListCollectView.alwaysBounceVertical = YES;
       [self.view addSubview:self.ListCollectView];
    [self json:1];
    [self.ListCollectView addHeaderRefresh:YES animation:NO headerAction:^{
        [self json:1];
    }];
    [self.ListCollectView addFooterRefresh:NO footerAction:^(NSInteger pageIndex) {
        
          if (pageIndex <= isPage) {
               [self json:pageIndex+1];
               }
    }];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changessGoodsNotification:) name:[NSString stringWithFormat:@"changeGoodDetailss%ld",self.cateID] object:nil];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGPoint point = [scrollView.panGestureRecognizer translationInView:scrollView];
    CGFloat offsetYs = point.y;
    NSMutableDictionary *model  = [NSMutableDictionary dictionary];
    NSLog(@"-------------%f",offsetYs);
    if (offsetYs < selectHigh) {
        /// 上滑
        [model setObject:@"1" forKey:@"haha"];
         selectHigh = 0;

    } else {
        /// 下滑
        [model setObject:@"0" forKey:@"haha"];
         selectHigh = offsetYs;
    }

     [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenHeadView" object:model];

}
-(void)changessGoodsNotification:(NSNotification *)n
{
    NSDictionary *model = [n object];
    for (int i = 0; i < self.dates.count; i++) {
        NSDictionary *hh = self.dates[i];
        if ([model[@"id"] intValue] == [hh[@"id"] intValue]) {
            [self.dates replaceObjectAtIndex:i withObject:model];
            [self.ListCollectView reloadData];
        }
    }
}
-(void)jumpVC:(UIViewController *)vc{

    NSArray *vcs = self.navigationController.viewControllers;

    NSMutableArray *newVCS = [NSMutableArray array];

    if ([vcs count] > 0) {

        for (int i=0; i < [vcs count]-1; i++) {

            [newVCS addObject:[vcs objectAtIndex:i]];

        }

    }

    [newVCS addObject:vc];



    [self.navigationController setViewControllers:newVCS animated:YES];

}
-(void)json:(NSInteger)page
{
    [self showHub];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:@(page) forKey:@"page"];
    [parm setObject:@(self.cateID) forKey:@"custom_cat"];
    [parm setObject:@(10) forKey:@"page_size"];
    if (orderString.length > 0) {
        [parm setObject:orderString forKey:@"ordering"];
    }
    if (final_price__lte.length > 0) {
        [parm setObject:final_price__lte forKey:@"final_price__lte"];
    }
    if (final_price__gte.length > 0) {
        [parm setObject:final_price__gte forKey:@"final_price__gte"];
    }
    if (commission_rate__gte.length > 0) {
        [parm setObject:commission_rate__gte forKey:@"commission_rate__gte"];
    }
    [Network GET:@"api/v1/live-groups/" paramenters:parm success:^(id data) {
        if (isNotNull(data[@"data"])) {
            if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [Network showMessage:data[@"message"] duration:2.0];
                AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                if (app.loginStatus == 0) {
                    app.loginStatus = 1;
                    GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                    vc.pushType = 1;
                    [self jumpVC:vc];

                }
            }
            else
            {
            if (page == 1) {
                   _dates = [NSMutableArray array];
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
                [_dates addObject:model];

            }
            if (self.dates.count == [data[@"data"][@"count"] intValue]) {
                           [self.ListCollectView.mj_footer endRefreshingWithNoMoreData];
                       }
                       
        }
        }
        else
        {
 _dates = [NSMutableArray array];
        

        }
        [self getView:0];
         [self.ListCollectView reloadData];
        [self hiddenHub];
    } error:^(id data) {
        [self getView:1];
        [self hiddenHub];
    }];
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dates.count > 0) {
        
        NSDictionary *model = _dates[indexPath.row];
        NSInteger type = [model[@"live_type"] intValue];
        if (type == 1) {
             FreeGoodsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FreeGoodsViewCell" forIndexPath:indexPath];
                       if (isNotNull(_dates)) {
                           NSDictionary *model = self.dates[indexPath.row];
                           [cell addModel:model];
                       }
                       return cell;
        }
        else
        {
            GoodsssViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsssViewCell" forIndexPath:indexPath];
               if (isNotNull(_dates)) {
                   NSDictionary *model = self.dates[indexPath.row];
                   [cell addModel:model];
                   cell.FreeIcon.hidden = NO;
               }
               return cell;
            
        }
        
        
    }
    return nil;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dates.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dates.count > 0) {

    NSDictionary *model = _dates[indexPath.row];
    NSInteger type = [model[@"live_type"] intValue];
    if (type == 1) {
    return CGSizeMake(SW,scale(196));
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
    NSDictionary *model = _dates[indexPath.row];
           NSInteger type = [model[@"live_type"] intValue];
    if (type == 1) {

    GouMee_LiveDetailViewController *vc = [[GouMee_LiveDetailViewController alloc]init];
    vc.ID = model[@"id"];
         vc.postStr = [NSString stringWithFormat:@"changeGoodDetailss%ld",self.cateID];
    [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        GouMee_GoodsDetailViewController *vc = [[GouMee_GoodsDetailViewController alloc]init];
           vc.goodId = [NSString stringWithFormat:@"%@",model[@"good"][@"id"]];
        vc.isFree = 1;
           [self.navigationController pushViewController:vc animated:YES];
        
    }
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{

 return UIEdgeInsetsMake(0.f,0.f,0.f,0.f);
//    }

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
