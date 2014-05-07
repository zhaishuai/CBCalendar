#import "CBMonthView.h"
#import "CBDayView.h"

@implementation CBMonthView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (id)init{
    self = [super init];
    if(self){
        [self initalize];
        NSLog(@"hello");
    }
    return self;
}

- (void)awakeFromNib{
    [self initalize];
}

- (void)initalize{
    NSMutableArray *views = [[NSMutableArray alloc] init];
    double height = self.bounds.size.height,width = self.bounds.size.width;
    double w = width/7,h = height/6;
    for(int i=5,count=1;i>=0;i--)
        for(int j=0;j<7;j++,count++){
            CBDayView *day = [[CBDayView alloc] initWithFrame:CGRectMake(w*j, h*i, w, h)];
            day.day = [NSString stringWithFormat:@"%d",count];
            if(count == 6){
                [day drawCirleInRect:YES color:nil];
            }
            if(count == 3){
                [day drawPointInRect:YES color:nil];
            }
            [views addObject:day];
        }
    [self setSubviews:views];
}
@end
