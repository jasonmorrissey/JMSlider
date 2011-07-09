//  Created by Jason Morrissey - jasonmorrissey.org

#import "JMCenterView.h"
#import "JMSlider.h"
#import "UIView+Positioning.h"

@interface JMCenterView()
@property (assign) CGPoint touchStartPoint;
@property (nonatomic,retain) UIActivityIndicatorView * activityView;
- (CGPoint)touchPoint:(NSSet *)touches;
- (void)drawButtonInRect:(CGRect)rect;
- (CGSize)sizeOfButton;
@end

@implementation JMCenterView

@synthesize touchStartPoint = touchStartPoint_;
@synthesize activityView = activityView_;

- (void)dealloc;
{
    self.activityView = nil;
    [super dealloc];
}

#pragma Mark -
#pragma Mark - Wrappers for button (including padding)

- (void)drawRect:(CGRect)rect;
{
    CGRect buttonRect = CGRectInset(rect, kJMSliderButtonInvisiblePadding.width, kJMSliderButtonInvisiblePadding.height);
    [self drawButtonInRect:buttonRect];
}

- (CGSize)sizeThatFits:(CGSize)size;
{
    CGSize buttonSize = [self sizeOfButton];
    return CGSizeMake(buttonSize.width + kJMSliderButtonInvisiblePadding.width * 2., buttonSize.height + kJMSliderButtonInvisiblePadding.height * 2.);
}

#pragma Mark -
#pragma Mark - Button Drawing

- (void)drawButtonInRect:(CGRect)rect;
{
    [kJMButtonColor set];
    UIBezierPath * background = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:20];
    [background fill];
    
    if (self.highlighted)
    {
        [kJMButtonOutlineColor set];
        UIBezierPath * outline = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, -3., -3.) cornerRadius:20];
        [outline stroke];
    }
    
    if (!activityView_)
    {
        CGFloat textOpacity = 1. - fabs([self.slider slideRatio]);
        [[UIColor colorWithWhite:1. alpha:textOpacity] set];
        [self.title drawInRect:CGRectOffset(rect, 0, kJMButtonPadding.height -1.) withFont:kJMButtonFont lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];
    }
}

- (CGSize)sizeOfButton;
{
    CGSize titleSize = [self.title sizeWithFont:kJMButtonFont];
    return CGSizeMake(titleSize.width + 2 * kJMButtonPadding.width, titleSize.height + 2 * kJMButtonPadding.height);
}

#pragma Mark - 
#pragma Mark - Convenience Methods

- (CGPoint)touchPoint:(NSSet *)touches;
{
	UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.superview];
    return touchPoint;
}

#pragma Mark - 
#pragma Mark - Touch Response

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    [super touchesBegan:touches withEvent:event];
    [self.slider setHighlightSlider:YES];
    [self.slider updateWithSlideRatio:0.];
    touchStartPoint_ = [[touches anyObject] locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
    [super touchesMoved:touches withEvent:event];
    CGPoint touchPoint = [self touchPoint:touches];
    CGPoint centerPoint = CGPointMake(touchPoint.x - touchStartPoint_.x + (self.bounds.size.width / 2), self.center.y);
    [self.slider setButtonCenterPosition:centerPoint animated:NO];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self.slider releaseDragShouldCancel:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
{
    [super touchesEnded:touches withEvent:event];
    [self.slider releaseDragShouldCancel:NO];
}

#pragma Mark - 
#pragma Mark - Loading State

- (void)setLoading:(BOOL)loading;
{
    [self.activityView removeFromSuperview];
    self.activityView = nil;

    if (loading)
    {
        self.activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite] autorelease];
        self.activityView.autoresizesSubviews = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self.activityView startAnimating];
        [self addSubview:self.activityView];
        [self.activityView centerInSuperView];
    }
    [self setNeedsDisplay];
}

         
#pragma Mark - 
#pragma Mark - Factories

- (id)initForSlider:(JMSlider *)slider withTitle:(NSString *)title;
{
    self = [super initWithFrame:CGRectZero forSlider:slider];
    if (self)
    {
        [self setExclusiveTouch:YES];
        [self setTitle:title];
        [self sizeToFit];
        
        UITapGestureRecognizer * tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:slider action:@selector(tappedCenterView)] autorelease];
        tapGesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

+ (JMCenterView *)sliderButtonForSlider:(JMSlider *)slider withTitle:(NSString *)title;
{
    JMCenterView * centerView = [[[JMCenterView alloc] initForSlider:slider withTitle:title] autorelease];
    return centerView;
}

@end
