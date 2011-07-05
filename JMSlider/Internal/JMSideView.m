//  Created by Jason Morrissey - jasonmorrissey.org

#import "JMSideView.h"
#import "JMSlider.h"

@implementation JMSideView

@synthesize active = active_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size;
{
    return [self.title sizeWithFont:kJMSideTitleFont];
}

- (CGPoint)itemOffset;
{
    return CGPointMake(0., 10.);
}

- (void)drawRect:(CGRect)rect;
{
    [kJMSideTitleColor set];
    [self.title drawInRect:rect withFont:kJMSideTitleFont lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];
}

+ (JMSideView *)sideViewWithTitle:(NSString *)title;
{
    JMSideView * sideView = [[[[self class] alloc] init] autorelease];
    sideView.title = title;
    [sideView sizeToFit];
    return sideView;
}

@end
