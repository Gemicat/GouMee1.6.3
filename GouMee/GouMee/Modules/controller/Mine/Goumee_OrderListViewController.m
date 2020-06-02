//
//  Goumee_OrderListViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/3/14.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "Goumee_OrderListViewController.h"
#import "OrderListViewCell.h"
#import "Goumee_OrderDetailViewController.h"
#import "NullView.h"
#import "GouMee_LoginViewController.h"
@interface Goumee_OrderListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)NSMutableArray *dates;
@property (nonatomic, strong)UICollectionView *ListCollectView;
@property (nonatomic, strong)NullView *nullView;
@end

@implementation Goumee_OrderListViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self resetWhiteNavBar];
}
-(NullView *)nullView
{
    if (!_nullView) {
        _nullView = [[NullView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-100)];
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
                            self.nullView.nullTitle.text = @"您还没有订单";
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

    
     _dates = [NSMutableArray array];
        self.view.backgroundColor = COLOR_STR(0xf5f5f5);
         UICollectionViewFlowLayout *cellLay = [[UICollectionViewFlowLayout alloc]init];
        self.ListCollectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:cellLay];
           self.ListCollectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
         
        [self.ListCollectView registerClass:[OrderListViewCell class] forCellWithReuseIdentifier:@"OrderListViewCell"];

           self.ListCollectView.dataSource = self;
           self.ListCollectView.delegate = self;
           self.ListCollectView.backgroundColor = [UIColor clearColor];
           self.ListCollectView.alwaysBounceVertical = YES;
           [self.view addSubview:self.ListCollectView];
    [self.ListCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0);
        } else {
            make.bottom.equalTo(self.view.mas_bottom).offset(0);
        }
    }];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myNotification:) name:@"shouhuo" object:nil];
        [self json:1];
        [self.ListCollectView addHeaderRefresh:YES animation:NO headerAction:^{
            [self json:1];
        }];
    [self.ListCollectView addFooterRefresh:YES footerAction:^(NSInteger pageIndex) {
        [self json:pageIndex];
    }];
    }
-(void)myNotification:(NSNotification *)n
{
    [self json:1];
}
-(void)json:(NSInteger)page
    {
       
        NSMutableDictionary *parm = [NSMutableDictionary dictionary];
        [parm setObject:@(page) forKey:@"page"];
        [parm setObject:[self userId] forKey:@"user"];
        [parm setObject:@(10) forKey:@"page_size"];
        if (self.count > 0) {
            [parm setObject:@(self.count-1) forKey:@"status"];
        }
        [Network GET:@"api/v1/samples/" paramenters:parm success:^(id data) {
            if (isNotNull(data[@"data"])) {
                if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [Network showMessage:data[@"message"] duration:2.0];
                    GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                if (page == 1) {
                       _dates = [NSMutableArray array];
                   }
                for (NSDictionary *model in data[@"data"][@"results"]) {
                    [_dates addObject:model];
                   
                }
            }
            [self getView:0];
             [self.ListCollectView reloadData];
            }
        } error:^(id data) {
            [self getView:1];

        }];
        
    }
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
    {
       
        OrderListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OrderListViewCell" forIndexPath:indexPath];
        if (self.dates.count > 0) {
            [cell addModel:self.dates[indexPath.row]];
        }
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

        return CGSizeMake(SW,scale(149));

    }
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
    {
        Goumee_OrderDetailViewController *vc = [[Goumee_OrderDetailViewController alloc]init];
        vc.ID = [NSString stringWithFormat:@"%@",_dates[indexPath.row][@"id"]];
        [self.navigationController pushViewController:vc animated:YES];
       
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


@end
