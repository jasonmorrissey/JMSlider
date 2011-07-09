//  Created by Jason Morrissey - jasonmorrissey.org

@interface DemoAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window_;
    UINavigationController *UINavigationController_;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

@end
