//
//  HighScoreViewController.m
//  BullsEye
//
//  Created by Miguel Pruijssers on 18-04-13.
//  Copyright (c) 2013 Hollance. All rights reserved.
//

#import "HighScoreViewController.h"
#import "BullsEyeAppDelegate.h"

@interface HighScoreViewController ()

@end

@implementation HighScoreViewController

@synthesize sortedHighScores;

// Initialiseren
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        BullsEyeAppDelegate *appDelegate = (BullsEyeAppDelegate *) [[UIApplication sharedApplication] delegate];
        // Load de property list
        if (appDelegate.evilGamePlay == NO) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"highscorelist" ofType:@"plist"];
            NSMutableArray *highscores = [NSMutableArray arrayWithContentsOfFile:path];
            
            // Sorteer op descending
            NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"highscore" ascending:NO];
            sortedHighScores = [NSMutableArray arrayWithArray:[highscores sortedArrayUsingDescriptors:[NSMutableArray arrayWithObject:descriptor]]];
        }else {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"evilhighscorelist" ofType:@"plist"];
            NSMutableArray *highscores = [NSMutableArray arrayWithContentsOfFile:path];
            
            // Sorteer op descending
            NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"highscore" ascending:NO];
            sortedHighScores = [NSMutableArray arrayWithArray:[highscores sortedArrayUsingDescriptors:[NSMutableArray arrayWithObject:descriptor]]];
        }  
             
    }
    return self;
}

// ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
}

// DidReceiveMemoryWarning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Auto rotate screen naar landscape mode
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

// Table heeft 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// Table heeft rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
    //return [sortedHighScores count];
}

// Invullen tablecells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Standaard stuff
    static NSString *CellIdentifier = @"highScoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

    // Roep method segmentedControlIndexChanged als value van segment veranderd
    [self.roundsOption addTarget:self action:@selector(segmentedControlIndexChanged) forControlEvents:UIControlEventValueChanged];
    
    // selectedRounds = 'leeg'
    NSString *selectedRounds = @"";

    // Als eerste segment is geselecteerd
    if (self.roundsOption.selectedSegmentIndex == 0)
    {
        selectedRounds = @"1";
        // Zoek in array naar rounds = 1
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"rounds == %@", selectedRounds];
        // Filter de array
        NSArray *filteredArray = [sortedHighScores filteredArrayUsingPredicate:predicate];
        NSMutableDictionary *highscores = [filteredArray objectAtIndex:indexPath.row];
        // Selecteer uit de gefilterde array de integers met key highscore en date
        NSInteger highscore = [[highscores objectForKey:@"highscore"] integerValue];
        NSString *date = [highscores objectForKey:@"date"];
        
        // Schrijf highscores en dates in de cellen
        cell.textLabel.text = [NSString stringWithFormat:@"%i", highscore];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",date];
    }
    else if (self.roundsOption.selectedSegmentIndex == 1)
    {
        selectedRounds = @"5";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"rounds == %@", selectedRounds];
        NSArray *filteredArray = [sortedHighScores filteredArrayUsingPredicate:predicate];
        NSMutableDictionary *highscores = [filteredArray objectAtIndex:indexPath.row];
        NSInteger highscore = [[highscores objectForKey:@"highscore"] integerValue];
        NSString *date = [highscores objectForKey:@"date"];
        cell.textLabel.text = [NSString stringWithFormat:@"%i", highscore];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",date];
    }
    else if (self.roundsOption.selectedSegmentIndex == 2)
    {
        selectedRounds = @"10";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"rounds == %@", selectedRounds];
        NSArray *filteredArray = [sortedHighScores filteredArrayUsingPredicate:predicate];
        NSMutableDictionary *highscores = [filteredArray objectAtIndex:indexPath.row];
        NSInteger highscore = [[highscores objectForKey:@"highscore"] integerValue];
        NSString *date = [highscores objectForKey:@"date"];
        cell.textLabel.text = [NSString stringWithFormat:@"%i", highscore];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",date];
    }

    // Verander kleur font van text in cell
    cell.textLabel.textColor = [UIColor orangeColor];
    cell.detailTextLabel.textColor = [UIColor redColor];
    
    return cell;
}

// Method voor het reloaden van de table nadat segment is geselecteerd
- (void)segmentedControlIndexChanged
{
    switch ([self.roundsOption selectedSegmentIndex]) {
        case 0:
            [self.tableView reloadData];
            break;
        case 1:
            [self.tableView reloadData];
            break;
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
