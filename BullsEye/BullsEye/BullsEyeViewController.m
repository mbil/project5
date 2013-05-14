//
//  BullsEyeViewController.m
//  BullsEye
//
//  Created by Myrthe Bil en Miguel Pruijssers on 01-06-12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BullsEyeViewController.h"
#import "AboutViewController.h"
#import "HighScoreViewController.h"

@interface BullsEyeViewController ()

@end

@implementation BullsEyeViewController {
    int currentValue;
    int targetValue;
    int score;
    int round;
}

- (void)updateLabels
{
    self.targetLabel.text = [NSString stringWithFormat:@"%d", targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d", round];
}

- (void)startNewRound
{
    round += 1;
 
    targetValue = 1 + (arc4random() % 100);
 
    currentValue = 50;
    self.slider.value = currentValue;
}

- (void)startNewGame
{
    score = 0;
    round = -1;
    [self startNewRound];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startNewGame];
    [self updateLabels];

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
    int difference = abs(targetValue - currentValue);
    int points = 100 - difference;
 
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

    [alertView show];
}

- (IBAction)sliderMoved:(UISlider *)sender
{
    currentValue = lroundf(sender.value);
}

- (IBAction)startOver
{    
    // Datum van vandaag
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *date = [dateFormatter stringFromDate:currentDate];
    
    // Load de property list
    NSString *path = [[NSBundle mainBundle] pathForResource:@"highscorelist" ofType:@"plist"];
    NSMutableArray *highscores = [NSMutableArray arrayWithContentsOfFile:path];
    
    // Array voor de highscores
    NSArray *dataFromPlist = [highscores valueForKey:@"highscore"];
    
    // Maak number variabel aan voor de highscores uit de plist
    NSNumber *scoresPlist;
    
    // Maak variabel voor alertmessage
    NSString *alertMessage = nil;
    
    // Als ronde 1 is voltooid
    if (round == 1)
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
                NSMutableDictionary *newestDictionary = [[highscores objectAtIndex:i] mutableCopy];
                // Wijzig highscore en datum
                [newestDictionary setObject:[NSNumber numberWithInteger:score] forKey:@"highscore"];
                [newestDictionary setObject:[NSString stringWithFormat:@"%@", date] forKey:@"date"];
                // Vervang oude dictionary voor nieuwe
                [highscores replaceObjectAtIndex:i withObject:newestDictionary];
                
                // Alert player met nieuwe highscore
                alertMessage = [NSString stringWithFormat:@"Je hebt een nieuwe highscore:\n %i", score];
                UIAlertView *highScoreAlert = [[UIAlertView alloc]initWithTitle:@"Congratz!" message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                [highScoreAlert show];
                
                break;
            }
        }
    }
    
    else if (round == 5)
    {        
        for (int i = 5; i < 10; i++)
        {
            scoresPlist = [dataFromPlist objectAtIndex:i];
            
            if (score == [scoresPlist intValue]) {
                break;
            }
            
            else if ((score > [scoresPlist intValue]) && (score != [scoresPlist intValue]))
            {
                NSMutableDictionary *newestDictionary = [[highscores objectAtIndex:i] mutableCopy];
                [newestDictionary setObject:[NSNumber numberWithInteger:score] forKey:@"highscore"];
                [newestDictionary setObject:[NSString stringWithFormat:@"%@", date] forKey:@"date"];
                [highscores replaceObjectAtIndex:i withObject:newestDictionary];

                alertMessage = [NSString stringWithFormat:@"Je hebt een nieuwe highscore:\n %i", score];
                UIAlertView *highScoreAlert = [[UIAlertView alloc]initWithTitle:@"Congratz!" message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                [highScoreAlert show];
                
                break;
            }
        }
    }

    else if (round == 10)
    {
        for (int i = 10; i < 15; i++)
        {
            scoresPlist = [dataFromPlist objectAtIndex:i];
            
            if (score == [scoresPlist intValue]) {
                break;
            }
            
            else if ((score > [scoresPlist intValue]) && (score != [scoresPlist intValue]))
            {
                NSMutableDictionary *newestDictionary = [[highscores objectAtIndex:i] mutableCopy];
                [newestDictionary setObject:[NSNumber numberWithInteger:score] forKey:@"highscore"];
                [newestDictionary setObject:[NSString stringWithFormat:@"%@", date] forKey:@"date"];
                [highscores replaceObjectAtIndex:i withObject:newestDictionary];
                
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

- (IBAction)showHighScores
{
    HighScoreViewController *controller = [[HighScoreViewController alloc] initWithNibName:@"HighScoreViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self startNewRound];
    [self updateLabels];
}

@end
