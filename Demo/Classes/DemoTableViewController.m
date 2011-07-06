#import "DemoTableViewController.h"

@interface DemoTableViewController()
@property (nonatomic,retain) JMSlider * slider;
@end

@implementation DemoTableViewController

@synthesize slider = slider_;

- (void)dealloc
{
    self.slider = nil;
    [super dealloc];
}

- (void)loadView;
{
    [super loadView];
    [self.tableView setCanCancelContentTouches:NO];
}

- (UITableViewCell *)sliderCell;
{
    UITableViewCell * cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SliderCell"] autorelease];
    
    [cell setSelectionStyle:UITableViewCellEditingStyleNone];

    CGRect sliderFrame = CGRectMake(0., 0., 320., 90.);
    
    self.slider = [JMSlider sliderWithFrame:sliderFrame centerTitle:@"more" leftTitle:@"hide read" rightTitle:@"hide all" delegate:self];
    
    [cell addSubview:self.slider];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 90.;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) 
//    {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//    }
//    
    return [self sliderCell];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

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
