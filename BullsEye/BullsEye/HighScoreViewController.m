//
//  HighScoreViewController.m
//  BullsEye
//
//  Created by Myrthe Bil en Miguel Pruijssers on 18-04-13.
//  Copyright (c) 2013 App Studio. All rights reserved.
//

#import "HighScoreViewController.h"
#import "BullsEyeAppDelegate.h"

@interface HighScoreViewController ()

@end

@implementation HighScoreViewController

@synthesize sortedHighScores;
@synthesize indexToPath;
@synthesize cellFromTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *) [[UIApplication sharedApplication] delegate];
        // load de property list
        if (appDelegate.evilGamePlay == NO) {
            [self retrieveWithSelectedPlist:@"highscorelist"];
        }
        
        else {
            [self retrieveWithSelectedPlist:@"evilhighscorelist"];
        }
    }
    return self;
}

// select the right plist and sort the highscores
- (void)retrieveWithSelectedPlist:(NSString*)properPlist
{
    // make an array for the highscores
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", properPlist] ofType:@"plist"];
    NSMutableArray *highscores = [NSMutableArray arrayWithContentsOfFile:path];
    
    // sort on descending order
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"highscore" ascending:NO];
    sortedHighScores = [NSMutableArray arrayWithArray:[highscores sortedArrayUsingDescriptors:[NSMutableArray arrayWithObject:descriptor]]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    BullsEyeAppDelegate *delegate = (BullsEyeAppDelegate *) [[UIApplication sharedApplication] delegate];
    if (delegate.currentSelectedRounds == 1) {
        self.roundsOption.selectedSegmentIndex = 0;
    } else if (delegate.currentSelectedRounds == 5) {
        self.roundsOption.selectedSegmentIndex = 1;
    } else {
        self.roundsOption.selectedSegmentIndex = 2;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

// fill tableViewCells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"highScoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // call segment method when a segment value changes
    [self.roundsOption addTarget:self action:@selector(segmentedControlIndexChanged) forControlEvents:UIControlEventValueChanged];
    
    // create 2 class variables to use outside this method
    indexToPath = indexPath;
    cellFromTableView = cell;
    
    // retrieve the proper highscores for the proper amount of rounds
    if (self.roundsOption.selectedSegmentIndex == 0) {
        [self retrieveWithSelectedRounds:@"1"];
    }
    else if (self.roundsOption.selectedSegmentIndex == 1) {
        [self retrieveWithSelectedRounds:@"5"];
    }
    else if (self.roundsOption.selectedSegmentIndex == 2) {
        [self retrieveWithSelectedRounds:@"10"];
    }
    
    // change color of the text
    cell.textLabel.textColor = [UIColor orangeColor];
    cell.detailTextLabel.textColor = [UIColor redColor];
    
    return cell;
}

// retrieve highscores en dates to print in the cells
- (void)retrieveWithSelectedRounds:(NSString*)selectedRounds
{
    // search the array for the rounds
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"rounds == %@", selectedRounds];
    // filter the array
    NSArray *filteredArray = [sortedHighScores filteredArrayUsingPredicate:predicate];
    NSMutableDictionary *highscores = [filteredArray objectAtIndex:indexToPath.row];
    
    NSInteger highscore = [[highscores objectForKey:@"highscore"] integerValue];
    NSString *date = [highscores objectForKey:@"date"];
    
    // write highscors en dates in the cells
    cellFromTableView.textLabel.text = [NSString stringWithFormat:@"%i", highscore];
    cellFromTableView.detailTextLabel.text = [NSString stringWithFormat:@"%@",date];
}

// method to reload tableview after swithing segment
- (void)segmentedControlIndexChanged
{
    switch ([self.roundsOption selectedSegmentIndex]) {
        case 0:
        case 1:
        case 2:
            [self.tableView reloadData];
            break;
        default:
            break;
    }
}

- (IBAction)close
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
