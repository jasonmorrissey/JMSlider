//  Created by Jason Morrissey - jasonmorrissey.org

#import <UIKit/UIKit.h>
#import "JMSliderConstants.h"

@class JMSlider;
@class JMCenterView;
@class JMSideView;
@class JMSliderTrack;

typedef enum JMSliderSelection {
    JMSliderSelectionLeft,
    JMSliderSelectionCenter,
    JMSliderSelectionRight
} JMSliderSelection;

#if NS_BLOCKS_AVAILABLE
typedef void(^JMSliderExecutionBlock)(void);
#endif

#pragma Mark -
#pragma Mark - JMSliderDelegate

@protocol JMSliderDelegate <NSObject>
@optional
-(void)slider:(JMSlider *)slider didSelect:(JMSliderSelection)selection;
-(JMCenterView *)sliderCenterViewForSlider:(JMSlider *)slider;
-(JMSideView *)sliderLeftViewForSlider:(JMSlider *)slider;
-(JMSideView *)sliderRightViewForSlider:(JMSlider *)slider;
-(JMSliderTrack *)sliderTrackViewForSlider:(JMSlider *)slider;

@end

#pragma Mark -
#pragma Mark - JMSlider

@interface JMSlider : UIView

#if NS_BLOCKS_AVAILABLE
@property (nonatomic,copy) JMSliderExecutionBlock leftExecuteBlock;
@property (nonatomic,copy) JMSliderExecutionBlock centerExecuteBlock;
@property (nonatomic,copy) JMSliderExecutionBlock rightExecuteBlock;
#endif

#pragma Mark - Internal

// Accessors for subviews
- (CGFloat)trackLowCenter;
- (CGFloat)trackHighCenter;
- (CGFloat)centerViewWidth;
- (CGFloat)slideRatio;

// Method calls from subviews
- (void)updateWithSlideRatio:(CGFloat)slideRatio;
- (void)setButtonCenterPosition:(CGPoint)centerPoint animated:(BOOL)animated;
- (void)setHighlightSlider:(BOOL)highlighted;
- (void)releaseDragShouldCancel:(BOOL)cancelled;
- (void)tappedCenterView;

#pragma Mark - External API

+ (JMSlider *) sliderWithFrame:(CGRect)frame centerTitle:(NSString *)centerTitle leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle delegate:(id<JMSliderDelegate>)delegate;
+ (JMSlider *) sliderWithFrame:(CGRect)frame delegate:(id<JMSliderDelegate>)delegate;

- (void)setLoading:(BOOL)loading;

@end

