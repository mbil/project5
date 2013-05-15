//
//  BullsEyeAppDelegate.h
//  BullsEye
//
//  Created by Myrthe Bil en Miguel Pruijssers on 18-04-13.
//  Copyright (c) 2013 App Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BullsEyeViewController;

@interface BullsEyeAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BullsEyeViewController *viewController;
@property (nonatomic) BOOL loadPlist;
@property (nonatomic) BOOL evilGamePlay;
@property (nonatomic) NSUInteger selectedRounds;
@property (nonatomic) NSUInteger selectedPlist;

@end
