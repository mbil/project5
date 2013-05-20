//
//  Rounds.m
//  BullsEye
//
//  Created by Murph on 5/14/13.
//  Copyright (c) 2013 Hollance. All rights reserved.
//

#import "Rounds.h"
#import "BullsEyeAppDelegate.h"

@implementation Rounds

@synthesize delegate;

// set values selectedrounds
- (void)getRounds {
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.selectedRounds == 0) {
        selectedRounds = 1;
    }else if (appDelegate.selectedRounds == 1) {
        selectedRounds = 5;
    }else if (appDelegate.selectedRounds == 2) {
        selectedRounds = 10;
    }
    // delegate selectedRounds to update labels
    [self.delegate numberOfRoundsHasChangedTo:selectedRounds];
}
@end
