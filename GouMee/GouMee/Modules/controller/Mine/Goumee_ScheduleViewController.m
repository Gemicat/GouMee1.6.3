//
//  Goumee_ScheduleViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/3/14.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "Goumee_ScheduleViewController.h"
#import "ScheduleViewCell.h"
#import "Goumee_ScheduleListViewController.h"
#import "NullView.h"
#import "GouMee_LoginViewController.h"
@interface Goumee_ScheduleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)NSMutableArray *dates;
@property (nonatomic, strong)UICollectionView *ListCollectView;
@property (nonatomic, strong)NullView *nullView;
@end

@implementation Goumee_ScheduleViewController
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
                            self.nullView.nullTitle.text = @"暂无更多直播排期";
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
    self.title = @"直播排期";
    
     _dates = [NSMutableArray array];
        self.view.backgroundColor = COLOR_STR(0xf5f5f5);
         UICollectionViewFlowLayout *cellLay = [[UICollectionViewFlowLayout alloc]init];
        self.ListCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, SH) collectionViewLayout:cellLay];
           self.ListCollectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
         
        [self.ListCollectView registerClass:[ScheduleViewCell class] forCellWithReuseIdentifier:@"ScheduleViewCell"];

           self.ListCollectView.dataSource = self;
           self.ListCollectView.delegate = self;
           self.ListCollectView.backgroundColor = [UIColor clearColor];
           self.ListCollectView.alwaysBounceVertical = YES;
           [self.view addSubview:self.ListCollectView];
        [self json:1];
        [self.ListCollectView addHeaderRefresh:YES animation:NO headerAction:^{
            [self json:1];
        }];
    }
-(void)json:(NSInteger)page
    {
       
        NSMutableDictionary *parm = [NSMutableDictionary dictionary];
//        [parm setObject:@(page) forKey:@"page"];
//        [parm setObject:@(self.cateID) forKey:@"custom_cat"];
//        [parm setObject:@(10) forKey:@"page_size"];
        [Network GET:@"api/v1/groups/live-schedules/" paramenters:parm success:^(id data) {
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
                for (NSDictionary *model in data[@"data"]) {
                    [_dates addObject:model];
                    [self.ListCollectView reloadData];
                }
            }
           
            }
             [self getView:0];
        } error:^(id data) {
            [self getView:1];

        }];
        
    }
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
    {
       
        ScheduleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ScheduleViewCell" forIndexPath:indexPath];
        if (self.dates.count > 0) {
            [cell addModel:_dates[indexPath.row]];
        }
                   return cell;
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

        return CGSizeMake(SW,scale(145));

    }
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
    {
      
        Goumee_ScheduleListViewController *vc = [[Goumee_ScheduleListViewController alloc]init];
        NSDictionary *model = _dates[indexPath.row];
        vc.LastModel = model;
        vc.time = [model[@"live_time"] substringToIndex:10];;
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
