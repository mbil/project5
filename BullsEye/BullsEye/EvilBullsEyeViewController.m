//
//  ViewController.m
//  DemoSlider
//
//  Created by http://Sugartin.info on 16/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "EvilBullsEyeViewController.h"
#import "SliderDemo.h"
#import "BullsEyeViewController.h"
#import "AboutViewController.h"

@interface EvilBullsEyeViewController ()

@end

@implementation EvilBullsEyeViewController {
    int currentValue1;
    int currentValue2;
    int targetValue1;
    int targetValue2;
    int score;
    int round;
}

@synthesize lblForRange = _lblForRange;
@synthesize targetLabel1;
@synthesize targetLabel2;
@synthesize scoreLabel;
@synthesize roundLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startNewGame];
    [self updateLabels];
	// Do any additional setup after loading the view, typically from a nib.
    UIView *VctrDtl=[[UIView alloc]initWithFrame:CGRectMake(80,110,300, 15)];
    SliderDemo *sliderVctr=[[SliderDemo alloc] initWithFrame:CGRectMake(VctrDtl.bounds.origin.x,VctrDtl.bounds.origin.y,VctrDtl.bounds.size.width, VctrDtl.bounds.size.height)];
    sliderVctr.minimumValue =0;
    sliderVctr.selectedMinimumValue = 20;
    sliderVctr.maximumValue = 100;
    sliderVctr.selectedMaximumValue = 80;
    sliderVctr.minimumRange = 10;
    [sliderVctr addTarget:self action:@selector(updateRangeLabel:) forControlEvents:UIControlEventValueChanged];
    [VctrDtl addSubview:sliderVctr];
    [self.view addSubview:VctrDtl];
}

-(void)updateRangeLabel:(SliderDemo *)slider{
    self.lblForRange.text=[NSString stringWithFormat:@"%0.0f - %0.0f", slider.selectedMinimumValue, slider.selectedMaximumValue];
    currentValue1 = (int) slider.selectedMinimumValue;
    currentValue2 = (int) slider.selectedMaximumValue;
}


- (void)updateLabels
{
    self.targetLabel1.text = [NSString stringWithFormat:@"%d", targetValue1];
    self.targetLabel2.text = [NSString stringWithFormat:@"%d", targetValue2];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d", round];
}


- (void)startNewRound
{
    round += 1;
    
    targetValue1 = 1 + (arc4random() % 50);
    targetValue2 = 51 + (arc4random() % 50);

}

- (void)startNewGame
{
    score = 0;
    round = 0;
    [self startNewRound];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    
}

- (IBAction)showAlert
{
    int difference1 = abs(targetValue1 - currentValue1);
    int difference2 = abs(targetValue2 - currentValue2);
    
    int totaldifference = difference1 + difference2;
    int points = 100 - totaldifference;
    
    NSString *title;
    if (totaldifference == 0) {
        title = @"Perfect!";
        points += 100;
    } else if (totaldifference < 10) {
        if (totaldifference == 2) {
            points += 50;
        }
        title = @"You almost had it!";
    } else if (totaldifference < 20) {
        title = @"Pretty good!";
    } else {
        title = @"Not even close...";
    }
    
    score += points;
    
    NSString *message = [NSString stringWithFormat:@"You scored %d points", points];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    
    [alertView show];
}


- (IBAction)startOver
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self startNewGame];
    [self updateLabels];
    
    [self.view.layer addAnimation:transition forKey:nil];
}

- (IBAction)showInfo
{
    AboutViewController *controller = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self startNewRound];
    [self updateLabels];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)toggleEvilOff:(id)sender {
    BullsEyeViewController *eviloff = [[BullsEyeViewController alloc] initWithNibName:nil bundle:nil];
    
    [eviloff setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentModalViewController:eviloff animated:YES];
}



@end
