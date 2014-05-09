//
//  CBCircle.h
//  CBCalendar
//
//  Created by jimzhai on 5/9/14.
//  Copyright (c) 2014 zhaishuai. All rights reserved.
//

#import "CBArrow.h"

@protocol circleClick <NSObject>

- (void)clickCircle;

@end

@interface CBCircle : NSView

@property (nonatomic, weak)id<circleClick> delegate;

@end
