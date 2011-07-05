//  Created by Jason Morrissey - jasonmorrissey.org

#import <UIKit/UIKit.h>
#import "JMSliderComponent.h"

@class JMSlider;

@interface JMCenterView : JMSliderComponent

+ (JMCenterView *)sliderButtonForSlider:(JMSlider *)slider withTitle:(NSString *)title;

@end
