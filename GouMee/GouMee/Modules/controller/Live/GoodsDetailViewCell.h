//
//  GoodsDetailViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/3/12.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
typedef void(^HeightChangedBlock)(CGFloat h);
NS_ASSUME_NONNULL_BEGIN

@interface GoodsDetailViewCell : UITableViewCell
<WKUIDelegate, WKNavigationDelegate>
//@property (nonatomic, strong)HeightChangedBlock webHeightChangedCallback;
//@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) WKWebView *webView;
//@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong)UIImageView *backImg;

@end

NS_ASSUME_NONNULL_END
