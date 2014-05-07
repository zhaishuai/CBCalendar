#import "CBDayView.h"

#import "CBDayView.h"

@implementation CBDayView{
    NSColor *circleColor;
    NSColor *pointColor;
    NSColor *tempBackGroundColor;
    BOOL addCircleToRect;
    BOOL addPoint;
}
#pragma mark - initalize
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initalize];
    }
    return self;
}
- (id)init{
    self = [super init];
    if(self){
        [self initalize];
        
    }
    return self;
}

- (void)initalize{
    self.rectBoundColor = [NSColor colorWithCalibratedRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:1];
    self.rectBackgroundColor = [NSColor colorWithCalibratedRed:251.0/255 green:251.0/255 blue:251.0/255 alpha:1];
    self.dayFontColor = [NSColor colorWithCalibratedRed:119.0/255 green:119.0/255 blue:119.0/255 alpha:1];
    circleColor = [NSColor colorWithCalibratedRed:225.0/255 green:66.0/255 blue:66.0/255 alpha:1];
    pointColor = [NSColor colorWithCalibratedRed:92.0/255 green:174.0/255 blue:8.0/255 alpha:1];
    self.day = @"1";
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

#pragma mark - setter method

- (void)setDay:(NSString *)day{
    _day = day;
    [self setNeedsDisplay:YES];
}

- (void)setRectBackgroundColor:(NSColor *)rectBackgroundColor{
    _rectBackgroundColor = rectBackgroundColor;
    [self setNeedsDisplay:YES];
}

- (void)setRectBoundColor:(NSColor *)rectBoundColor{
    _rectBoundColor = rectBoundColor;
    [self setNeedsDisplay:YES];
}

- (void)setDayFontColor:(NSColor *)dayFontColor{
    _dayFontColor = dayFontColor;
    [self setNeedsDisplay:YES];
}

#pragma mark - draw method

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    NSGraphicsContext* context = [NSGraphicsContext currentContext];
    [self drawRectangle:
     CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)
                context:context];
    //    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Helvetica" size:self.bounds.size.height*0.3], NSFontAttributeName,self.dayFontColor, NSForegroundColorAttributeName, nil];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont boldSystemFontOfSize:self.bounds.size.height*0.3], NSFontAttributeName,self.dayFontColor, NSForegroundColorAttributeName, nil];
    
    NSAttributedString * currentText=[[NSAttributedString alloc] initWithString:self.day attributes: attributes];
    
    [currentText drawAtPoint:NSMakePoint(0+(self.bounds.size.width-self.bounds.size.height*0.3*0.5*self.day.length)/2, 0+(self.bounds.size.height-self.bounds.size.height*0.3)/2)];
    if(addCircleToRect )
        [self addCircleToFontWithContext:context];
    if(addPoint )
        [self addPointWithContext:context];
    NSLog(@"redraw");
}

- (void)drawRectangle:(NSRect)rect context:(NSGraphicsContext*)context{
    [context saveGraphicsState];
    [self.rectBackgroundColor setFill];
    [self.rectBoundColor setStroke];
    [NSBezierPath setDefaultLineWidth:self.bounds.size.height*0.02];
    NSRectFill(rect);
    [NSBezierPath strokeRect:rect];
    [context restoreGraphicsState];
}

- (void)addCircleToFontWithContext:(NSGraphicsContext *)context{
    [context saveGraphicsState];
    [NSBezierPath setDefaultLineWidth:self.bounds.size.height*0.05];
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    
    [circleColor setStroke];
    [thePath appendBezierPathWithOvalInRect:CGRectMake(self.bounds.size.width*0.1, self.bounds.size.height*0.1, self.bounds.size.width*0.8, self.bounds.size.height*0.8)];
    [thePath stroke];
    [context restoreGraphicsState];
}

- (void)addPointWithContext:(NSGraphicsContext *)context{
    [context saveGraphicsState];
    
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    [NSBezierPath setDefaultLineWidth:self.bounds.size.height*0.2];
    [pointColor setFill];
    [thePath appendBezierPathWithOvalInRect:CGRectMake(self.bounds.size.width/2-self.bounds.size.width*0.04, self.bounds.size.height*0.2, self.bounds.size.width*0.1, self.bounds.size.height*0.1)];
    [thePath fill];
    [context restoreGraphicsState];
}

- (void)drawCirleInRect:(BOOL)state color:(NSColor *)color{
    addCircleToRect = state;
    //if(!state)
    NSLog(@"hello");
    if(color!=nil)
        circleColor = color;
    [self setNeedsDisplay:YES];
}

- (void)drawPointInRect:(BOOL)state color:(NSColor *)color{
    addPoint = state;
    if(color!=nil)
        pointColor = color;
    [self setNeedsDisplay:YES];
}

#pragma mark - mouse event

- (void)mouseDown:(NSEvent *)theEvent{
    
    //tempBackGroundColor = self.rectBackgroundColor;
    self.alphaValue = 0.3;
    [self setNeedsDisplay:YES];
    NSLog(@"mouseDown");
}

- (void)mouseUp:(NSEvent *)theEvent{
    
    //self.rectBackgroundColor = tempBackGroundColor;
    self.alphaValue = 1;
    [self setNeedsDisplay:YES];
    NSLog(@"mouseUp");
}

@end