//
//  GouMee_SetViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/2/19.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GouMee_SetViewController.h"
#import "SetViewCell.h"
#import "FeedBackViewController.h"
#import "TaobaoViewController.h"
#import "GouMee_LoginViewController.h"
#import "GouMee_AddressViewController.h"
@interface GouMee_SetViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation GouMee_SetViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self resetWhiteNavBar];
   
        [self.navigationController.navigationBar setTitleTextAttributes:@{
        NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:scale(17)],
        NSForegroundColorAttributeName: COLOR_STR(0x333333)}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
   
     self.title = @"设置";
    self.view.backgroundColor = viewColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

  
    UIButton *button = [UIButton new];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor whiteColor];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(0);
       if (@available(iOS 11.0, *)) {
              make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0);
              } else {
              make.bottom.equalTo(self.view.mas_bottom).offset(0);
              }
        make.left.mas_equalTo(0);
    }];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    [button setTitleColor:ThemeRedColor forState:UIControlStateNormal];
    button.titleLabel.font = font(14);
    [button addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
}
-(void)logout
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"是否要退出登录"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"确定"
                                  otherButtonTitles:nil,nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {

    }

}
- (void)actionSheetCancel:(UIActionSheet *)actionSheet{

}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{

}
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
}
- (UITableView *)tableView {

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.backgroundColor = viewColor;
        _tableView.delegate = self;
        _tableView.layer.cornerRadius = 8;
        _tableView.layer.masksToBounds = YES;
        _tableView.scrollEnabled = NO;
        _tableView.dataSource = self;
       _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }

    return _tableView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row < 4 && indexPath.row > 0) {

    TaobaoViewController *webView = [[TaobaoViewController alloc]init];
    if (indexPath.row == 2) {
      webView.url = @"https://kuran.goumee.com/h5/agreements/privacy-policy.html";
    }
    else if(indexPath.row ==1)
    {
        
        webView.url = @"https://kuran.goumee.com/h5/agreements/user-agreement.html";
    }
        else
        {
            webView.url = @"https://kuran.goumee.com/h5/agreements/live-policy.html";
        }


        [self.navigationController pushViewController:webView animated:YES];
        }
        else if (indexPath.row == 0)
        {
            FeedBackViewController *vc = [[FeedBackViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];

        }
    }
    else
    {
        GouMee_AddressViewController *vc = [[GouMee_AddressViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 1;
    }
    return 5;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"SetViewCell";

    SetViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        cell1 = [[SetViewCell alloc]
                 initWithStyle:UITableViewCellStyleValue1
                 reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0) {
        cell1.name.text = @"收货地址";
        cell1.line.hidden = YES;
        cell1.context.hidden = YES;
        cell1.rightBtn.hidden = NO;
    }
    else
    {
        if (indexPath.row == 0) {
            cell1.name.text = @"意见反馈";
            cell1.line.hidden = NO;
            cell1.context.hidden = YES;
            cell1.rightBtn.hidden = NO;
        }
  else  if (indexPath.row == 1) {
        cell1.name.text = @"用户协议";
        cell1.line.hidden = NO;
         cell1.context.hidden = YES;
         cell1.rightBtn.hidden = NO;
    }
   else if(indexPath.row == 2)
    {
        cell1.name.text = @"隐私政策";
        cell1.line.hidden = NO;
         cell1.context.hidden = YES;
         cell1.rightBtn.hidden = NO;
    }
        else if(indexPath.row == 3)
        {
            cell1.name.text = @"直播协议";
                  cell1.line.hidden = NO;
             cell1.context.hidden = YES;
             cell1.rightBtn.hidden = NO;
        }
        else
        {
            cell1.name.text = @"关于库然";
            cell1.line.hidden = YES;
             cell1.context.hidden = NO;
             cell1.rightBtn.hidden = YES;
        }
    }



    return cell1;

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *views = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, scale(10))];
    views.backgroundColor = viewColor;
    return views;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return scale(10);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return scale(44);
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
