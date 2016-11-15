#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "GooglePlacesDemos/Samples/Autocomplete/AutocompleteWithSearchDisplayController.h"

#import <GooglePlaces/GooglePlaces.h>

/* The default height of a UISearchBar. */
static CGFloat kSearchBarHeight = 44.0f;

@interface AutocompleteWithSearchDisplayController ()<GMSAutocompleteTableDataSourceDelegate,
                                                      UISearchDisplayDelegate>
@end

@implementation AutocompleteWithSearchDisplayController {
  UISearchDisplayController *_searchDisplayController;
  GMSAutocompleteTableDataSource *_tableDataSource;
}

+ (NSString *)demoTitle {
  return NSLocalizedString(@"Demo.Title.Autocomplete.UISearchDisplayController",
                           @"Title of the UISearchDisplayController autocomplete demo for display "
                           @"in a list or nav header");
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];

  // Don't overlay the status bar with the search bar when active.
  self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight;

  // Create and setup the search bar.
  UISearchBar *searchBar = [[UISearchBar alloc]
      initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kSearchBarHeight)];
  searchBar.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;

  // Construct the autocomplete table datasource.
  _tableDataSource = [[GMSAutocompleteTableDataSource alloc] init];
  _tableDataSource.delegate = self;

  // Configure a UISearchDisplayController.
  _searchDisplayController =
      [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
  _searchDisplayController.searchResultsDataSource = _tableDataSource;
  _searchDisplayController.searchResultsDelegate = _tableDataSource;
  _searchDisplayController.delegate = self;
  _searchDisplayController.displaysSearchBarInNavigationBar = NO;

  // Add the search bar and tell our superclass to add the result panel below it.
  [self.view addSubview:searchBar];
  [self addResultViewBelow:searchBar];
}

#pragma mark - UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
    shouldReloadTableForSearchString:(NSString *)searchString {
  // Notify the autocomplete table data source of the change in text.
  [_tableDataSource sourceTextHasChanged:searchString];
  return NO;
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller {
  [_tableDataSource sourceTextHasChanged:@""];
}

#pragma mark - GMSAutocompleteTableDataSourceDelegate

- (void)tableDataSource:(GMSAutocompleteTableDataSource *)tableDataSource
    didAutocompleteWithPlace:(GMSPlace *)place {
  // Tell our superclass to show the results, and dismiss the search controller.
  [self autocompleteDidSelectPlace:place];
  [_searchDisplayController setActive:NO animated:YES];
}

- (void)tableDataSource:(GMSAutocompleteTableDataSource *)tableDataSource
    didFailAutocompleteWithError:(NSError *)error {
  // Tell our superclass to show the error, and dismiss the search controller.
  [self autocompleteDidFail:error];
  [_searchDisplayController setActive:NO animated:YES];
}

- (void)didRequestAutocompletePredictionsForTableDataSource:
    (GMSAutocompleteTableDataSource *)tableDataSource {
  // Start the network activity indicator and reload the table of results.
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
  [_searchDisplayController.searchResultsTableView reloadData];
}

- (void)didUpdateAutocompletePredictionsForTableDataSource:
    (GMSAutocompleteTableDataSource *)tableDataSource {
  // Stop the network activity indicator and reload the table of results.
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  [_searchDisplayController.searchResultsTableView reloadData];
}

@end
