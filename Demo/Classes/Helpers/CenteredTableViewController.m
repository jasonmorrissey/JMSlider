//  Created by Jason Morrissey - jasonmorrissey.org

#import "CenteredTableViewController.h"
#import "UIView+Positioning.h"
#import "UIView+JMNoise.h"

@interface CenteredTableViewController()
@property (nonatomic,retain) UIView * viewForDemo;
@end

@implementation CenteredTableViewController

@synthesize viewForDemo = viewForDemo_;

- (void)dealloc;
{
    self.viewForDemo = nil;
    [super dealloc];
}

- (void)loadView;
{
    [super loadView];
    
    UIView * tableBackgroundView = [[[UIView alloc] initWithFrame:self.tableView.bounds] autorelease];
    [tableBackgroundView applyNoiseWithOpacity:0.2];
    self.tableView.backgroundView = tableBackgroundView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView * tableHeader = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height / 2 - (self.viewForDemo.frame.size.height / 2))] autorelease];
    tableHeader.backgroundColor = [UIColor clearColor];
    [self.tableView setTableHeaderView:tableHeader];
}

- (UITableViewCell *)demoCell;
{
    UITableViewCell * cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DemoCell"] autorelease];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UIView * viewForDemo = [self viewForDemo];
    viewForDemo.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;    
    [cell addSubview:viewForDemo];
    [viewForDemo centerInSuperView];
    
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
    return self.viewForDemo.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self demoCell];
}

- (id)initWithCenteredView:(UIView *)centeredView;
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
        self.viewForDemo = centeredView;
    }
    return self;
}

+ (UITableView *) tableViewWithCenteredView:(UIView *)centeredView;
{
    CenteredTableViewController * viewController = [[[CenteredTableViewController alloc] initWithCenteredView:centeredView] autorelease];
    return viewController.tableView;
}

@end
