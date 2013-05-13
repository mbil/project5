//
//  BullsEyeViewController.h
//  BullsEye
//
//  Created by Matthijs Hollemans on 01-06-12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvilBullsEyeViewController.h"
#import "SettingsViewController.h"

@interface BullsEyeViewController : UIViewController <SettingsViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UISlider *slider;
@property (nonatomic, strong) IBOutlet UILabel *targetLabel;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *roundLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedRoundsLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedRoundsLabel2;

- (IBAction)showAlert;
- (IBAction)sliderMoved:(UISlider *)sender;
- (IBAction)startOver;
- (IBAction)showInfo;
- (IBAction)showSettings:(id)sender;


@end
