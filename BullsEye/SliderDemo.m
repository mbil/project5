//
//  SliderDemo.m
//  DemoSlider
//
//  Created by http://Sugartin.info on 15/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SliderDemo.h"

@interface SliderDemo (PrivateMethods)
-(float)xForValue:(float)value;
-(float)valueForX:(float)x;
-(void)updateTrackHighlight;
@end

@implementation SliderDemo
@synthesize minimumValue, maximumValue, minimumRange, selectedMinimumValue, selectedMaximumValue;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _minThumbOn = false;
        _maxThumbOn = false;
        _padding = 7;
        
        _trackBackground = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar-background.png"]] autorelease];
        //        _trackBackground.frame=CGRectMake(self.frame.origin.x,self.frame.origin.y, self.frame.size.width,11);
        _trackBackground.center = self.center;
        [self addSubview:_trackBackground];
        
        _track = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar-highlight.png"]] autorelease];
        //        _track.frame=CGRectMake(self.frame.origin.x,self.frame.origin.y, self.frame.size.height,self.frame.size.height);
        //       _track.frame=CGRectMake(self.frame.origin.x-40,20, self.frame.size.width,11);
        _track.center = self.center;
        [self addSubview:_track];
        
        _minThumb = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SliderThumb-Normal.png"] highlightedImage:[UIImage imageNamed:@"handle-hover.png"]] autorelease];
        _minThumb.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y, self.frame.size.height,self.frame.size.height);
        _minThumb.contentMode = UIViewContentModeCenter;
        [self addSubview:_minThumb];
        
        _maxThumb = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SliderThumb-Normal.png"] highlightedImage:[UIImage imageNamed:@"handle-hover.png"]] autorelease];
        _maxThumb.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y, self.frame.size.height,self.frame.size.height);
        _maxThumb.contentMode = UIViewContentModeCenter;
        [self addSubview:_maxThumb];
    }
    
    return self;
}


-(void)layoutSubviews
{
    // Set the initial state
    _minThumb.center = CGPointMake([self xForValue:selectedMinimumValue], self.center.y);
    
    _maxThumb.center = CGPointMake([self xForValue:selectedMaximumValue], self.center.y);

    [self updateTrackHighlight];
    
    
}

-(float)xForValue:(float)value{
    return (self.frame.size.width-(_padding*2))*((value - minimumValue) / (maximumValue - minimumValue))+_padding;
}

-(float) valueForX:(float)x{
    return minimumValue + (x-_padding) / (self.frame.size.width-(_padding*2)) * (maximumValue - minimumValue);
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    if(!_minThumbOn && !_maxThumbOn){
        return YES;
    }
    
    CGPoint touchPoint = [touch locationInView:self];
    if(_minThumbOn){
        _minThumb.center = CGPointMake(MAX([self xForValue:minimumValue],MIN(touchPoint.x - distanceFromCenter, [self xForValue:selectedMaximumValue - minimumRange])), _minThumb.center.y);
        selectedMinimumValue = [self valueForX:_minThumb.center.x];
        
    }
    if(_maxThumbOn){
        _maxThumb.center = CGPointMake(MIN([self xForValue:maximumValue], MAX(touchPoint.x - distanceFromCenter, [self xForValue:selectedMinimumValue + minimumRange])), _maxThumb.center.y);
        selectedMaximumValue = [self valueForX:_maxThumb.center.x];
    }
    [self updateTrackHighlight];
    [self setNeedsLayout];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

-(BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchPoint = [touch locationInView:self];
    
    if(CGRectContainsPoint(_minThumb.frame, touchPoint)){
        _minThumbOn = true;
        distanceFromCenter = touchPoint.x - _minThumb.center.x;
    }
    else if(CGRectContainsPoint(_maxThumb.frame, touchPoint)){
        _maxThumbOn = true;
        distanceFromCenter = touchPoint.x - _maxThumb.center.x;
        
    }
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    _minThumbOn = false;
    _maxThumbOn = false;
}

-(void)updateTrackHighlight{
    
	_track.frame = CGRectMake(
                              _minThumb.center.x,
                              _track.center.y - (_track.frame.size.height/2),
                              _maxThumb.center.x - _minThumb.center.x,
                              _track.frame.size.height
                              );
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
