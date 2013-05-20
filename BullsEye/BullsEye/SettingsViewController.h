//
//  SettingsViewController.h
//  BullsEye
//
//  Created by Myrthe Bil en Miguel Pruijssers on 18-04-13.
//  Copyright (c) 2013 App Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsViewController;

@protocol SettingsViewControllerDelegate

- (void)settingsViewControllerDidFinish:(SettingsViewController *)controller;

@end

@interface SettingsViewController : UIViewController

@property (nonatomic, strong) id <SettingsViewControllerDelegate> delegate;
@property (nonatomic, weak) IBOutlet UISwitch *toggleSwitch;
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentControl;
@property (nonatomic, weak) IBOutlet UISegmentedControl *pickPlist;

- (IBAction)done;
- (IBAction)togglePlist;

@end
