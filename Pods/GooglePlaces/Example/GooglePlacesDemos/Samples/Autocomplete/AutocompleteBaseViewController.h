#import "GooglePlacesDemos/Support/BaseDemoViewController.h"

#import <GooglePlaces/GooglePlaces.h>

/**
 * All other autocomplete demo classes inherit from this class. This class optionally adds a button
 * to present the autocomplete widget, and displays the results when these are selected.
 */
@interface AutocompleteBaseViewController : BaseDemoViewController

/**
 * Build a UIButton to display the autocomplete widget and add it to the UI. This should be called
 * only if the demo requires such a button, e.g. demos for modal presentation of widgets would use
 * this, while a UITextField demo would not.
 *
 * @param selector The selector to send to self when the button is tapped.
 *
 * @return The UIButton which was added to the UI.
 */
- (UIButton *)createShowAutocompleteButton:(SEL)selector;

/**
 * Add the result display view below the specified view. This should be called after the rest of the
 * UI has been configured.
 *
 * @param view The view to add the results below, this may be nil to indicate that the result view
 * should fill the parent.
 */
- (void)addResultViewBelow:(UIView *)view;

- (void)autocompleteDidSelectPlace:(GMSPlace *)place;
- (void)autocompleteDidFail:(NSError *)error;
- (void)autocompleteDidCancel;
- (void)showCustomMessageInResultPane:(NSString *)message;

@end
