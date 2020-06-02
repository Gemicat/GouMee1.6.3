

#import <UIKit/UIKit.h>

@interface LoopGoodsImgCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *text;

- (void)imageStr:(NSString*)imageStr placeholderimage:(UIImage *)placeholderimage;

@end
