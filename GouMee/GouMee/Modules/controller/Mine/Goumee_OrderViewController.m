//
//  Goumee_OrderViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/3/14.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "Goumee_OrderViewController.h"
#import "YHSegmentView.h"
#import "MLMSegmentManager.h"
#import "Goumee_OrderListViewController.h"
#import "Goumee_TimeView.h"
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif
@interface Goumee_OrderViewController ()

@property (nonatomic, strong) MLMSegmentHead *segHead;
@property (nonatomic, strong) MLMSegmentScroll *segScroll;
@property (nonatomic, strong) NSArray *list;
@end

@implementation Goumee_OrderViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self resetWhiteNavBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"样品订单";
   
 

              [self segmentStyle];

}

#pragma mark - 均分下划线
- (void)segmentStyle{
    
    
    self.list = @[@"全部",@"待审核",@"待发货",@"待收货",@"待寄回"];
    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(0, scale(0), SCREEN_WIDTH, scale(44)) titles:self.list headStyle:SegmentHeadStyleSlide layoutStyle:MLMSegmentLayoutCenter];
    //    _segHead.fontScale = 1.05;
    _segHead.fontSize = (16);
    /**
     *  导航条的背景颜色
     */
    _segHead.headColor = [UIColor clearColor];

    /*------------滑块风格------------*/
    /**
     *  滑块的颜色
     */
    _segHead.slideColor = COLOR_STR(0xD72E51);

    /*------------下划线风格------------*/
    /**
     *  下划线的颜色
     */
    //    _segHead.lineColor = [UIColor redColor];
    /**
     *  选中颜色
     */
    _segHead.selectColor =[UIColor whiteColor];
    /**
     *  未选中颜色
     */
    _segHead.deSelectColor = COLOR_STR(0x999999);
    /**
     *  下划线高度
     */
    //    _segHead.lineHeight = 2;
    /**
     *  下划线相对于正常状态下的百分比，默认为1
     */
    //    _segHead.lineScale = 0.8;

    /**
     *  顶部导航栏下方的边线
     */
    _segHead.bottomLineHeight = 0.0f;
    _segHead.bottomLineColor = [UIColor clearColor];
    /**
     *  设置当前屏幕最多显示的按钮数,只有在默认布局样式 - MLMSegmentLayoutDefault 下使用
     */
    //_segHead.maxTitles = 5;
   
     _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segHead.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(_segHead.frame)-[self navHeight]) vcOrViews:[self vcArr:self.list.count]];
   
    _segScroll.loadAll = NO;
    _segScroll.showIndex = self.count;
    @weakify(self)
    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
        @strongify(self)
        [self.view addSubview:self.segHead];
        [self.view addSubview:self.segScroll];
    } selectEnd:^(NSInteger index) {
        
    }];
}

- (NSArray *)vcArr:(NSInteger)count {
    NSMutableArray *arr = [NSMutableArray array];

    for (int i = 0; i < 5; i++) {
        Goumee_OrderListViewController *vc = [[Goumee_OrderListViewController alloc]init];
        if (i == 4) {
            vc.count = 7;
        }
        else
        {
            vc.count = i;
            
        }
        [arr addObject:vc];
       

    }

    return arr;
}







- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
}

@end
