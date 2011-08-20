//  Created by Jason Morrissey - jasonmorrissey.org

#import <UIKit/UIKit.h>
#import "JMSliderComponent.h"

@class JMSlider;

@interface JMCenterView : JMSliderComponent

@property (nonatomic,retain) UIActivityIndicatorView * activityView;

- (id)initForSlider:(JMSlider *)slider withTitle:(NSString *)title;
+ (JMCenterView *)sliderButtonForSlider:(JMSlider *)slider withTitle:(NSString *)title;

- (void)setLoading:(BOOL)loading;

// Custom drawing
- (void)drawButtonInRect:(CGRect)rect;
- (CGSize)sizeOfButton;

@end
