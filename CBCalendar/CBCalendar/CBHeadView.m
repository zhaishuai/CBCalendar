
#import "CBHeadView.h"

@implementation CBHeadView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    NSGraphicsContext* context = [NSGraphicsContext currentContext];
    [self drawRectangle:CGRectMake(0, 0, self.bounds.size.width*0.1, self.bounds.size.height*0.1)context:context];
    [self drawRectangle:CGRectMake(self.bounds.size.width*0.9, 0, self.bounds.size.width*0.1, self.bounds.size.height*0.1)context:context];
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    
    [thePath appendBezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) xRadius:5 yRadius:5];
    [[NSColor colorWithCalibratedRed:60.0/255 green:146.0/255 blue:210.0/255 alpha:1] setFill];
    [[NSColor colorWithCalibratedRed:60.0/255 green:146.0/255 blue:210.0/255 alpha:1] setStroke];
    [thePath stroke];
    [thePath fill];
    [self drawRightTriangle];
    // Drawing code here.
}

- (void)drawRectangle:(NSRect)rect context:(NSGraphicsContext*)context{
    [context saveGraphicsState];
    [[NSColor colorWithCalibratedRed:60.0/255 green:146.0/255 blue:210.0/255 alpha:1] setFill];
    [[NSColor colorWithCalibratedRed:60.0/255 green:146.0/255 blue:210.0/255 alpha:1] setStroke];
    [NSBezierPath setDefaultLineWidth:self.bounds.size.height*0.02];
    NSRectFill(rect);
    [NSBezierPath strokeRect:rect];
    [context restoreGraphicsState];
}
void DrawRoundedRect(NSRect rect, CGFloat x, CGFloat y)
{
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    
    [thePath appendBezierPathWithRoundedRect:rect xRadius:x yRadius:y];
    [thePath stroke];
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
