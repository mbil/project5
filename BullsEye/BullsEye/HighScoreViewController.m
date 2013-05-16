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

// Initialiseren
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

// Selecteer juiste plist en sorteer
- (void)retrieveWithSelectedPlist:(NSString*)properPlist
{
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", properPlist] ofType:@"plist"];
    NSMutableArray *highscores = [NSMutableArray arrayWithContentsOfFile:path];
    
    // Sorteer op descending
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"highscore" ascending:NO];
    sortedHighScores = [NSMutableArray arrayWithArray:[highscores sortedArrayUsingDescriptors:[NSMutableArray arrayWithObject:descriptor]]];
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
}

// Invullen tablecells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Standaard stuff
    static NSString *CellIdentifier = @"highScoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

    // Roep method segmentedControlIndexChanged als value van segment veranderd
    [self.roundsOption addTarget:self action:@selector(segmentedControlIndexChanged) forControlEvents:UIControlEventValueChanged];
    
    // maak 2 globale variabelen aan, indexPath en cell werken niet buiten deze methode
    indexToPath = indexPath;
    cellFromTableView = cell;

    // Als eerste segment is geselecteerd
    if (self.roundsOption.selectedSegmentIndex == 0) {
        [self retrieveWithSelectedRounds:@"1"];
    }
    else if (self.roundsOption.selectedSegmentIndex == 1) {
        [self retrieveWithSelectedRounds:@"5"];
    }
    else if (self.roundsOption.selectedSegmentIndex == 2) {
        [self retrieveWithSelectedRounds:@"10"];
    }

    // Verander kleur font van text in cell
    cell.textLabel.textColor = [UIColor orangeColor];
    cell.detailTextLabel.textColor = [UIColor redColor];
    
    return cell;
}

// Haal highscores en dates uit plist en show in tableviewcells
- (void)retrieveWithSelectedRounds:(NSString*)selectedRounds
{
    // Zoek in array naar bijbehorende rounds
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"rounds == %@", selectedRounds];
    // Filter de array
    NSArray *filteredArray = [sortedHighScores filteredArrayUsingPredicate:predicate];
    NSMutableDictionary *highscores = [filteredArray objectAtIndex:indexToPath.row];
    // Selecteer uit de gefilterde array de integers met key highscore en date
    NSInteger highscore = [[highscores objectForKey:@"highscore"] integerValue];
    NSString *date = [highscores objectForKey:@"date"];
    
    // Schrijf highscores en dates in de cellen
    cellFromTableView.textLabel.text = [NSString stringWithFormat:@"%i", highscore];
    cellFromTableView.detailTextLabel.text = [NSString stringWithFormat:@"%@",date];
}

// Method voor het reloaden van de table nadat segment is geselecteerd
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

// Close
- (IBAction)close
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
