//
//  CBArrow.m
//  CBCalendar
//
//  Created by jimzhai on 5/7/14.
//  Copyright (c) 2014 zhaishuai. All rights reserved.
//

#import "CBArrow.h"

@implementation CBArrow

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    if(self.left)
        [self drawRightTriangle];
    else
        [self drawLeftTriangle];
}

- (void)drawLeftTriangle{
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    [thePath moveToPoint:CGPointMake(0.1339745962*self.bounds.size.height, 0.5*self.bounds.size.height)];
    [thePath lineToPoint:NSMakePoint(self.bounds.size.height, 0)];
    [thePath lineToPoint:NSMakePoint(self.bounds.size.height, self.bounds.size.height)];
    [thePath lineToPoint:CGPointMake(0.1339745962*self.bounds.size.height, 0.5*self.bounds.size.height)];
    
    [thePath closePath];
    [[NSColor whiteColor] setStroke];
    [[NSColor whiteColor] setFill];
    [thePath stroke];
    [thePath fill];
}

- (void)drawRightTriangle{
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    [thePath moveToPoint:CGPointMake(0.8660254037*self.bounds.size.height, 0.5*self.bounds.size.height)];
    [thePath lineToPoint:NSMakePoint(0, 0)];
    [thePath lineToPoint:NSMakePoint(0, self.bounds.size.height)];
    [thePath lineToPoint:CGPointMake(0.8660254037*self.bounds.size.height, 0.5*self.bounds.size.height)];
    
    [thePath closePath];
    [[NSColor whiteColor] setStroke];
    [[NSColor whiteColor] setFill];
    [thePath stroke];
    [thePath fill];
}


@end
