//
//  CBCircle.m
//  CBCalendar
//
//  Created by jimzhai on 5/9/14.
//  Copyright (c) 2014 zhaishuai. All rights reserved.
//

#import "CBCircle.h"

@implementation CBCircle{
    BOOL moveIn;
    float circleAlpha;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createTrackingArea];
        circleAlpha = 1;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    NSGraphicsContext* context = [NSGraphicsContext currentContext];
    [self addCircleToFontWithContext:context];
}

- (void)addCircleToFontWithContext:(NSGraphicsContext *)context{
    [context saveGraphicsState];
    if(!moveIn){
    NSShadow* theShadow = [[NSShadow alloc] init];
    [theShadow setShadowOffset:NSMakeSize(0.0, 1.0)];
    [theShadow setShadowBlurRadius:3.0];
    
    // Use a partially transparent color for shapes that overlap.
    [theShadow setShadowColor:[[NSColor blackColor]
                               colorWithAlphaComponent:0.6]];
    
    [theShadow set];
    }
    [NSBezierPath setDefaultLineWidth:self.bounds.size.height*0.05];
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    
    [[[NSColor whiteColor] colorWithAlphaComponent:circleAlpha]setFill];
    [thePath appendBezierPathWithOvalInRect:CGRectMake(0, 0, self.bounds.size.width*0.8, self.bounds.size.height*0.8)];
    [thePath fill];
    [context restoreGraphicsState];
}

- (void) createTrackingArea
{
    int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
    NSTrackingArea *trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds]
                                                                 options:opts
                                                                   owner:self
                                                                userInfo:nil];
    [self addTrackingArea:trackingArea];
}

- (void)mouseEntered:(NSEvent *)theEvent{
    moveIn = !moveIn;
    [self setNeedsDisplay:YES];
    
}

- (void)mouseExited:(NSEvent *)theEvent{
    moveIn = !moveIn;
    [self setNeedsDisplay:YES];
}

- (void)mouseDown:(NSEvent *)theEvent{
    circleAlpha = 0.3;
    [self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)theEvent{
    circleAlpha = 1;
    [self.delegate clickCircle];
    [self setNeedsDisplay:YES];
}

@end
