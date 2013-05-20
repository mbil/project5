//
//  SettingsViewController.m
//  BullsEye
//
//  Created by Myrthe Bil en Miguel Pruijssers on 18-04-13.
//  Copyright (c) 2013 App Studio. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SettingsViewController.h"
#import "BullsEyeAppDelegate.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    self.pickPlist.layer.shouldRasterize = YES;
    if (self.toggleSwitch.on == YES) {
        self.pickPlist.alpha = 0;
        self.pickPlist.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.pickPlist.alpha = 1;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.pickPlist.alpha = 0;
        } completion: ^(BOOL finished) {
            self.pickPlist.hidden = YES;
        }];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
