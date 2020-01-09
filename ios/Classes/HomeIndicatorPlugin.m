#import "HomeIndicatorPlugin.h"
#import "HomeIndicatorAwareFlutterViewController.h"
#include <objc/runtime.h>

@implementation HomeIndicatorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"home_indicator"
                                  binaryMessenger:[registrar messenger]];
  
  HomeIndicatorPlugin *instance = [[HomeIndicatorPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
  [registrar addApplicationDelegate:instance];
}

-(HomeIndicatorAwareFlutterViewController *) controller {
    UIWindow *window = [[[UIApplication sharedApplication]delegate] window];
    UIViewController *rootController = window.rootViewController;
    
    if ([rootController isKindOfClass: [HomeIndicatorAwareFlutterViewController class]]) {
        return (HomeIndicatorAwareFlutterViewController*)rootController;
    }
    
    UIViewController *fvc = (UIViewController*) rootController;
    
    object_setClass(fvc, [HomeIndicatorAwareFlutterViewController class]);
    HomeIndicatorAwareFlutterViewController *newController = (HomeIndicatorAwareFlutterViewController*)fvc;
    window.rootViewController = newController;
    
    return newController;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  if ([@"hide" isEqualToString:call.method]) {
    //[self authenticateWithBiometrics:call.arguments withFlutterResult:result];
    HomeIndicatorAwareFlutterViewController *controller = [self controller];
    controller.hidingHomeIndicator = YES;
    [controller update];
    result(NULL);
  } else if ([@"show" isEqualToString:call.method]) {
    //[self getAvailableBiometrics:result];
    HomeIndicatorAwareFlutterViewController *controller = [self controller];
    controller.hidingHomeIndicator = NO;
    [controller update];
    result(NULL);
  } else {
    result(FlutterMethodNotImplemented);
  }
}
@end
