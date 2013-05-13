//
//  SettingsViewController.h
//  BullsEye
//
//  Created by Myrthe Bil en Miguel Pruijssers on 01-06-12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsViewController;

@protocol SettingsViewControllerDelegate

- (void)settingsViewControllerDidFinish:(SettingsViewController *)controller;

@end

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) id <SettingsViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

- (IBAction)done;

@end
