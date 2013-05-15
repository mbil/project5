//
//  HighScoreViewController.h
//  BullsEye
//
//  Created by Miguel Pruijssers on 18-04-13.
//  Copyright (c) 2013 Hollance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoreViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sortedHighScores;
@property (nonatomic, strong) IBOutlet UISegmentedControl *roundsOption;
@property (nonatomic, strong) NSIndexPath *indexToPath;
@property (nonatomic, strong) UITableViewCell  *cellFromTableView;

- (IBAction)close;

@end
