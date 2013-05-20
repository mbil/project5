//
//  Scores.h
//  BullsEye
//
//  Created by Miguel Pruijssers on 20-05-13.
//  Copyright (c) 2013 App Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScoresDelegate <NSObject>

- (void)highscore:(int)number;
- (void)pointsScored:(int)number;

@end

@interface Scores : NSObject {
    NSMutableArray *highscores;
    NSArray *dataFromPlist;
    NSNumber *scoresPlist;
    int currentSelectedRounds;
}

@property (nonatomic, strong) NSMutableArray *highscores;
@property (nonatomic, strong) NSArray *dataFromPlist;
@property (nonatomic, strong) NSNumber *scoresPlist;
@property (nonatomic) NSUInteger targetValue;
@property (nonatomic) NSUInteger targetValue1;
@property (nonatomic) NSUInteger targetValue2;
@property (nonatomic) NSUInteger currentValue;
@property (nonatomic) NSUInteger currentValue1;
@property (nonatomic) NSUInteger currentValue2;
@property (nonatomic) NSUInteger difference;
@property (nonatomic, strong) id <ScoresDelegate> delegate;
@property (nonatomic) NSString *title;

- (void)saveHighscores;
- (void)calculatePointsRound;
- (void)resetScore;


@end
