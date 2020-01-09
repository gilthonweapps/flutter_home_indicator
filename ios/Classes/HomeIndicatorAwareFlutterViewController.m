#import "HomeIndicatorAwareFlutterViewController.h"

@interface HomeIndicatorAwareFlutterViewController ()

@end

@implementation HomeIndicatorAwareFlutterViewController

- (BOOL)prefersHomeIndicatorAutoHidden {
    return _hidingHomeIndicator;
}

- (void) update {
    if (@available(iOS 11, *)) {
        [self setNeedsUpdateOfHomeIndicatorAutoHidden];
    }
}

@end
