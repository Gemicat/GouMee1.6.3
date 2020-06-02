//
//  GouMee_SearchResultViewController.m
//  GouMee
//
//  Created by 白冰 on 2019/12/12.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GouMee_SearchResultViewController.h"
#import "ConditionsView.h"
#import "GoodsssViewCell.h"
#import "GouMee_LoginViewController.h"
#import "GouMee_GoodsDetailViewController.h"
#import "NullView.h"
#import <MJRefresh.h>
#import "FreeGoodsViewCell.h"
#import "GouMee_LiveDetailViewController.h"
@interface GouMee_SearchResultViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSString *final_price__lte;
    NSString *final_price__gte;
    NSString *commission_rate__gte;
    NSInteger isPage;
    NSInteger currentPage;
    NSMutableDictionary *cellIdentifyDic;
}
@property (nonatomic, strong)NullView *nullView;
@property (nonatomic, strong)UICollectionView *ListCollectView;
@property (nonatomic, strong)NSMutableArray *dates;
@end

@implementation  GouMee_SearchResultViewController

-(NSMutableArray *)dates
{
    if (!_dates) {
        _dates = [NSMutableArray array];
    }
    return _dates;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
     [self resetWhiteNavBar];
}
-(NullView *)nullView
{
    if (!_nullView) {
        _nullView = [[NullView alloc]initWithFrame:CGRectMake(0, 44, SW, self.view.frame.size.height-44)];
    }
    return _nullView;
    
}
-(void)getView
{
    if (self.dates.count == 0) {
        [self.view addSubview:self.nullView];
        self.nullView.nullIocn.image = [UIImage imageNamed:@"null_search"];
        self.nullView.nullTitle.text = @"未找到相关商品";
        self.nullView.refreshBtn.hidden = YES;
    }
    else
    {
        [self.nullView removeFromSuperview];
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.navigationController popViewControllerAnimated:NO];
    return NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = viewColor;
     self.automaticallyAdjustsScrollViewInsets = NO;
    cellIdentifyDic = [NSMutableDictionary dictionary];
    [self searchNavigationBar];
    final_price__gte = @"";
    final_price__lte = @"";
    commission_rate__gte = @"";
    isPage = 1;
    currentPage = 1;
    ConditionsView *cvs = [[ConditionsView alloc]initWithFrame:CGRectMake(0, 0, SW, 44)];
      AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (self.isFree) {

        appDelegate.freeStatus = 100;
    }
    else
    {
 appDelegate.freeStatus = 99;

    }

    cvs.click = ^(NSString * _Nonnull orderStr) {
        self->_ordering = orderStr;
     
        
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
     self.ListCollectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:cellLay];
        self.ListCollectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.ListCollectView.dataSource = self;
        self.ListCollectView.delegate = self;
        self.ListCollectView.backgroundColor = [UIColor clearColor];
        self.ListCollectView.alwaysBounceVertical = YES;
        [self.view addSubview:self.ListCollectView];
    [self.ListCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_equalTo(cvs.mas_bottom).offset(0);
    }];
  
    [self getHomePage:1];
    [self.ListCollectView addHeaderRefresh:YES animation:NO headerAction:^{
        [self getHomePage:1];
    }];
    [self.ListCollectView addFooterRefresh:NO footerAction:^(NSInteger pageIndex) {
          if (pageIndex <= isPage) {
        [self getHomePage:pageIndex+1];
        }
        
    }];
    }
-(void)getHomePage:(NSInteger)page
{
    [self showHub];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    cellIdentifyDic = [NSMutableDictionary dictionary];
    [parm setObject:@(page) forKey:@"page"];
    [parm setObject:@(10) forKey:@"page_size"];
    [parm setObject:self.keyword forKey:@"search"];
    if (_ordering.length > 0) {
        [parm setObject:_ordering forKey:@"ordering"];
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
    cellIdentifyDic = parm;
    NSString *url;

    if (self.isFree == 1) {
        url = @"api/v1/live-groups/";
    }
    else
    {
         url = @"api/v1/goods/";
    }
    [Network GET:url paramenters:parm success:^(id data) {
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
            [self getView];
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
                GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
         else
         {
         [Network showMessage:data[@"message"] duration:2.0];
         }
        }
        [self hiddenHub];
    } error:^(id data) {
        [self hiddenHub];
    }];
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
    {
       NSString *identifier = [cellIdentifyDic objectForKey:[NSString stringWithFormat:@"%@%@", indexPath,cellIdentifyDic]];
        
      if (self.dates.count > 0) {
            NSDictionary *model = self.dates[indexPath.row];
                   if (isNotNull(model[@"live_group_info"])) {
                       if ([model[@"live_group_info"][@"live_type"] intValue] == 1) {
                           if (identifier == nil) {
                               identifier = [NSString stringWithFormat:@"NewTravelMediaCell%@%@", [NSString stringWithFormat:@"%@", indexPath],cellIdentifyDic];
                               [collectionView registerClass:[FreeGoodsViewCell class] forCellWithReuseIdentifier:identifier];
                           }
                            FreeGoodsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
                                                                 
                            [cell addModel1:model];
                                                  
                                                                   return cell;
                       }
                       else
                       {
                          if (identifier == nil) {
                                    identifier = [NSString stringWithFormat:@"NewTravelMediaCell%@%@", [NSString stringWithFormat:@"%@", indexPath],cellIdentifyDic];
                            
                                    [collectionView registerClass:[GoodsssViewCell class] forCellWithReuseIdentifier:identifier];
                                                    }
                                                    
                                                 GoodsssViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
                                                                   
                                                                       for (id subView in cell.contentView.subviews) {
                                                                              if (subView){
                                                                                  [subView removeFromSuperview];
                                                                              }
                                                                           }
                                                                   [cell addModel:model];
                                                                   cell.FreeIcon.hidden = NO;
                                                                    return cell;
                       }
                      
                   }
                   else
                   {
                       if (identifier == nil) {
                            identifier = [NSString stringWithFormat:@"NewTravelMediaCell%@%@", [NSString stringWithFormat:@"%@", indexPath],cellIdentifyDic];
                
                                    [collectionView registerClass:[GoodsssViewCell class] forCellWithReuseIdentifier:identifier];
                                                }
                                               
                                             
                                            GoodsssViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
                                                              for (id subView in cell.contentView.subviews) {
                                                                     if (subView){
                                                                         [subView removeFromSuperview];
                                                                     }
                                                                  }
                                                                  
                                                              [cell addModel:model];
                                                              cell.FreeIcon.hidden = YES;
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

-(void)searchNavigationBar
{
   UITextField *_textSearch = [[UITextField alloc]initWithFrame:CGRectMake(0, 4, SW, 35)];
          _textSearch.backgroundColor = COLOR_STR(0xf5f5f5);
          _textSearch.layer.cornerRadius = 17.5;
          _textSearch.delegate = self;
       _textSearch.placeholder = @"搜索商品";
       _textSearch.font = font(13);
    _textSearch.text = self.keyword;
       _textSearch.textColor = COLOR_STR(0x333333);
      _textSearch.returnKeyType = UIReturnKeySearch;
          self.navigationItem.titleView = _textSearch;
       UIView *leftViews = [[UIView alloc]initWithFrame:CGRectMake(0, 6, 40, 34)];
       _textSearch.leftView = leftViews;
       _textSearch.leftViewMode = UITextFieldViewModeAlways;
       UIImageView *leftIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 16, 16)];
       [leftViews addSubview:leftIcon];
       leftIcon.image = [UIImage imageNamed:@"f_search"];
    UIImage *img = [[UIImage imageNamed:@"nav"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
}
-(void)cancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
