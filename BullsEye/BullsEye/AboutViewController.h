//
//  AboutViewController.h
//  BullsEye
//
//  Created by Myrthe Bil en Miguel Pruijssers on 01-06-12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIWebView *webView;

- (IBAction)close;

@end
