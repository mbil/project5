//
//  BullsEyeViewController.h
//  BullsEye
//
//  Created by Myrthe Bil en Miguel Pruijssers on 01-06-12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvilBullsEyeViewController.h"
#import "SettingsViewController.h"
#import "Rounds.h"

@interface BullsEyeViewController : UIViewController <SettingsViewControllerDelegate, RoundsDelegate>;

@property (weak, nonatomic) IBOutlet UILabel *loadPlistLabel;
@property (nonatomic, strong) IBOutlet UISlider *slider;
@property (nonatomic, strong) IBOutlet UILabel *targetLabel;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *roundLabel;

@property (weak, nonatomic) IBOutlet UILabel *selectedRoundsLabel;
@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;

- (IBAction)showAlert;
- (IBAction)sliderMoved:(UISlider *)sender;
- (IBAction)startOver;
- (IBAction)showInfo;
- (IBAction)showSettings:(id)sender;
- (IBAction)showHighScores;

@end
