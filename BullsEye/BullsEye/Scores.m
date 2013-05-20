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

- (void)resetScore
{
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.score = 0;
}

- (void)calculatePointsRound
{
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    score = appDelegate.score;
    
    int points;
    int difference;
    if (appDelegate.evilGamePlay == NO) {
        difference = abs(self.targetValue - self.currentValue);
        points = 100 - difference;
    } else {
        int difference1 = abs(self.targetValue1 - self.currentValue1);
        int difference2 = abs(self.targetValue2 - self.currentValue2);
        
        difference = difference1 + difference2;
        points = 100 - difference;
    }
    
    // message depending on difference
    if (self.difference == 0) {
        points += 100;
    } else if (self.difference == 1) {
            points += 50;
        }
   
    score += points;
    appDelegate.score = score;
    appDelegate.difference = difference;
    [self.delegate pointsScored:points];
}

- (void)saveHighscores
{
    BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    score = appDelegate.score;
    currentSelectedRounds = appDelegate.currentSelectedRounds;
    
    NSString *path;
    if (appDelegate.evilGamePlay == NO) {
        // Load property list
        path = [[NSBundle mainBundle] pathForResource:@"highscorelist" ofType:@"plist"];
        highscores = [NSMutableArray arrayWithContentsOfFile:path];
    } else {
        // Load property list
        path = [[NSBundle mainBundle] pathForResource:@"evilhighscorelist" ofType:@"plist"];
        highscores = [NSMutableArray arrayWithContentsOfFile:path];
    }
        
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
    [self.delegate highscore:score];
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
