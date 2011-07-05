//  Created by Jason Morrissey - jasonmorrissey.org

#import "JMSliderComponent.h"
#import "JMSlider.h"

@implementation JMSliderComponent

@synthesize slider = slider_;
@synthesize highlighted = highlighted_;
@synthesize title = title_;

- (void)dealloc
{
    self.slider = nil;
    self.title = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame forSlider:(JMSlider *)slider;
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.slider = slider;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted;
{
    highlighted_ = highlighted;
    [self setNeedsDisplay];
}

@end
