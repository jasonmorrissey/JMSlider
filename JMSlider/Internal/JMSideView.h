//  Created by Jason Morrissey - jasonmorrissey.org

#import <UIKit/UIKit.h>
#import "JMSliderComponent.h"

@class JMSlider;

@interface JMSideView : JMSliderComponent

@property (assign) BOOL active;
- (CGPoint)itemOffset;
+ (JMSideView *)sideViewWithTitle:(NSString *)title;

@end
