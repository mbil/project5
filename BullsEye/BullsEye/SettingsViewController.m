//
//  SettingsViewController.m
//  BullsEye
//
//  Created by Myrthe Bil en Miguel Pruijssers on 01-06-12.
//  Copyright (c) 2012 Hollance. All rights reserved.
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
    if (delegate.loadPlist == NO) {
        [self.pickPlist setHidden:YES];
    }else {
        [self.pickPlist setHidden:NO];
    }
    self.pickPlist.selectedSegmentIndex = delegate.selectedPlist;
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
    appDelegate.selectedPlist = self.pickPlist.selectedSegmentIndex;
    [self.delegate settingsViewControllerDidFinish:self];
}

- (IBAction)togglePlist {
    if (self.toggleSwitch.on == YES) {
        [self.pickPlist setHidden:NO];
    } else {
        [self.pickPlist setHidden:YES];
    }
}

@end
