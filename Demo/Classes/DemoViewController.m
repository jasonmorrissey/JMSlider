//  Created by Jason Morrissey - jasonmorrissey.org

#import "DemoViewController.h"
#import "UIView+JMNoise.h"
#import "UIView+Positioning.h"

@interface DemoViewController()
@end

@implementation DemoViewController

-(void)loadView;
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self.view applyNoise];
    
    CGRect sliderFrame = CGRectMake(0., 0., 320., 90.);
    
    JMSlider * slider = [JMSlider sliderWithFrame:sliderFrame centerTitle:@"more" leftTitle:@"hide read" rightTitle:@"hide all" delegate:self];
    
    slider.centerExecuteBlock = ^{ NSLog(@"executing block: center"); };
    slider.leftExecuteBlock = ^{ NSLog(@"executing block: left"); };
    slider.rightExecuteBlock = ^{ NSLog(@"executing block: right"); };

    [self.view addSubview:slider];

    [slider centerInSuperView];
}


#pragma Mark -
#pragma Mark - JMSliderDelegate Methods

-(void)slider:(JMSlider *)slider didSelect:(JMSliderSelection)selection;
{
    switch (selection) 
    {
        case JMSliderSelectionLeft:
            NSLog(@"invoked: left");
            break;

        case JMSliderSelectionCenter:
            NSLog(@"invoked: center");
            break;

        case JMSliderSelectionRight:
            NSLog(@"invoked: right");
            break;
            
        default:
            break;
    }
}

@end
