//
//  BullsEyeViewController.m
//  BullsEye
//
//  Created by Myrthe Bil en Miguel Pruijssers on 18-04-13.
//  Copyright (c) 2013 App Studio. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BullsEyeViewController.h"
#import "BullsEyeAppDelegate.h"
#import "AboutViewController.h"
#import "HighScoreViewController.h"

@interface BullsEyeViewController ()

@end

@implementation BullsEyeViewController {
    int currentValue;
    int targetValue;
    int score;
    int round;
    int currentSelectedRounds;
}

@synthesize slider;
@synthesize targetLabel;
@synthesize scoreLabel;
@synthesize roundLabel;
@synthesize highscores;
@synthesize dataFromPlist;
@synthesize scoresPlist;

- (void)settingsViewControllerDidFinish:(SettingsViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    // set value of evil switch
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *) [[UIApplication sharedApplication] delegate];
    self.toggleSwitch.on = appDelegate.evilGamePlay;
}

- (void)updateLabels
{
    self.targetLabel.text = [NSString stringWithFormat:@"%d", targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d", round];
}

- (void)generateValue
{
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    // if user chose to use a plist, load the plist if not, generate random number
    if (appDelegate.loadPlist == YES) {
        
        // choose a random value by index from plist. Random value range is equal to length chosen plist
        int randomGeneratedNumber;
        if (appDelegate.selectedPlist == 0) {
            randomGeneratedNumber = arc4random()%10;
        }else{
            randomGeneratedNumber = arc4random()%20;
        }
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"values%d", appDelegate.selectedPlist] ofType:@"plist"];
        NSMutableArray *values = [NSMutableArray arrayWithContentsOfFile:path];
        targetValue = [[values objectAtIndex:(randomGeneratedNumber)]intValue];
    } else {
        targetValue = 1 + (arc4random() % 100);
    }
}

- (void)startNewRound
{
    round += 1;
    [self generateValue];
    
    // slider takes on random position
    currentValue = arc4random() % 100;
    self.slider.value = currentValue;
}

- (void)checkEndGame
{
    if (round == currentSelectedRounds) {
        [self updateLabels];
        [self startOver];
    } else {
        [self startNewRound];
        [self updateLabels];
    }
}

// update selected rounds label and value currentselectedrounds
- (void)numberOfRoundsHasChangedTo:(int)number{
    _selectedRoundsLabel.text = [NSString stringWithFormat:@"%d", number];
    currentSelectedRounds = number;
}

- (void)applySettings
{
    [self generateValue];
    [self updateLabels];
    
    // update label of loadPlist
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *) [[UIApplication sharedApplication] delegate];
    if (appDelegate.loadPlist) {
        self.loadPlistLabel.text = @"On";
    } else {
        self.loadPlistLabel.text = @"Off";
    }
    // update label of the current selected rounds
    Rounds *nl = [[Rounds alloc] init];
    nl.delegate = self;
    [nl getRounds];
}

- (void)startNewGame
{
    [self applySettings];
    score = 0;
    round = 0;
    [self startNewRound];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // update label of current selected rounds
    Rounds *rounds = [[Rounds alloc] init];
    rounds.delegate = self;
    [rounds getRounds];
    
    [self startNewGame];
    [self updateLabels];

    // initiate slider
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
 
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
 
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
 
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)showAlert
{
    // calculate difference
    int difference = abs(targetValue - currentValue);
    int points = 100 - difference;
 
    // message depending on difference
    NSString *title;
    if (difference == 0) {
        title = @"Perfect!";
        points += 100;
    } else if (difference < 5) {
        if (difference == 1) {
            points += 50;
        }
        title = @"You almost had it!";
    } else if (difference < 10) {
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

- (IBAction)sliderMoved:(UISlider *)sender
{
    currentValue = lroundf(sender.value);
}

- (IBAction)startOver
{
    Scores *nl = [[Scores alloc] init];
    nl.delegate = self;
    [nl saveHighscores];
    
//    // Load property list
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"highscorelist" ofType:@"plist"];
//    highscores = [NSMutableArray arrayWithContentsOfFile:path];
//    
//    // Array for the highscores
//    dataFromPlist = [highscores valueForKey:@"highscore"];
//    
//
//    if (currentSelectedRounds == 1) {
//        for (int i = 0; i < 5; i++) {
//            // Fill variable with a highscore
//
//            scoresPlist = [dataFromPlist objectAtIndex:i];
//            
//            // If the highscore already exists, break loop
//            if (score == [scoresPlist intValue]) {
//                break;
//            }
//            
//            // If the new score is higher than an old highscore, replace the lower one
//            else if (score > [scoresPlist intValue]) {
//                [self writeToDictionary:i];
//                [self alertMessage];
//                
//                break;
//            }
//        }
//    }
//
//    else if (currentSelectedRounds == 5) {
//        for (int i = 5; i < 10; i++) {
//
//            scoresPlist = [dataFromPlist objectAtIndex:i];
//            
//            if (score == [scoresPlist intValue]) {
//                break;
//            }
//            
//            else if (score > [scoresPlist intValue]) {
//                [self writeToDictionary:i];
//                [self alertMessage];
//                
//                break;
//            }
//        }
//    }
//    
//
//    else if (currentSelectedRounds == 10) {
//        for (int i = 10; i < 15; i++) {
//            scoresPlist = [dataFromPlist objectAtIndex:i];
//            
//            if (score == [scoresPlist intValue]) {
//                break;
//            }
//            
//            else if (score > [scoresPlist intValue]) {
//                [self writeToDictionary:i];
//                [self alertMessage];
//                
//                break;
//            }
//        }
//    }
//    
//    // Write to plist
//    [highscores writeToFile:path atomically:YES];
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self startNewGame];
    [self updateLabels];
    
    [self.view.layer addAnimation:transition forKey:nil];
}

//- (void)writeToDictionary:(NSInteger)i
//{
//    // Today's date
//    NSDate *currentDate = [NSDate date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
//    NSString *date = [dateFormatter stringFromDate:currentDate];
//    
//    // Fill variable with highscore
//    scoresPlist = [dataFromPlist objectAtIndex:i];
//    
//    // Copy dictionary
//    NSMutableDictionary *newestDictionary = [[highscores objectAtIndex:i] mutableCopy];
//    // Change highscore and date
//    [newestDictionary setObject:[NSNumber numberWithInteger:score] forKey:@"highscore"];
//    [newestDictionary setObject:[NSString stringWithFormat:@"%@", date] forKey:@"date"];
//    // Replace old dictionary
//    [highscores replaceObjectAtIndex:i withObject:newestDictionary];
//}

- (void)alertMessage
{
    NSString *alertMessage = nil;
    
    // Alert player with new highscore
    alertMessage = [NSString stringWithFormat:@"Je hebt een nieuwe highscore:\n %i", score];
    UIAlertView *highScoreAlert = [[UIAlertView alloc]initWithTitle:@"Congratz!" message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [highScoreAlert show];
}


// load about view

- (IBAction)showInfo
{
    AboutViewController *controller = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

// load highscore view
- (IBAction)showHighScores
{
    HighScoreViewController *controller = [[HighScoreViewController alloc] initWithNibName:@"HighScoreViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

// load settings view
- (IBAction)showSettings:(id)sender
{
    SettingsViewController *controller = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

// if Hit Me button clicked, check if the game has ended
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self checkEndGame];
}

- (void)viewDidUnload {
    [self setSelectedRoundsLabel:nil];
    [super viewDidUnload];
}

// toggle the evil view
- (IBAction)toggleEvil:(id)sender {
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.evilGamePlay = self.toggleSwitch.on;
    EvilBullsEyeViewController *evil = [[EvilBullsEyeViewController alloc] initWithNibName:nil bundle:nil];
    
    [evil setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentModalViewController:evil animated:YES];
}

@end
