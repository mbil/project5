//
//  ViewController.h
//  DemoSlider
//
//  Created by http://Sugartin.info on 16/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvilBullsEyeViewController : UIViewController

@property(nonatomic,retain)IBOutlet UILabel *lblForRange;
@property (nonatomic, strong) IBOutlet UILabel *targetLabel1;
@property (strong, nonatomic) IBOutlet UILabel *targetLabel2;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *roundLabel;

- (IBAction)showAlert;
- (IBAction)startOver;
- (IBAction)showInfo;

@end
