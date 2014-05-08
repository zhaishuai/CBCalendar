

#import "CBArrow.h"

@implementation CBArrow{
    BOOL leftMoveIn;
    BOOL rightMoveIn;
    float arrowAlpha;
}

- (id)initWithFrame:(NSRect)frame withLeft:(BOOL)left
{
    self = [super initWithFrame:frame];
    if (self) {
        self.left = left;
        [self createTrackingArea];
        arrowAlpha = 1;
    }
    return self;
}



- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    if(self.left)
        [self drawRightTriangle];
    else
        [self drawLeftTriangle];
    NSLog(@"reDraw");
}

- (void)drawLeftTriangle{
    
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    if(!leftMoveIn){
        NSShadow* theShadow = [[NSShadow alloc] init];
        [theShadow setShadowOffset:NSMakeSize(0, 2)];
        [theShadow setShadowBlurRadius:2];
        [theShadow setShadowColor:[[NSColor blackColor]
                               colorWithAlphaComponent:0.3]];
        [theShadow set];
    }
    [thePath moveToPoint:CGPointMake(0.1339745962*self.bounds.size.height*0.8, 0.5*self.bounds.size.height*0.8)];
    [thePath lineToPoint:NSMakePoint(self.bounds.size.height*0.8, 0)];
    [thePath lineToPoint:NSMakePoint(self.bounds.size.height*0.8, self.bounds.size.height*0.8)];
    [thePath lineToPoint:CGPointMake(0.1339745962*self.bounds.size.height*0.8, 0.5*self.bounds.size.height*0.8)];
    
    [thePath closePath];
    [[[NSColor whiteColor] colorWithAlphaComponent:arrowAlpha]setFill];
    [thePath fill];
}

- (void)drawRightTriangle{
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    if(!rightMoveIn){
        NSShadow* theShadow = [[NSShadow alloc] init];
        [theShadow setShadowOffset:NSMakeSize(0, 2)];
        [theShadow setShadowBlurRadius:2];
        [theShadow setShadowColor:[[NSColor blackColor]
                               colorWithAlphaComponent:0.3]];
        [theShadow set];
    }
    [thePath moveToPoint:CGPointMake(0.8660254037*self.bounds.size.height*0.8, 0.5*self.bounds.size.height*0.8)];
    [thePath lineToPoint:NSMakePoint(0, 0)];
    [thePath lineToPoint:NSMakePoint(0, self.bounds.size.height*0.8)];
    [thePath lineToPoint:CGPointMake(0.8660254037*self.bounds.size.height*0.8, 0.5*self.bounds.size.height*0.8)];
    
    [thePath closePath];
    [[[NSColor whiteColor] colorWithAlphaComponent:arrowAlpha]setFill];
    [thePath fill];
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
    if(!self.left){
        leftMoveIn = YES;
    }
    else{
        rightMoveIn = YES;
    }
    [self setNeedsDisplay:YES];
    
}

- (void)mouseExited:(NSEvent *)theEvent{
    if (!self.left) {
        leftMoveIn = NO;
    }else{
        rightMoveIn = NO;
    }
    [self setNeedsDisplay:YES];
}

- (void)mouseDown:(NSEvent *)theEvent{
    arrowAlpha = 0.3;
    [self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)theEvent{
    arrowAlpha = 1;
    [self setNeedsDisplay:YES];
}

@end
