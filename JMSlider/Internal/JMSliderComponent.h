//  Created by Jason Morrissey - jasonmorrissey.org

#import <UIKit/UIKit.h>

@class JMSlider;

@interface JMSliderComponent : UIView 

@property (nonatomic, assign) JMSlider * slider;
@property (nonatomic, assign) BOOL highlighted;
@property (nonatomic, retain) NSString * title;

- (id)initWithFrame:(CGRect)frame forSlider:(JMSlider *)slider;

@end
