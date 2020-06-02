//
//  GoodsWebbViewCell.h
//  xiaolvlan
//
//  Created by 白冰 on 2019/5/29.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
typedef void(^HeightChangedBlock)(CGFloat h);
NS_ASSUME_NONNULL_BEGIN

@interface GoodsWebbViewCell : UICollectionViewCell<WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, strong)HeightChangedBlock webHeightChangedCallback;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong)UIImageView *backImg;
@end

NS_ASSUME_NONNULL_END
