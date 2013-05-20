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
        // Load de property list
        if (appDelegate.evilGamePlay == NO) {
            [self retrieveWithSelectedPlist:@"highscorelist"];
        }
        
        else {
            [self retrieveWithSelectedPlist:@"evilhighscorelist"];
        }
    }
    return self;
}

// Select the right plist and sort the highscores
- (void)retrieveWithSelectedPlist:(NSString*)properPlist
{
    // Make an array for the highscores
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", properPlist] ofType:@"plist"];
    NSMutableArray *highscores = [NSMutableArray arrayWithContentsOfFile:path];
    
    // Sort on descending order
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

// Fill tableViewCells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"highScoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // Call segment method when a segment value changes
    [self.roundsOption addTarget:self action:@selector(segmentedControlIndexChanged) forControlEvents:UIControlEventValueChanged];
    
    // Create 2 class variables to use outside this method
    indexToPath = indexPath;
    cellFromTableView = cell;
    
    // Retrieve the proper highscores for the proper amount of rounds
    if (self.roundsOption.selectedSegmentIndex == 0) {
        [self retrieveWithSelectedRounds:@"1"];
    }
    else if (self.roundsOption.selectedSegmentIndex == 1) {
        [self retrieveWithSelectedRounds:@"5"];
    }
    else if (self.roundsOption.selectedSegmentIndex == 2) {
        [self retrieveWithSelectedRounds:@"10"];
    }
    
    // Change color of the text
    cell.textLabel.textColor = [UIColor orangeColor];
    cell.detailTextLabel.textColor = [UIColor redColor];
    
    return cell;
}

// Retrieve highscores en dates to print in the cells
- (void)retrieveWithSelectedRounds:(NSString*)selectedRounds
{
    // Search the array for the rounds
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"rounds == %@", selectedRounds];
    // Filter the array
    NSArray *filteredArray = [sortedHighScores filteredArrayUsingPredicate:predicate];
    NSMutableDictionary *highscores = [filteredArray objectAtIndex:indexToPath.row];
    
    NSInteger highscore = [[highscores objectForKey:@"highscore"] integerValue];
    NSString *date = [highscores objectForKey:@"date"];
    
    // Write highscors en dates in the cells
    cellFromTableView.textLabel.text = [NSString stringWithFormat:@"%i", highscore];
    cellFromTableView.detailTextLabel.text = [NSString stringWithFormat:@"%@",date];
}

// Method to reload tableview after swithing segment
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
