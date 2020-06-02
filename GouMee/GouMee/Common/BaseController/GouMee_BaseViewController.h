//
//  GouMee_BaseViewController.h
//  GouMee
//
//  Created by 白冰 on 2019/12/11.
//  Copyright © 2019 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
typedef void(^RefreshViewBlock)(void);
typedef void(^FooterAction)(NSInteger pageIndex);
NS_ASSUME_NONNULL_BEGIN

@interface GouMee_BaseViewController : UIViewController

@property (nonatomic, assign, readonly) float navHeight;
@property (nonatomic, assign, readonly) float tabBarHeight;
@property (nonatomic, assign, readonly) float statusBarHeight;
- (BOOL)isPanBackGestureEnable;
- (void)resetMinesNavBar;
-(BOOL)isFirstGoods;
-(NSString *)PID;
-(NSString *)userId;
-(void)FirstEnterGoods;
-(void)resetBlackNavBar;
- (void)resetWhiteNavBar;
- (void)resetRedsNavBar;
-(void)resetRedNavBar;
-(void)showHub;
-(void)hiddenHub;
-(void)TableView:(UITableView *)tableView headWithRefresh:(RefreshViewBlock)block;
-(void)CollectView:(UICollectionView *)collectView headWithRefresh:(RefreshViewBlock)block;
-(void)endRefrsh:(UICollectionView *)collectView;
-(void)endRefrshTableView:(UITableView *)tableView;
-(void)TableView:(UITableView *)tableView footWithRefresh:(void(^)(NSInteger pageIndex))footerAction;
-(void)CollectView:(UICollectionView *)collectView footWithRefresh:(void(^)(NSInteger pageIndex))footerAction;
-(void)creatHub:(NSString *)text;
-(void)hiddenHub;
-(void)getUVJson:(NSString *)titles;
-(void)getVersion;
- (void)initBarItem:(UIView*)view withType:(int)type;

-(void)viewDidLayoutSubviews;
@end

NS_ASSUME_NONNULL_END
