
#import "LoopGoodsImgCollectionViewCell.h"

@interface LoopGoodsImgCollectionViewCell ()

@property (nonatomic,strong) UIImageView *PlanADimageView;

@end

@implementation LoopGoodsImgCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.PlanADimageView = [[UIImageView alloc] init];
        self.PlanADimageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:self.PlanADimageView];
        
        
    
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.PlanADimageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)imageStr:(NSString*)imageStr placeholderimage:(UIImage *)placeholderimage;{
    
    if ([imageStr hasPrefix:@"http"]) {
         [self.PlanADimageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:placeholderimage];
    }else{
        self.PlanADimageView.image = [UIImage imageNamed:imageStr];
    }
}

@end
