//
//  ViewController.m
//  DemoSlider
//
//  Created by http://Sugartin.info on 16/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EvilBullsEyeViewController.h"
#import "SliderDemo.h"
@interface EvilBullsEyeViewController ()

@end

@implementation EvilBullsEyeViewController
@synthesize lblForRange = _lblForRange;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIView *VctrDtl=[[UIView alloc]initWithFrame:CGRectMake(20,300,300, 11)];
    SliderDemo *sliderVctr=[[SliderDemo alloc] initWithFrame:CGRectMake(VctrDtl.bounds.origin.x,VctrDtl.bounds.origin.y,VctrDtl.bounds.size.width, VctrDtl.bounds.size.height)];
    sliderVctr.minimumValue =0;
    sliderVctr.selectedMinimumValue = 0;
    sliderVctr.maximumValue = 9;
    sliderVctr.selectedMaximumValue = 9;
    sliderVctr.minimumRange = 00;
    [sliderVctr addTarget:self action:@selector(updateRangeLabel:) forControlEvents:UIControlEventValueChanged];
    [VctrDtl addSubview:sliderVctr];
    self.lblForRange.text=@"0 - 9";
    [self.view addSubview:VctrDtl];
}
-(void)updateRangeLabel:(SliderDemo *)slider{
    self.lblForRange.text=[NSString stringWithFormat:@"%0.0f - %0.0f", slider.selectedMinimumValue, slider.selectedMaximumValue];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
