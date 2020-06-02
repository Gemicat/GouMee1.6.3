//
//  YinHotViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/4/26.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "YinHotViewController.h"
#import "GoodsDetailViewCell.h"
#import <UIButton+WebCache.h>
@interface YinHotViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dates;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat contentY;
@end

@implementation YinHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"萤火虫下载帮助";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    self.contentY = 0;
    for (int i = 1; i < 10; i++) {
        NSString *url = [NSString stringWithFormat:@"https://kuran-oss.oss-cn-hangzhou.aliyuncs.com/app-image/weapp/yihoc_%d.png",i];
       UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        //手动计算cell
        CGFloat imgHeight = image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.scrollView addSubview:button];
        button.adjustsImageWhenDisabled=NO;

        button.adjustsImageWhenHighlighted=NO;
        [button sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, self.contentY, SW, imgHeight);
        button.tag = i+10000;
        [button addTarget:self action:@selector(buttons:) forControlEvents:UIControlEventTouchUpInside];
        self.contentY = self.contentY+imgHeight;
    }
    [self updateScrollViewContentSize];

}


- (void)updateScrollViewContentSize {

    if (self.contentY <= self.scrollView.frame.size.height) {

        self.contentY = self.scrollView.frame.size.height + 1;
    }

    self.scrollView.contentSize = CGSizeMake(SW, self.contentY);
}

#pragma mark - getter
- (UIScrollView *)scrollView {

    if (!_scrollView) {

        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SW, self.view.frame.size.height-[self navHeight])];
        _scrollView.backgroundColor = viewColor;
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.contentSize = CGSizeMake(SW, SH+ 1);
        _scrollView.userInteractionEnabled = YES;
        //        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }

    return _scrollView;
}


-(void)buttons:(UIButton *)sender
{
    NSInteger type = sender.tag-10000;

    if (type== 5) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];

        pasteboard.string = @"https://www.yihoc.com/dataPlugin";
        [Network showMessages:@"萤火虫下载链接已复制" duration:2.0 picture:@"feed_success"];
    }
    else if (type == 8)
    {
        NSString *urlString = @"https://kuran-oss.oss-cn-hangzhou.aliyuncs.com/app-image/weapp/yihoc_save.png";

        dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
        dispatch_async(globalQueue, ^{

            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
            UIImage *image = [UIImage imageWithData:data]; // 取得图片

            UIImageWriteToSavedPhotosAlbum(image,self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);

        });

    }


}
- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:  (NSError*)error contextInfo:(id)contextInfo{


        if(!error) {

        [Network showMessages:@"图片已保存到相册" duration:2.0 picture:@"feed_success"];


            }else{


               }

}

@end
