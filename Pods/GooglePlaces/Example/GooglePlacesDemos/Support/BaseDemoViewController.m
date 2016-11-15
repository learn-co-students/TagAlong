#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "GooglePlacesDemos/Support/BaseDemoViewController.h"

@implementation BaseDemoViewController

+ (NSString *)demoTitle {
  // This should be overridden by subclasses, so should not be called.
  return nil;
}

- (instancetype)initWithNibName:(NSString *)name bundle:(NSBundle *)bundle {
  if ((self = [super initWithNibName:name bundle:bundle])) {
    self.title = [[self class] demoTitle];
  }
  return self;
}

@end
