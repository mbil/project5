//
//  BullsEyeViewController.h
//  BullsEye
//
//  Created by Myrthe Bil en Miguel Pruijssers on 18-04-13.
//  Copyright (c) 2013 App Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvilBullsEyeViewController.h"
#import "SettingsViewController.h"

@interface BullsEyeViewController : UIViewController <SettingsViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UISlider *slider;
@property (nonatomic, strong) IBOutlet UILabel *targetLabel;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *roundLabel;
@property (nonatomic, weak) IBOutlet UILabel *selectedRoundsLabel;
@property (nonatomic, weak) IBOutlet UILabel *selectedRoundsLabel2;
@property (nonatomic, weak) IBOutlet UISwitch *toggleSwitch;
@property (nonatomic, strong) NSMutableArray *highscores;
@property (nonatomic, strong) NSArray *dataFromPlist;
@property (nonatomic, strong) NSNumber *scoresPlist;

- (IBAction)showAlert;
- (IBAction)sliderMoved:(UISlider *)sender;
- (IBAction)startOver;
- (IBAction)showInfo;
- (IBAction)showSettings:(id)sender;
- (IBAction)showHighScores;

@end
