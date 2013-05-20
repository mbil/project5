//
//  Scores.m
//  BullsEye
//
//  Created by Miguel Pruijssers on 20-05-13.
//  Copyright (c) 2013 App Studio. All rights reserved.
//

#import "Scores.h"
#import "BullsEyeAppDelegate.h"

@implementation Scores {
    int score;
}

@synthesize highscores;
@synthesize dataFromPlist;
@synthesize scoresPlist;
@synthesize delegate;

- (void)resetScores
{
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.score = 0;
    [self.delegate resetScore:score];
}

- (void)calculatePointsRound
{
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    score = appDelegate.score;

    NSLog(@"%d", appDelegate.score);
    
    // calculate difference
    int difference = abs(self.targetValue - self.currentValue);
    int points = 100 - difference;
    
    // message depending on difference
    if (difference == 0) {
        self.title = @"Perfect!";
        points += 100;
        
    } else if (difference < 5) {
        if (difference == 1) {
            points += 50;
        }
        self.title = @"You almost had it!";
    } else if (difference < 10) {
        self.title = @"Pretty good!";
    } else {
        self.title = @"Not even close...";
    }
    
    NSString *message = [NSString stringWithFormat:@"You scored %d points", points];

    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:self.title
                              message:message
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
    
    score += points;
    appDelegate.score = score;
    NSLog(@"%d", appDelegate.score);
    [self.delegate pointsScored:score];
}

- (void)saveHighscores
{
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    score = appDelegate.score;
    
    // Load property list
    NSString *path = [[NSBundle mainBundle] pathForResource:@"highscorelist" ofType:@"plist"];
    highscores = [NSMutableArray arrayWithContentsOfFile:path];

    // Array for the highscores
    dataFromPlist = [highscores valueForKey:@"highscore"];


    if (currentSelectedRounds == 1) {
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
                //[self alertMessage];

                break;
            }
        }
    }

    else if (currentSelectedRounds == 5) {
        for (int i = 5; i < 10; i++) {

            scoresPlist = [dataFromPlist objectAtIndex:i];

            if (score == [scoresPlist intValue]) {
                break;
            }

            else if (score > [scoresPlist intValue]) {
                [self writeToDictionary:i];
                //[self alertMessage];

                break;
            }
        }
    }


    else if (currentSelectedRounds == 10) {
        for (int i = 10; i < 15; i++) {
            scoresPlist = [dataFromPlist objectAtIndex:i];

            if (score == [scoresPlist intValue]) {
                break;
            }

            else if (score > [scoresPlist intValue]) {
                [self writeToDictionary:i];
                //[self alertMessage];

                break;
            }
        }
    }

    // Write to plist
    [highscores writeToFile:path atomically:YES];
}

- (void)writeToDictionary:(NSInteger)i
{
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    score = appDelegate.score;
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

@end
