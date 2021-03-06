
#import "CBHeadView.h"
#import "CBArrow.h"
#import "CBCircle.h"

@implementation CBHeadView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    NSMutableArray *subViews = [[NSMutableArray alloc] init];
    CBArrow *leftArrow = [[CBArrow alloc] initWithFrame:CGRectMake(self.bounds.size.width*0.1, self.bounds.size.height*0.5, self.bounds.size.height*0.2, self.bounds.size.height*0.2) withLeft:NO];
    CBArrow *rightArrow = [[CBArrow alloc] initWithFrame:CGRectMake(self.bounds.size.width*0.9-self.bounds.size.height*0.15, self.bounds.size.height*0.5, self.bounds.size.height*0.2, self.bounds.size.height*0.2) withLeft:YES];
    [subViews addObject:leftArrow];
    [subViews addObject:rightArrow];
    //NSString *dateString = @"February 2013";
    NSString *dateString = @"2013 二月";
//    CBLabel *label = [[CBLabel alloc] initWithFrame:NSMakeRect(self.bounds.size.width/2-self.bounds.size.width*0.25, self.bounds.size.height*0.43, self.bounds.size.width*0.5, 0) withString:dateString];
    self.monthAndYear = [[NSTextField alloc] initWithFrame:NSMakeRect(self.bounds.size.width*0.2, 0, self.bounds.size.width*0.6, self.bounds.size.height*0.7) ];

    
    [self.monthAndYear setStringValue:dateString];
    [self.monthAndYear setFont:[NSFont boldSystemFontOfSize:self.bounds.size.height*0.18]];
    [self.monthAndYear setTextColor:[NSColor whiteColor]];
    [self.monthAndYear setAlignment:NSCenterTextAlignment];
    [self.monthAndYear setEditable:NO];
    [self.monthAndYear setSelectable:NO];
    [self.monthAndYear setBordered:NO];
    [self.monthAndYear setDrawsBackground:NO];

    [subViews addObject:self.monthAndYear];
    CBCircle *circle = [[CBCircle alloc] initWithFrame:NSMakeRect(self.bounds.size.width*0.18, self.bounds.size.height*0.5, self.bounds.size.height*0.2, self.bounds.size.height*0.2)];
    [subViews addObject:circle];
    [self setSubviews:subViews];
}

- (void)awakeFromNib{
    NSMutableArray *a = [[NSMutableArray alloc] init];
    [a addObject:@"SUN"];
    [a addObject:@"MON"];
    [a addObject:@"TUE"];
    [a addObject:@"WED"];
    [a addObject:@"THU"];
    [a addObject:@"FRI"];
    [a addObject:@"SAT"];
    self.SunDayToSatDay = a;
    [super awakeFromNib];
    [self initialize];
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
    double w=self.bounds.size.width/7;
    for(int i = 0 ; i < self.SunDayToSatDay.count ; i++){
        NSShadow* theShadow = [[NSShadow alloc] init];
        [theShadow setShadowOffset:NSMakeSize(0.0, 2.0)];
        [theShadow setShadowBlurRadius:3.0];
        
        // Use a partially transparent color for shapes that overlap.
        [theShadow setShadowColor:[[NSColor blackColor]
                                   colorWithAlphaComponent:0.6]];
        
        [theShadow set];
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Helvetica" size:w*0.3], NSFontAttributeName,[NSColor whiteColor], NSForegroundColorAttributeName, nil];
        NSAttributedString * currentText=[[NSAttributedString alloc] initWithString:[self.SunDayToSatDay objectAtIndex:i] attributes: attributes];
        [currentText drawAtPoint:NSMakePoint(w*(i+0.2),self.bounds.size.height*0.1)];
    }
    

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

@end
