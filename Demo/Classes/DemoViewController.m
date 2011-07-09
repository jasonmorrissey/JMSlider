//  Created by Jason Morrissey - jasonmorrissey.org

#import "DemoViewController.h"
#import "CenteredTableViewController.h"

@interface DemoViewController()
@property (nonatomic,retain) JMSlider * slider;
@end

@implementation DemoViewController

@synthesize slider = slider_;

- (void)dealloc;
{
    self.slider = nil;
    [super dealloc];
}

- (void)loadView;
{
    CGRect sliderFrame = CGRectMake(0., 0., 320., 90.);
    self.slider = [JMSlider sliderWithFrame:sliderFrame centerTitle:@"more" leftTitle:@"hide read" rightTitle:@"hide all" delegate:self];
    
    UITableView * tableView = [CenteredTableViewController tableViewWithCenteredView:self.slider];
    
    // Important: When including the slider in tableViews or scrollViews, I highly recommend 
    // that you set canCancelContentTouches to NO so that the table/scrollView doesn't scroll
    // while the user is toggling the slider.
    [tableView setCanCancelContentTouches:NO];

    self.view = tableView;
}

- (void) stopSimulatedLoading;
{
    [self.slider setLoading:NO];
}


#pragma Mark -
#pragma Mark - JMSliderDelegate Methods

-(void)slider:(JMSlider *)slider didSelect:(JMSliderSelection)selection;
{
    [slider setLoading:YES];
    
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
    
    [self performSelector:@selector(stopSimulatedLoading) withObject:nil afterDelay:2.];
}

@end
