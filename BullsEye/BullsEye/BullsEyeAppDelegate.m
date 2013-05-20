//
//  BullsEyeAppDelegate.m
//  BullsEye
//
//  Created by Myrthe Bil en Miguel Pruijssers on 18-04-13.
//  Copyright (c) 2013 App Studio. All rights reserved.
//

#import "BullsEyeAppDelegate.h"

#import "BullsEyeViewController.h"

@implementation BullsEyeAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.loadPlist = NO;
    self.evilGamePlay = NO;
    self.score = 0;
    self.selectedRounds = 0;
	self.viewController = [[BullsEyeViewController alloc] initWithNibName:@"BullsEyeViewController" bundle:nil];
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
