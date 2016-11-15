#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "AutocompletePushViewController.h"

#import <GooglePlaces/GooglePlaces.h>

@interface AutocompletePushViewController ()<GMSAutocompleteViewControllerDelegate>
@property(nonatomic, strong) GMSAutocompleteViewController *autocompleteViewController;
@end

@implementation AutocompletePushViewController

+ (NSString *)demoTitle {
  return NSLocalizedString(
      @"Demo.Title.Autocomplete.Push",
      @"Title of the pushed autocomplete demo for display in a list or nav header");
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];

  // Configure the UI. Tell our superclass we want a button and a result view below that.
  UIButton *button =
      [self createShowAutocompleteButton:@selector(showAutocompleteWidgetButtonTapped)];
  [self addResultViewBelow:button];
}

#pragma mark - Getters/Setters

- (GMSAutocompleteViewController *)autocompleteViewController {
  if (_autocompleteViewController == nil) {
    _autocompleteViewController = [[GMSAutocompleteViewController alloc] init];
    _autocompleteViewController.delegate = self;
  }
  return _autocompleteViewController;
}

#pragma mark - Actions

- (IBAction)showAutocompleteWidgetButtonTapped {
  // When the button is tapped just push the autocomplete view controller onto the stack.
  [self.navigationController pushViewController:self.autocompleteViewController animated:YES];
}

#pragma mark - GMSAutocompleteViewControllerDelegate

- (void)viewController:(GMSAutocompleteViewController *)viewController
    didAutocompleteWithPlace:(GMSPlace *)place {
  // Dismiss the view controller and tell our superclass to populate the result view.
  [self.navigationController popToViewController:self animated:YES];
  [self autocompleteDidSelectPlace:place];
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
    didFailAutocompleteWithError:(NSError *)error {
  // Dismiss the view controller and notify our superclass of the failure.
  [self.navigationController popToViewController:self animated:YES];
  [self autocompleteDidFail:error];
}

- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
  // Dismiss the controller and show a message that it was canceled.
  [self.navigationController popToViewController:self animated:YES];
  [self autocompleteDidCancel];
}

@end
