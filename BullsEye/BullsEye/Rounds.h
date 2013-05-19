//
//  Rounds.h
//  BullsEye
//
//  Created by Murph on 5/14/13.
//  Copyright (c) 2013 Hollance. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RoundsDelegate <NSObject>
-(void)numberOfRoundsHasChangedTo:(int)number;
@end

@interface Rounds : NSObject{
    int selectedRounds;
}

@property (nonatomic,strong) id <RoundsDelegate> delegate;

- (void)getRounds;

@end
