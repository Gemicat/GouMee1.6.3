//
//  GouMee_SearchViewController.m
//  GouMee
//
//  Created by 白冰 on 2019/12/11.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GouMee_SearchViewController.h"
#import "XDAutoresizeLabelFlow.h"
#import "XDAutoresizeLabelFlowHeader.h"
#import "XDDataBase.h"
#import "GouMee_SearchResultViewController.h"
@interface GouMee_SearchViewController ()<UITextFieldDelegate>
{
    UITextField *_textSearch;
    BOOL Ispage;
    NSInteger Ishaah;
}
@property (nonatomic, strong) XDAutoresizeLabelFlow *recordView;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation GouMee_SearchViewController
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
    
}
-(void)searchNavigationBar
{
    _textSearch = [[UITextField alloc]initWithFrame:CGRectMake(0, 4, SW, 35)];
       _textSearch.backgroundColor = COLOR_STR(0xf5f5f5);
       _textSearch.layer.cornerRadius = 17.5;
       _textSearch.delegate = self;
    _textSearch.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textSearch.placeholder = @"搜索商品";
    _textSearch.font = font(13);
    _textSearch.returnKeyType = UIReturnKeySearch;
    _textSearch.textColor = COLOR_STR(0x333333);
       self.navigationItem.titleView = _textSearch;
    UIView *leftViews = [[UIView alloc]initWithFrame:CGRectMake(0, 6, 40, 34)];
    _textSearch.leftView = leftViews;
    _textSearch.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *leftIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 16, 16)];
    [leftViews addSubview:leftIcon];
    leftIcon.image = [UIImage imageNamed:@"f_search"];
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 34)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:COLOR_STR(0x808080) forState:UIControlStateNormal];
    cancel.titleLabel.font = font(15);
    UIBarButtonItem *rightView = [[UIBarButtonItem alloc]initWithCustomView:cancel];
    self.navigationItem.rightBarButtonItem = rightView;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:nil];
}

-(void)cancelAction
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewWillAppear:(BOOL)animated
{
  
  [self resetWhiteNavBar];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self searchNavigationBar]; Ishaah = 100;
    self.dataArray = @[@[],@[]].mutableCopy;
    [[XDDataBase sharedXDDataBase] openSearchRecordDataBase];
    [self createInterface];
   
}

- (void)performSearchAction:(NSString *)keyword {

    if (keyword.length) {
        Ishaah = 99;
            [[XDDataBase sharedXDDataBase] addSearchRecordText:keyword];
            GouMee_SearchResultViewController *vc =[[GouMee_SearchResultViewController alloc]init];
            vc.keyword = keyword;
        vc.isFree = self.isFree;
            [self.navigationController pushViewController:vc animated:NO];

    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    Ishaah = 100;
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
     _textSearch.text = textField.text;
    if (Ishaah != 99) {

        [self performSearchAction:textField.text];
    }

}

#pragma mark - 数据请求 / 数据处理
#pragma mark - 视图布局
- (void)createInterface {
    // 搜索框
    // 热门搜索数据
    // collectionview
    HPWeakSelf(self)
    self.recordView = [[XDAutoresizeLabelFlow alloc] initWithFrame:CGRectMake(0, 0, HPScreenWidth, HPScreenHeight) titles:self.dataArray sectionTitles:@[@"历史搜索"] selectedHandler:^(NSIndexPath *indexPath, NSString *title) {
//        _textSearch.text = title;
        Ishaah = 99;
        [weakself performSearchAction:title];
    }];
   

    self.recordView.deleteHandler = ^(NSIndexPath *indexPath) {
        DEBUGLog(@"删除搜索记录");
        [[XDDataBase sharedXDDataBase] deleteAllSearchRecord];
        [[XDDataBase sharedXDDataBase] querySearchRecord:^(NSArray *resultArray) {
            DEBUGLog(@"%@",resultArray);
            [weakself.dataArray replaceObjectAtIndex:0 withObject:resultArray];
            [weakself.recordView reloadAllWithTitles:weakself.dataArray];
        }];
    };

    [self.view addSubview:self.recordView]; 

}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
    // 查询数据库数据 刷新搜索记录
    HPWeakSelf(self)
    [[XDDataBase sharedXDDataBase] querySearchRecord:^(NSArray *resultArray) {
        DEBUGLog(@"%@",resultArray);
        [weakself.dataArray replaceObjectAtIndex:0 withObject:resultArray];
        [weakself.recordView reloadAllWithTitles:weakself.dataArray];


      
    }];
      [_textSearch becomeFirstResponder];
    
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
