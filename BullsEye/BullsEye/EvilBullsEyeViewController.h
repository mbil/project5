//
//  EvilBullsEyeViewController.h
//  BullsEye
//
//  Created by Myrthe Bil en Miguel Pruijssers on 18-04-13.
//  Copyright (c) 2013 App Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"

@interface EvilBullsEyeViewController : UIViewController <SettingsViewControllerDelegate>

@property(nonatomic,retain)IBOutlet UILabel *lblForRange;
@property (nonatomic, strong) IBOutlet UILabel *targetLabel1;
@property (strong, nonatomic) IBOutlet UILabel *targetLabel2;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *roundLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedRoundsLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedRoundsLabel2;
@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;

- (IBAction)showAlert;
- (IBAction)startOver;
- (IBAction)showInfo;
- (IBAction)showSettings:(id)sender;
- (IBAction)showHighScores;

@end
