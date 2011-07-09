//  Created by Jason Morrissey - jasonmorrissey.org

#import <UIKit/UIKit.h>

@interface CenteredTableViewController : UITableViewController

- (id)initWithCenteredView:(UIView *)centeredView;
+ (UITableView *) tableViewWithCenteredView:(UIView *)centeredView;

@end
