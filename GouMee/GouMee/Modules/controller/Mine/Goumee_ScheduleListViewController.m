//
//  Goumee_ScheduleListViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/3/14.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "Goumee_ScheduleListViewController.h"
#import "ScheduleListViewCell.h"
#import "NullView.h"
#import "WelfareViewController.h"
#import "GouMee_LoginViewController.h"
@interface Goumee_ScheduleListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)NSMutableArray *dates;
@property (nonatomic, strong)UICollectionView *ListCollectView;
@property (nonatomic, strong)NullView *nullView;
@end

@implementation Goumee_ScheduleListViewController
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
    
    UIView *topView = [UIView new];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(scale(44));
    }];
    topView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [UILabel new];
    [topView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scale(15));
        make.centerY.mas_equalTo(0);
    }];
    label.textColor = COLOR_STR(0x333333);
    label.font = font1(@"PingFangSC-Medium", scale(14));
    NSString *num = [NSString stringWithFormat:@"%@",self.LastModel[@"good_count"]];
     NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:[NSString stringWithFormat:@"%@",self.LastModel[@"live_time"]] andFormatter:@"YYYY-MM-dd HH:mm"] andFormatter:@"MM月dd日"];
     NSString *str = [NSString stringWithFormat:@"%@共 %@ 款商品",time,num];
    NSMutableAttributedString * attriStrT = [[NSMutableAttributedString alloc] initWithString:str];
      
       [attriStrT addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(str.length-num.length-4, num.length)];
   
    label.attributedText = attriStrT;
     
    
    
     _dates = [NSMutableArray array];
        self.view.backgroundColor = COLOR_STR(0xf5f5f5);
         UICollectionViewFlowLayout *cellLay = [[UICollectionViewFlowLayout alloc]init];
        self.ListCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,scale(44), self.view.bounds.size.width, SH-scale(44)) collectionViewLayout:cellLay];
           self.ListCollectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
         
        [self.ListCollectView registerClass:[ScheduleListViewCell class] forCellWithReuseIdentifier:@"ScheduleListViewCell"];

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
        [parm setObject:@(page) forKey:@"page"];
        [parm setObject:self.time forKey:@"date"];
        [parm setObject:@(10) forKey:@"page_size"];
        [Network GET:@"api/consumer/v1/live-schedule-byday/" paramenters:parm success:^(id data) {
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
                    [self.ListCollectView reloadData];
                }
            }
            [self getView:0];
            }
        } error:^(id data) {
            [self getView:1];
        }];
        
    }
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
    {
       
        ScheduleListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ScheduleListViewCell" forIndexPath:indexPath];
        if (self.dates.count > 0) {
            [cell addModel:self.dates[indexPath.row]];
        }
        cell.seeBtn.tag = indexPath.row + 7000;
        [cell.seeBtn addTarget:self action:@selector(see:) forControlEvents:UIControlEventTouchUpInside];

                   return cell;
}
-(void)see:(UIButton *)sender
{
    WelfareViewController *vc = [[WelfareViewController alloc]init];
    NSDictionary *model = self.dates[sender.tag - 7000];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];


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
            if ([model[@"kuran_fuli"] integerValue] == 1) {
 return CGSizeMake(SW,scale(200));
            }
            else
            {
                 return CGSizeMake(SW,scale(150));
            }
        }
        return CGSizeMake(SW,scale(0));

    }
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
    {
      
       
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
