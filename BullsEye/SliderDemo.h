//
//  SliderDemo.h
//  DemoSlider
//
//  Created by http://Sugartin.info on 15/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderDemo : UIControl{
    float minimumValue;
    float maximumValue;
    float minimumRange;
    float selectedMinimumValue;
    float selectedMaximumValue;
    float distanceFromCenter;
    
    float _padding;
    
    BOOL _maxThumbOn;
    BOOL _minThumbOn;
    
    UIImageView * _minThumb;
    UIImageView * _maxThumb;
    UIImageView * _track;
    UIImageView * _trackBackground;
}
@property (nonatomic) float minimumValue;
@property (nonatomic) float maximumValue;
@property (nonatomic) float minimumRange;
@property (nonatomic) float selectedMinimumValue;
@property (nonatomic) float selectedMaximumValue;
@end
