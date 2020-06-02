//
//  AppDelegate.h
//  GouMee
//
//  Created by 白冰 on 2019/12/10.
//  Copyright © 2019 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) NSInteger zxcs;
@property (nonatomic, assign) NSInteger auditStatus;
@property (nonatomic, assign) NSInteger freeStatus;
@property (nonatomic, strong) NSString *deviceToken;
@property (nonatomic, assign) NSInteger loginStatus;

@end

