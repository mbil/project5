//
//  EvilBullsEyeViewController.m
//  BullsEye
//
//  Created by Myrthe Bil en Miguel Pruijssers on 01-06-12.
//  Copyright (c) 2012 Hollance. All rights reserved.
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

- (void)viewWillAppear:(BOOL)animated { [super viewWillAppear:animated];
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *) [[UIApplication sharedApplication] delegate];
    if (appDelegate.loadPlist) {
        self.selectedRoundsLabel.text = @"ja";
    } else {
        self.selectedRoundsLabel.text = @"nee";
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
    [super viewWillAppear:animated];
}

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
    UIView *VctrDtl=[[UIView alloc]initWithFrame:CGRectMake(80,110,300, 15)];
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

- (void)settingsViewControllerDidFinish:(SettingsViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateRangeLabel:(SliderDemo *)slider{
    currentValue1 = (int) slider.selectedMinimumValue;
    currentValue2 = (int) slider.selectedMaximumValue;
}


- (void)updateLabels
{
    self.targetLabel1.text = [NSString stringWithFormat:@"%d", targetValue1];
    self.targetLabel2.text = [NSString stringWithFormat:@"%d", targetValue2];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d", round];
}


- (void)startNewRound
{
    
    round += 1;
    
    targetValue1 = 1 + (arc4random() % 50);
    targetValue2 = 51 + (arc4random() % 50);

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
    // Datum van vandaag
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *date = [dateFormatter stringFromDate:currentDate];
    
    // Load de property list
    NSString *path = [[NSBundle mainBundle] pathForResource:@"evilhighscorelist" ofType:@"plist"];
    NSMutableArray *highscores = [NSMutableArray arrayWithContentsOfFile:path];
    
    // Array voor de highscores
    NSArray *dataFromPlist = [highscores valueForKey:@"highscore"];
    
    // Maak variabel aan voor de highscores uit de plist
    NSNumber *scoresPlist;
    
    
    // Maak variabel voor alertmessage
    NSString *alertMessage = nil;
    
    // Als ronde 1 is voltooid
    if (selectedRounds == 1)
    {
        // Loop door de eerste 5 highscores van de bijbehorende ronde
        for (int i = 0; i < 5; i++)
        {
            // Vul variabel met highscores
            scoresPlist = [dataFromPlist objectAtIndex:i];
            
            // Als highscore al bestaat, break for loop
            if (score == [scoresPlist intValue]) {
                break;
            }
            
            // Als de behaalde score groter is, vervang de score
            else if (score > [scoresPlist intValue])
            {
                // Kopieer dictionary
                NSMutableDictionary *firstDictionary = [[highscores objectAtIndex:i] mutableCopy];
                // Wijzig highscore en datum
                [firstDictionary setObject:[NSNumber numberWithInteger:score] forKey:@"highscore"];
                [firstDictionary setObject:[NSString stringWithFormat:@"%@", date] forKey:@"date"];
                // Vervang oude dictionary voor nieuwe
                [highscores replaceObjectAtIndex:i withObject:firstDictionary];
                
                // Alert player met nieuwe highscore
                alertMessage = [NSString stringWithFormat:@"Je hebt een nieuwe highscore:\n %i", score];
                UIAlertView *highScoreAlert = [[UIAlertView alloc]initWithTitle:@"Congratz!" message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                [highScoreAlert show];
                
                break;
            }
        }
    }
    
    else if (selectedRounds == 5)
    {
        for (int i = 5; i < 10; i++)
        {
            scoresPlist = [dataFromPlist objectAtIndex:i];
            
            if (score == [scoresPlist intValue]) {
                break;
            }
            
            else if ((score > [scoresPlist intValue]) && (score != [scoresPlist intValue]))
            {
                NSMutableDictionary *firstDictionary = [[highscores objectAtIndex:i] mutableCopy];
                [firstDictionary setObject:[NSNumber numberWithInteger:score] forKey:@"highscore"];
                [firstDictionary setObject:[NSString stringWithFormat:@"%@", date] forKey:@"date"];
                [highscores replaceObjectAtIndex:i withObject:firstDictionary];
                
                alertMessage = [NSString stringWithFormat:@"Je hebt een nieuwe highscore:\n %i", score];
                UIAlertView *highScoreAlert = [[UIAlertView alloc]initWithTitle:@"Congratz!" message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                [highScoreAlert show];
                
                break;
            }
        }
    }
    
    else if (selectedRounds == 10)
    {
        for (int i = 10; i < 15; i++)
        {
            scoresPlist = [dataFromPlist objectAtIndex:i];
            
            if (score == [scoresPlist intValue]) {
                break;
            }
            
            else if ((score > [scoresPlist intValue]) && (score != [scoresPlist intValue]))
            {
                NSMutableDictionary *firstDictionary = [[highscores objectAtIndex:i] mutableCopy];
                [firstDictionary setObject:[NSNumber numberWithInteger:score] forKey:@"highscore"];
                [firstDictionary setObject:[NSString stringWithFormat:@"%@", date] forKey:@"date"];
                [highscores replaceObjectAtIndex:i withObject:firstDictionary];
                
                alertMessage = [NSString stringWithFormat:@"Je hebt een nieuwe highscore:\n %i", score];
                UIAlertView *highScoreAlert = [[UIAlertView alloc]initWithTitle:@"Congratz!" message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                [highScoreAlert show];
                
                break;
            }
        }
    }
    
    // Schrijf naar plist
    [highscores writeToFile:path atomically:YES];
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self startNewGame];
    [self updateLabels];
    
    [self.view.layer addAnimation:transition forKey:nil];

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
