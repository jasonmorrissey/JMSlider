//  Created by Jason Morrissey - jasonmorrissey.org

#import "JMSliderTrack.h"
#import "JMSlider.h"

@implementation JMSliderTrack

- (void)dealloc;
{
    [super dealloc];
}

- (void)drawRect:(CGRect)rect;
{
    [kJMSliderTrackColor set];

    CGFloat trackSize = 1.;
    CGFloat buttonWidth = [self.slider centerViewWidth];
    CGFloat lowCenter = [self.slider trackLowCenter];
    
    CGRect trackRect = CGRectInset(rect, lowCenter + kJMSliderTrackEdgeRadius - (buttonWidth / 4.), (rect.size.height - trackSize) / 2);
    UIBezierPath * trackPath = [UIBezierPath bezierPathWithRoundedRect:trackRect cornerRadius:2.];
    [trackPath fill];

    if (self.highlighted)
    {
        CGRect leftEdgeRect = CGRectMake(CGRectGetMinX(trackRect) - kJMSliderTrackEdgeRadius, CGRectGetMidY(trackRect) - 0.5, 1., 1.);
        UIBezierPath * leftEdgePath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(leftEdgeRect, -1. * kJMSliderTrackEdgeRadius, -1. * kJMSliderTrackEdgeRadius)];
        [leftEdgePath fill];
        
        CGRect rightEdgeRect = CGRectMake(CGRectGetMaxX(trackRect) + kJMSliderTrackEdgeRadius, CGRectGetMidY(trackRect) - 0.5, 1., 1.);
        UIBezierPath * rightEdgePath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(rightEdgeRect, -1. * kJMSliderTrackEdgeRadius, -1. * kJMSliderTrackEdgeRadius)];
        [rightEdgePath fill];
    }
}

+ (JMSliderTrack *)sliderTrackForSlider:(JMSlider *)slider;
{
    JMSliderTrack * sliderTrack = [[[[self class] alloc] initWithFrame:slider.bounds forSlider:slider] autorelease];
    sliderTrack.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    return sliderTrack;
}

@end
