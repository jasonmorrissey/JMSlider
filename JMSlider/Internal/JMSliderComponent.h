//  Created by Jason Morrissey - jasonmorrissey.org

#import <UIKit/UIKit.h>
#import "JMSlider.h"

@interface JMSliderComponent : UIView 

@property (nonatomic, weak) JMSlider * slider;
@property (nonatomic, assign) BOOL highlighted;
@property (nonatomic, strong) NSString * title;

- (id)initWithFrame:(CGRect)frame forSlider:(JMSlider *)slider;

@end
