//
//  LiveListViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/3/6.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "LiveListViewController.h"
#import "LiveViewCell.h"
#import "AppDelegate.h"
#import "NullView.h"
#import "GouMee_LoginViewController.h"
#import "GouMee_LiveDetailViewController.h"
@interface LiveListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
   BOOL *_isUpScroll;
    UILabel *sectionTime;
    UIView *centerVies;
    UIView *bomLines;
    UIView *topView;
    UIView *footView;
    UIView *centerViess;
    UIView *bomLiness;
    NSString *choose_time;
    NSString *choose_low;
    NSString *choose_high;
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dates;
@property (nonatomic, strong) NullView *nullView;

@end

@implementation LiveListViewController

-(NullView *)nullView
{
    if (!_nullView) {
        _nullView = [[NullView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height)];
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
                            self.nullView.nullTitle.text = @"这里空空如也，啥也没有";
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
                [self LiveJson:1];
            };
        }
        
    }
  
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    _type = appDelegate.zxcs;
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"shuai_day"];
           NSString *str1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"shuai_time"];
    
    if (isNotNull(str)) {
        choose_time = str;
    }
    if (isNotNull(str1)) {
        if ([str1 isEqualToString:@"00:00-12:00"]) {
            choose_low = @"00:00";
            choose_high = @"12:00";
        }
        if ([str1 isEqualToString:@"12:00-18:00"]) {
                   choose_low = @"12:00";
                   choose_high = @"18:00";
               }
        if ([str1 isEqualToString:@"18:00-24:00"]) {
                   choose_low = @"18:00";
                   choose_high = @"00:00";
               }
    }
    
    
    [self.view addSubview:self.tableView];
    _dates = [NSMutableArray array];
    footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, [self tabBarHeight]+50)];
    footView.hidden = YES;
    self.tableView.tableFooterView = footView;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myNotification:) name:@"test1" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timeNotification:) name:@"timePost" object:nil];
    if (self.moduleType != 1) {

    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 40)];
    [self.view addSubview:topView];
    topView.backgroundColor = COLOR_STR(0xffffff);
        topView.hidden = YES;
    centerVies = [UIView new];
    [topView addSubview:centerVies];
    [centerVies mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(scale(10.5));
        make.height.width.mas_equalTo(scale(12));
    }];
    centerVies.layer.cornerRadius = scale(6);
    centerVies.layer.masksToBounds = YES;
    
    centerVies.layer.borderWidth = 1.5;
     centerVies.layer.borderColor = [UIColor whiteColor].CGColor;
  
    bomLines = [UIView new];
       [topView addSubview:bomLines];
       [bomLines mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.mas_equalTo(0);
           make.left.mas_equalTo(scale(15));
           make.width.mas_equalTo(scale(3));
           make.top.mas_equalTo(centerVies.mas_bottom).offset(0);
       }];
        
        centerViess = [UIView new];
        [footView addSubview:centerViess];
           [centerViess mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.mas_equalTo(15);
               make.left.mas_equalTo(scale(10.5));
               make.height.width.mas_equalTo(scale(12));
           }];
           centerViess.layer.cornerRadius = scale(6);
           centerViess.layer.masksToBounds = YES;
           
           centerViess.layer.borderWidth = 1.5;
            centerViess.layer.borderColor = [UIColor whiteColor].CGColor;
        
             bomLiness = [UIView new];
            [footView addSubview:bomLiness];
            [bomLiness mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.top.mas_equalTo(footView.mas_top).offset(0);
                   make.left.mas_equalTo(scale(15));
                   make.width.mas_equalTo(scale(3));
                   make.bottom.mas_equalTo(centerViess.mas_top).offset(0);
            }];
        UILabel *label = [UILabel new];
        [footView addSubview:label];
        label.text = @"更多拼播活动，敬请期待";
        label.font = font(12);
        label.textColor = COLOR_STR(0x333333);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(centerViess.mas_centerY).offset(0);
            make.left.mas_equalTo(centerViess.mas_right).offset(scale(15));
        }];
        
        
   

    sectionTime = [UILabel new];
    [topView addSubview:sectionTime];
    [sectionTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(centerVies.mas_right).offset(10);
    }];
    sectionTime.text = @"";
    sectionTime.font = font1(@"PingFangSC-Medium", scale(14));
    
      if (_type == 2) {
             centerVies.backgroundColor = ThemeGreenColor;
                bomLines.backgroundColor = COLOR_STR(0xBDE2B2);
             centerViess.backgroundColor = COLOR_STR(0x40B71B);
             bomLiness.backgroundColor = COLOR_STR(0xBDE2B2);
          sectionTime.textColor = ThemeGreenColor;
         }
         else
         {
         centerVies.backgroundColor = ThemeRedColor;
         bomLines.backgroundColor = COLOR_STR(0xE6AFAA);
             centerViess.backgroundColor = COLOR_STR(0xD72E51);
             bomLiness.backgroundColor = COLOR_STR(0xE6AFAA);
             sectionTime.textColor = ThemeRedColor;
         }
        
        
        
    }
    [self LiveJson:1];
    [self.tableView addHeaderRefresh:YES animation:NO headerAction:^{
        [self LiveJson:1];
    }];
    [self.tableView addFooterRefresh:NO footerAction:^(NSInteger pageIndex) {
        [self LiveJson:pageIndex+1];
    }];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeGoodsNotification:) name:[NSString stringWithFormat:@"changeGoodDetail%ld",self.cateID] object:nil];
        
    }
-(void)changeGoodsNotification:(NSNotification *)n
    {
        [self hiddenHub];
        [self LiveJson:1];
    }
-(void)LiveJson:(NSInteger)page
{
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:@(self.cateID) forKey:@"custom_cat"];
    if (self.type == 1) {
         [parm setObject:@(2) forKey:@"status"];
    }
    else
    {
      [parm setObject:@(1) forKey:@"status"];
    }
   
    [parm setObject:@(page) forKey:@"page"];
    [parm setObject:@(10) forKey:@"page_size"];
    if (isNotNull(choose_time)) {
        [parm setObject:choose_time forKey:@"live_date"];
    }
    if (isNotNull(choose_low)) {
        [parm setObject:choose_low forKey:@"live_time__gte"];
    }
    if (isNotNull(choose_high)) {
        [parm setObject:choose_high forKey:@"live_time__lte"];
    }
    [self showHub];
    NSLog(@"-------------------------%@",parm);
    [Network GET:@"api/v1/groups/date-list/" paramenters:parm success:^(id data) {
        if (isNotNull(data[@"data"])) {
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
            if (page == 1) {
            
             [_dates removeAllObjects];
                for (NSDictionary *model in data[@"data"][@"result"]) {
                              [_dates addObject:model];
                          }
            }
            else
            {
             
                NSString *lastArr = _dates.lastObject[@"live_time"];
            for (NSDictionary *model in data[@"data"][@"result"]) {
                if ([lastArr isEqualToString:model[@"live_time"]] ) {
                    NSMutableArray *arr = [NSMutableArray arrayWithArray:_dates.lastObject[@"data"]];
                    for (NSDictionary *dic in model[@"data"]) {
                        [arr addObject:dic];
                    }
                    NSDictionary *haha = @{@"data":arr,@"live_time":lastArr};
                    [_dates replaceObjectAtIndex:_dates.count-1 withObject:haha];
                }
                else
                {
                    
                    [_dates addObject:model];
                }
            }
                
                
            }
          
            if (_dates.count > 0) {
                NSDictionary *model = _dates[0];
                sectionTime.text = model[@"live_time"];
                topView.hidden = NO;
                footView.hidden = NO;
            }
            else
            {
                topView.hidden = YES;
                footView.hidden = YES;
            }
             [self getView:0];
            [self.tableView reloadData];
            }
        }
        [self hiddenHub];
    } error:^(id data) {
         [self getView:1];
        [self hiddenHub];
    }];
    
}
- (void)timeNotification:(NSNotification *)n
{
    NSDictionary *dic = [n object];
    choose_time = dic[@"time"];
    choose_low = dic[@"low"];
    choose_high = dic[@"high"];
    [self.dates removeAllObjects];
    [self LiveJson:1];
}
- (void)myNotification:(NSNotification *)n
{
    //从接受到的消息n中，取出object，即消息中载入的參数
    //NSString *param = [n object];
    
    NSString *arr = [n object];
    if ([arr intValue] == 1) {
        AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        _type = appDelegate.zxcs;
        sectionTime.textColor = ThemeRedColor;
        centerVies.backgroundColor = COLOR_STR(0xD72E51);
           bomLines.backgroundColor = COLOR_STR(0xE6AFAA);
        centerViess.backgroundColor = COLOR_STR(0xD72E51);
                  bomLiness.backgroundColor = COLOR_STR(0xE6AFAA);
       
    }
    if ([arr intValue] == 2) {
        AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        _type = appDelegate.zxcs;
        sectionTime.textColor = COLOR_STR(0x40B71B);
        centerVies.backgroundColor = COLOR_STR(0x40B71B);
           bomLines.backgroundColor = COLOR_STR(0xBDE2B2);
        centerViess.backgroundColor = COLOR_STR(0x40B71B);
                  bomLiness.backgroundColor = COLOR_STR(0xBDE2B2);
        
       
    }
   
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",_type] forKey:@"type"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self LiveJson:1];
    NSLog(@"%@",arr);
}
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SW, self.view.frame.size.height-scale(44)-[self tabBarHeight]-[self navHeight]-[UIApplication sharedApplication].statusBarFrame.size.height)];
        _tableView.backgroundColor = COLOR_STR(0xf5f5f5);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
      
    }
    
    return _tableView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *model = _dates[indexPath.section][@"data"][indexPath.row];
    GouMee_LiveDetailViewController *vc = [[GouMee_LiveDetailViewController alloc]init];
    vc.ID = model[@"id"];
    vc.postStr = [NSString stringWithFormat:@"changeGoodDetail%ld",self.cateID];
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.devices.count;
    if (self.moduleType == 1) {
        return 1;
    }
    return [self.dates[section][@"data"] count];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
   
         static NSString *CellIdentifier = @"LiveViewCell";
    LiveViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        cell1 = [[LiveViewCell alloc]
                 initWithStyle:UITableViewCellStyleValue1
                 reuseIdentifier:CellIdentifier];
    }
         cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    cell1.type = _type;
        if (_dates.count > 0) {
            NSDictionary *model = _dates[indexPath.section][@"data"][indexPath.row];
            [cell1 addModel:model];
        }
   
    return cell1;
        

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dates.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     
    return scale(196);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.moduleType == 1) {
        
        return nil;
    }
    else
    {
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 35)];
    headView.backgroundColor = COLOR_STR(0xf5f5f5);
    
    UIView *centerView = [UIView new];
    [headView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(scale(10.5));
        make.height.width.mas_equalTo(scale(12));
    }];
    centerView.layer.cornerRadius = scale(6);
    centerView.layer.masksToBounds = YES;
   
    centerView.layer.borderWidth = 1.5;
     centerView.layer.borderColor = [UIColor whiteColor].CGColor;
    UIView *topLine = [UIView new];
    [headView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(scale(15));
        make.width.mas_equalTo(scale(3));
        make.bottom.mas_equalTo(centerView.mas_top).offset(0);
    }];
    
    
    UIView *bomLine = [UIView new];
       [headView addSubview:bomLine];
       [bomLine mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.mas_equalTo(0);
           make.left.mas_equalTo(scale(15));
           make.width.mas_equalTo(scale(3));
           make.top.mas_equalTo(centerView.mas_bottom).offset(0);
       }];
    if (_type == 2) {
        centerView.backgroundColor = ThemeGreenColor;
          topLine.backgroundColor = COLOR_STR(0xBDE2B2);
             bomLine.backgroundColor = COLOR_STR(0xBDE2B2);
    }
    else
    {
     centerView.backgroundColor = ThemeRedColor;
    topLine.backgroundColor = COLOR_STR(0xE6AFAA);
       bomLine.backgroundColor = COLOR_STR(0xE6AFAA);
    }
    if (section == 0) {
        topLine.hidden = YES;
        bomLine.hidden = NO;
    }
    else
    {
        topLine.hidden = NO;
        bomLine.hidden = NO;
    }
    
    UILabel *timeLab = [UILabel new];
    [headView addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(centerView.mas_centerY).offset(0);
        make.left.mas_equalTo(centerView.mas_right).offset(10);
    }];
    timeLab.textColor = COLOR_STR(0x333333);
        if (isNotNull(self.dates)) {
             NSDictionary *model = self.dates[section];
              timeLab.text = model[@"live_time"];
        }


    timeLab.font = font(14);
    return headView;
    }
    
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section{
   
        if(!_isUpScroll && (self.tableView.dragging || self.tableView.decelerating)){
            //最上面组头（不一定是第一个组头，指最近刚被顶出去的组头）又被拉回来
           NSDictionary *model = self.dates[section];
              sectionTime.text = model[@"live_time"];
            
        }
    
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    
        if((self.tableView.dragging || self.tableView.decelerating)&& _isUpScroll){
            if (self.dates.count > section+1) {
                 NSDictionary *model = self.dates[section+1];
                sectionTime.text = model[@"live_time"];
            }
            else
            {
                NSDictionary *model = self.dates.lastObject;
                               sectionTime.text = model[@"live_time"];
            }
         

    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetY = 0;
    _isUpScroll = lastOffsetY < scrollView.contentOffset.y;
    lastOffsetY = scrollView.contentOffset.y;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.moduleType == 1) {
        return 0;
    }
    return 35;
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
