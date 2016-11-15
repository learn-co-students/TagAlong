#import <UIKit/UIKit.h>

/**
 * A class which manages the behavior of a |UISplitViewController| to achieve the UX we want for
 * this demo app. Specifically it tells the |UISplitViewController| to display the list of demos on
 * first launch if there is not enough space to have two panes, instead of just the first demo in
 * the list. After first launch if the device transitions from regular to compact it will instead
 * show the demo which is currently open.
 */
@interface MainSplitViewControllerBehaviorManager : NSObject<UISplitViewControllerDelegate>

@end
