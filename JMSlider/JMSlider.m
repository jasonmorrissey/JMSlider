//  Created by Jason Morrissey - jasonmorrissey.org

#import "JMSlider.h"
#import "JMCenterView.h"
#import "JMSliderTrack.h"
#import "JMSideView.h"
#import "UIView+Positioning.h"
#import "UIView+Size.h"

@interface JMSlider()

@property (nonatomic,retain) JMCenterView * centerView;
@property (nonatomic,retain) JMSliderTrack * trackView;
@property (nonatomic,retain) JMSideView * leftView;
@property (nonatomic,retain) JMSideView * rightView;
@property (nonatomic,assign) id<JMSliderDelegate> delegate;
@property (assign) CGFloat currentSlideRatio;
@property (assign) BOOL highlighted;
@property (assign) BOOL suppressCallbacks;

- (void)updateWithSlideRatio:(CGFloat)slideRatio;
- (void)resetToCenter;

- (JMCenterView *)generateCenterViewWithDefaultTitle:(NSString *)title;
- (JMSideView *)generateLeftViewWithDefaultTitle:(NSString *)title;
- (JMSideView *)generateRightViewWithDefaultTitle:(NSString *)title;
- (JMSliderTrack *)generateTrackView;

@end

@implementation JMSlider

#if NS_BLOCKS_AVAILABLE
@synthesize leftExecuteBlock = leftExecuteBlock_;
@synthesize centerExecuteBlock = centerExecuteBlock_;
@synthesize rightExecuteBlock = rightExecuteBlock_;
#endif
@synthesize highlighted = highlighted_;
@synthesize trackView = trackView_;
@synthesize centerView = centerView_;
@synthesize leftView = leftView_;
@synthesize rightView = rightView_;
@synthesize currentSlideRatio = currentSlideRatio_;
@synthesize suppressCallbacks = suppressCallbacks_;
@synthesize delegate = delegate_;

- (void)dealloc;
{
    #if NS_BLOCKS_AVAILABLE
    self.leftExecuteBlock = nil;
    self.centerExecuteBlock = nil;
    self.rightExecuteBlock = nil;
    #endif

    self.delegate = nil;
    self.trackView = nil;
    self.centerView = nil;
    self.leftView = nil;
    self.rightView = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame centerTitle:(NSString *)centerTitle leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle delegate:(id<JMSliderDelegate>)delegate;
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.backgroundColor = [UIColor clearColor];   
        
        self.delegate = delegate;
        
        self.centerView = [self generateCenterViewWithDefaultTitle:centerTitle];
        self.leftView = [self generateLeftViewWithDefaultTitle:leftTitle];
        self.rightView = [self generateRightViewWithDefaultTitle:rightTitle];
        self.trackView = [self generateTrackView];
        
        [self addSubview:self.trackView];
        [self addSubview:self.centerView];
        [self addSubview:self.leftView];
        [self addSubview:self.rightView];
        
        [self.centerView centerInSuperView];
        
        [self resetToCenter];
    }
    return self;
}

- (void) layoutSubviews;
{
    self.leftView.center = CGPointMake(self.leftView.itemOffset.x + [self trackLowCenter], self.leftView.itemOffset.y);
    self.rightView.center = CGPointMake(self.rightView.itemOffset.x + [self trackHighCenter], self.rightView.itemOffset.y);
}

- (void)resetToCenter;
{
    [UIView beginAnimations:kJMSliderAnimationCenterButton context:self.centerView];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.centerView centerInSuperView];
    [self updateWithSlideRatio:0.];
    [UIView commitAnimations];
    self.suppressCallbacks = NO;
    [self setHighlightSlider:NO];
}

- (void)updateWithSlideRatio:(CGFloat)slideRatio;
{
    self.currentSlideRatio = slideRatio;
    
    self.rightView.alpha = self.highlighted ? kJMSliderMinimumFadeOpacity : 0.;
    self.leftView.alpha = self.highlighted ? kJMSliderMinimumFadeOpacity : 0.;
    
    if (slideRatio > kJMSliderMinimumMovementBuffer)
    {
        self.rightView.alpha = slideRatio;
    }
    else if (slideRatio < (-1. * kJMSliderMinimumMovementBuffer))
    {
        self.leftView.alpha = (slideRatio * -1.);
    }
}

- (void)setButtonCenterPosition:(CGPoint)centerPoint animated:(BOOL)animated;
{
    CGFloat trackHighCenter = [self trackHighCenter];
    CGFloat trackLowCenter = [self trackLowCenter];
    if (centerPoint.x > trackHighCenter) return;
    if (centerPoint.x < trackLowCenter) return;
    
    self.centerView.center = centerPoint;
    
    [self updateWithSlideRatio:((centerPoint.x - trackLowCenter) / (trackHighCenter - trackLowCenter) - 0.5) * 2];
}



#pragma Mark - 
#pragma Mark - Accessors for Subviews

- (CGFloat)trackLowCenter;
{
    return (self.centerView.width / 2.);
}

- (CGFloat)trackHighCenter;
{
    return self.bounds.size.width - (self.centerView.width / 2.);
}

- (CGFloat)centerViewWidth;
{
    return self.centerView.size.width;
}

- (CGFloat)slideRatio;
{
    return self.currentSlideRatio;
}

#pragma Mark - 
#pragma Mark - Co-ordinators for Subviews

- (void)setHighlightSlider:(BOOL)highlighted;
{
    highlighted_ = highlighted;
    
    self.centerView.highlighted = highlighted;
    self.trackView.highlighted = highlighted;
    self.leftView.highlighted = highlighted;
    self.rightView.highlighted = highlighted;
    
    [self updateWithSlideRatio:self.currentSlideRatio];
}

- (void)releaseDragShouldCancel:(BOOL)cancelled;
{        
    if (!self.suppressCallbacks && self.slideRatio < (-1. + kJMSliderOptionActivationMargin))
    {
        self.suppressCallbacks = YES;
        if ([self.delegate respondsToSelector:@selector(slider:didSelect:)])
        {
            [self.delegate slider:self didSelect:JMSliderSelectionLeft];
        }
        #if NS_BLOCKS_AVAILABLE
        if (leftExecuteBlock_) leftExecuteBlock_();
        #endif
        [self performSelector:@selector(resetToCenter) withObject:nil afterDelay:0.8];
    }
    else if (!self.suppressCallbacks && self.slideRatio > (1. - kJMSliderOptionActivationMargin))
    {
        self.suppressCallbacks = YES;
        if ([self.delegate respondsToSelector:@selector(slider:didSelect:)])
        {
            [self.delegate slider:self didSelect:JMSliderSelectionRight];
        }
        #if NS_BLOCKS_AVAILABLE
        if (rightExecuteBlock_) rightExecuteBlock_();
        #endif
        [self performSelector:@selector(resetToCenter) withObject:nil afterDelay:0.8];
    }
    else
    {
        [self resetToCenter];
    }
    [self setHighlightSlider:NO];
}

- (void)tappedCenterView;
{
    if (fabs(self.slideRatio) < kJMSliderOptionActivationMargin)
    {
        if ([self.delegate respondsToSelector:@selector(slider:didSelect:)])
        {
            [self.delegate slider:self didSelect:JMSliderSelectionCenter];
        }
        #if NS_BLOCKS_AVAILABLE
        if (centerExecuteBlock_) centerExecuteBlock_();
        #endif        
    }
}

- (void)setLoading:(BOOL)loading;
{
    [self.centerView setLoading:loading];
}

#pragma Mark - 
#pragma Mark - Subview Generation

- (JMCenterView *)generateCenterViewWithDefaultTitle:(NSString *)title;
{
    if ([self.delegate respondsToSelector:@selector(sliderCenterViewForSlider:)])
        return [self.delegate sliderCenterViewForSlider:self];
    else
        return [JMCenterView sliderButtonForSlider:self withTitle:title];
}

- (JMSideView *)generateLeftViewWithDefaultTitle:(NSString *)title;
{
    if ([self.delegate respondsToSelector:@selector(sliderLeftViewForSlider:)])
        return [self.delegate sliderLeftViewForSlider:self];
    else
        return [JMSideView sideViewWithTitle:title];
}

- (JMSideView *)generateRightViewWithDefaultTitle:(NSString *)title;
{
    if ([self.delegate respondsToSelector:@selector(sliderRightViewForSlider:)])
        return [self.delegate sliderRightViewForSlider:self];
    else
        return [JMSideView sideViewWithTitle:title];
}

- (JMSliderTrack *)generateTrackView;
{
    if ([self.delegate respondsToSelector:@selector(sliderTrackViewForSlider:)])
        return [self.delegate sliderTrackViewForSlider:self];
    else
        return [JMSliderTrack sliderTrackForSlider:self];
}

#pragma Mark - 
#pragma Mark - Factories

+ (JMSlider *) sliderWithFrame:(CGRect)frame centerTitle:(NSString *)centerTitle leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle delegate:(id<JMSliderDelegate>)delegate;
{
    JMSlider * slider = [[[JMSlider alloc] initWithFrame:frame centerTitle:centerTitle leftTitle:leftTitle rightTitle:rightTitle delegate:delegate] autorelease];
    return slider;
}

+ (JMSlider *) sliderWithFrame:(CGRect)frame delegate:(id<JMSliderDelegate>)delegate;
{
    return [[self class] sliderWithFrame:frame centerTitle:nil leftTitle:nil rightTitle:nil delegate:delegate];
}

@end
