//
//  BullsEyeAppDelegate.h
//  BullsEye
//
//  Created by Myrthe Bil en Miguel Pruijssers on 01-06-12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BullsEyeViewController;

@interface BullsEyeAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BullsEyeViewController *viewController;
@property (nonatomic) BOOL loadPlist;
@property (nonatomic) BOOL evilGamePlay;
@property (nonatomic) NSUInteger selectedRounds;

@end
