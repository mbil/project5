//
//  HighScoreViewController.h
//  BullsEye
//
//  Created by Myrthe Bil en Miguel Pruijssers on 18-04-13.
//  Copyright (c) 2013 App Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RoundsDelegate <NSObject>
-(void)numberOfRoundsHasChangedTo:(int)number;
@end

@interface Rounds : NSObject{
    int selectedRounds;
}

@property (nonatomic, strong) id <RoundsDelegate> delegate;

- (void)getRounds;

@end
