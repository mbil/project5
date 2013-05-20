//
//  EvilBullsEyeViewController.m
//  BullsEye
//
//  Created by Myrthe Bil en Miguel Pruijssers on 18-04-13.
//  Copyright (c) 2013 App Studio. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "EvilBullsEyeViewController.h"
#import "SliderDemo.h"
#import "BullsEyeAppDelegate.h"
#import "AboutViewController.h"
#import "HighScoreViewController.h"

@interface EvilBullsEyeViewController ()

@end

@implementation EvilBullsEyeViewController {
    int currentValue1;
    int currentValue2;
    int targetValue1;
    int targetValue2;
    int score;
    int round;
    int selectedRounds;
}

@synthesize lblForRange = _lblForRange;
@synthesize targetLabel1;
@synthesize targetLabel2;
@synthesize scoreLabel;
@synthesize roundLabel;
@synthesize highscores;
@synthesize dataFromPlist;
@synthesize scoresPlist;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startNewGame];
    [self updateLabels];
    currentValue1 = 20;
    currentValue2 = 80;
	// Do any additional setup after loading the view, typically from a nib.
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *) [[UIApplication sharedApplication] delegate];
    self.toggleSwitch.on = appDelegate.evilGamePlay;
    [self loadSlider];
}

- (void)settingsViewControllerDidFinish:(SettingsViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateRangeLabel:(SliderDemo *)slider{
    currentValue1 = (int) slider.selectedMinimumValue;
    currentValue2 = (int) slider.selectedMaximumValue;
}

- (void)applySettings
{
    [self generateValue];
    [self updateLabels];
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *) [[UIApplication sharedApplication] delegate];
    if (appDelegate.loadPlist) {
        self.selectedRoundsLabel.text = @"On";
    } else {
        self.selectedRoundsLabel.text = @"Off";
    }
    if (appDelegate.selectedRounds == 0) {
        selectedRounds = 1;
        self.selectedRoundsLabel2.text = [NSString stringWithFormat:@"%d", selectedRounds];
    }else if (appDelegate.selectedRounds == 1) {
        selectedRounds = 5;
        self.selectedRoundsLabel2.text = [NSString stringWithFormat:@"%d", selectedRounds];
        
    }else if (appDelegate.selectedRounds == 2) {
        selectedRounds = 10;
        self.selectedRoundsLabel2.text = [NSString stringWithFormat:@"%d", selectedRounds];
    }else {
        self.selectedRoundsLabel2.text = @"1";
    }
}

- (void)updateLabels
{
    self.targetLabel1.text = [NSString stringWithFormat:@"%d", targetValue1];
    self.targetLabel2.text = [NSString stringWithFormat:@"%d", targetValue2];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d", round];
}

- (void)generateValue
{
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *) [[UIApplication sharedApplication] delegate];
    if (appDelegate.loadPlist == YES) {
        int randomGeneratedNumber1 = (arc4random()%10);
        int randomGeneratedNumber2;
        if (appDelegate.selectedPlist == 0) {
            randomGeneratedNumber2 = (arc4random()%10);
        }else{
            randomGeneratedNumber2 = 10 +(arc4random()%10);
        }
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"values%d", appDelegate.selectedPlist] ofType:@"plist"];
        NSMutableArray *values = [NSMutableArray arrayWithContentsOfFile:path];
        int temptargetValue1 = ([[values objectAtIndex:(randomGeneratedNumber1)]intValue] % 50);
        if (temptargetValue1 == 0) {
            targetValue1 = 10;
        } else {
            targetValue1 = temptargetValue1;
        }
        targetValue2 = [[values objectAtIndex:(randomGeneratedNumber2)]intValue];
    } else {
        targetValue1 = 1 + (arc4random() % 50);
        targetValue2 = 51 + (arc4random() % 50);
    }
}

- (void)loadSlider
{
    UIView *VctrDtl=[[UIView alloc]initWithFrame:CGRectMake(50,110,380, 15)];
    SliderDemo *sliderVctr=[[SliderDemo alloc] initWithFrame:CGRectMake(VctrDtl.bounds.origin.x,VctrDtl.bounds.origin.y,VctrDtl.bounds.size.width, VctrDtl.bounds.size.height)];
    sliderVctr.minimumValue =0;
    sliderVctr.selectedMinimumValue = 20;
    sliderVctr.maximumValue = 100;
    sliderVctr.selectedMaximumValue = 80;
    sliderVctr.minimumRange = 10;
    [sliderVctr addTarget:self action:@selector(updateRangeLabel:) forControlEvents:UIControlEventValueChanged];
    [VctrDtl addSubview:sliderVctr];
    [self.view addSubview:VctrDtl];
}

- (void)startNewRound
{
    
    round += 1;
    [self generateValue];

}

- (void)checkEndGame
{
    if (round == selectedRounds) {
        [self updateLabels];
        [self startOver];
    } else {
        [self startNewRound];
        [self updateLabels];
    }
}

- (void)startNewGame
{
    [self applySettings];
    score = 0;
    round = 0;
    [self startNewRound];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    
}

- (IBAction)showAlert
{
    int difference1 = abs(targetValue1 - currentValue1);
    int difference2 = abs(targetValue2 - currentValue2);
    
    int totaldifference = difference1 + difference2;
    int points = 100 - totaldifference;
    
    NSString *title;
    if (totaldifference == 0) {
        title = @"Perfect!";
        points += 100;
    } else if (totaldifference < 10) {
        if (totaldifference == 2) {
            points += 50;
        }
        title = @"You almost had it!";
    } else if (totaldifference < 20) {
        title = @"Pretty good!";
    } else {
        title = @"Not even close...";
    }
    
    score += points;
    
    NSString *message = [NSString stringWithFormat:@"You scored %d points", points];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    
    [self updateLabels];
    [alertView show];
}


- (IBAction)startOver
{
    
    // Load property list
    NSString *path = [[NSBundle mainBundle] pathForResource:@"evilhighscorelist" ofType:@"plist"];
    highscores = [NSMutableArray arrayWithContentsOfFile:path];
    
    // Array for the highscores
    dataFromPlist = [highscores valueForKey:@"highscore"];
    
    if (round == 1) {
        for (int i = 0; i < 5; i++) {
            // Fill variable with a highscore
            scoresPlist = [dataFromPlist objectAtIndex:i];
            
            // If the highscore already exists, break loop
            if (score == [scoresPlist intValue]) {
                break;
            }
            
            // If the new score is higher than an old highscore, replace the lower one
            else if (score > [scoresPlist intValue]) {
                [self writeToDictionary:i];
                [self alertMessage];
                
                break;
            }
        }
    }
    
    else if (round == 5) {
        for (int i = 5; i < 10; i++) {
            scoresPlist = [dataFromPlist objectAtIndex:i];
            
            if (score == [scoresPlist intValue]) {
                break;
            }
            
            else if (score > [scoresPlist intValue]) {
                [self writeToDictionary:i];
                [self alertMessage];
                
                break;
            }
        }
    }
    
    else if (round == 10) {
        for (int i = 10; i < 15; i++) {
            scoresPlist = [dataFromPlist objectAtIndex:i];
            
            if (score == [scoresPlist intValue]) {
                break;
            }
            
            else if (score > [scoresPlist intValue]) {
                [self writeToDictionary:i];
                [self alertMessage];
                
                break;
            }
        }
    }
    
    // Write to plist
    [highscores writeToFile:path atomically:YES];
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self startNewGame];
    [self updateLabels];
    
    [self.view.layer addAnimation:transition forKey:nil];
}

- (void)writeToDictionary:(NSInteger)i
{
    // Today's date
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *date = [dateFormatter stringFromDate:currentDate];
    
    // Fill variable with highscore
    scoresPlist = [dataFromPlist objectAtIndex:i];
    
    // Copy dictionary
    NSMutableDictionary *newestDictionary = [[highscores objectAtIndex:i] mutableCopy];
    // Change highscore and date
    [newestDictionary setObject:[NSNumber numberWithInteger:score] forKey:@"highscore"];
    [newestDictionary setObject:[NSString stringWithFormat:@"%@", date] forKey:@"date"];
    // Replace old dictionary
    [highscores replaceObjectAtIndex:i withObject:newestDictionary];
}

- (void)alertMessage
{
    NSString *alertMessage = nil;
    
    // Alert player with new highscore
    alertMessage = [NSString stringWithFormat:@"Je hebt een nieuwe highscore:\n %i", score];
    UIAlertView *highScoreAlert = [[UIAlertView alloc]initWithTitle:@"Congratz!" message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [highScoreAlert show];
}

- (IBAction)showInfo
{
    AboutViewController *controller = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self checkEndGame];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)toggleEvilOff:(id)sender {
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.evilGamePlay = self.toggleSwitch.on;
   [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showSettings:(id)sender
{
    SettingsViewController *controller = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)showHighScores
{
    HighScoreViewController *controller = [[HighScoreViewController alloc] initWithNibName:@"HighScoreViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}


@end
