#import <UIKit/UIKit.h>

/**
 * Base view controller for all demos in the Places Demo app. Provides some basic functionality
 * which is common across demos.
 */
@interface BaseDemoViewController : UIViewController

/**
 * The title of the demo. Displayed in lists and navigation bars.
 *
 * NOTE: This must be overridden by subclasses.
 */
+ (NSString *)demoTitle;

@end
