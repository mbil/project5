//
//  Scores.h
//  BullsEye
//
//  Created by Miguel Pruijssers on 20-05-13.
//  Copyright (c) 2013 App Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScoresDelegate <NSObject>

//- (void)numberHasChangedTo:(int)number;

@end

@interface Scores : NSObject {
    NSMutableArray *highscores;
    NSArray *dataFromPlist;
    NSNumber *scoresPlist;
    int currentSelectedRounds;
    int score;
}

@property (nonatomic, strong) NSMutableArray *highscores;
@property (nonatomic, strong) NSArray *dataFromPlist;
@property (nonatomic, strong) NSNumber *scoresPlist;
@property (nonatomic, strong) id <ScoresDelegate> delegate;

- (void)saveHighscores;

@end
