//
//  SettingsViewController.m
//  BullsEye
//
//  Created by Murph on 5/13/13.
//  Copyright (c) 2013 Hollance. All rights reserved.
//

#import "SettingsViewController.h"
#import "BullsEyeAppDelegate.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    BullsEyeAppDelegate *delegate = (BullsEyeAppDelegate *) [[UIApplication sharedApplication] delegate];
    self.toggleSwitch.on = delegate.loadPlist;
    self.segmentControl.selectedSegmentIndex = delegate.selectedRounds;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSegmentControl:nil];
    [super viewDidUnload];
}

- (IBAction)done {
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.loadPlist = self.toggleSwitch.on;
    appDelegate.selectedRounds = self.segmentControl.selectedSegmentIndex;
    [self.delegate settingsViewControllerDidFinish:self];
}

@end
