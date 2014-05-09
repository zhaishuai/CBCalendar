#import "CBMonthView.h"
#import "CBDayView.h"

@implementation CBMonthView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)init{
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib{
    [self initialize];
}

- (void)initialize{
    NSDictionary *currentDate = [self getCurrentMonthDayYear];
    self.currentDate = currentDate;
    [self updateCalendarWithMonth:[[currentDate objectForKey:@"month"] intValue] withYear:[[currentDate objectForKey:@"year"] intValue]];
}

- (void)updateCalendarWithMonth:(int)month withYear:(int)year{
    NSMutableArray *views = [[NSMutableArray alloc] init];
    double height = self.bounds.size.height,width = self.bounds.size.width;
    double w = width/7,h = height/6;
    int firstday = [self getWeekdayWithMonth:month withDay:1 withYear:year];
    int monthLength = [self getMonthLengthWithMonth:month withYear:year];
    NSDictionary *currentDate = [self getCurrentMonthDayYear];
    NSLog(@"%d",monthLength);
    for(int day = 1,i=5,weekday = firstday;day <= monthLength ;i--){
        for(;weekday <= 7&&day <= monthLength;weekday++,day++){
            CBDayView *dayView = [[CBDayView alloc] initWithFrame:CGRectMake(w*(weekday-1), h*i, w, h)];
            dayView.day = [NSString stringWithFormat:@"%d",day];
            dayView.state = 0;
            if([[currentDate objectForKey:@"day"] intValue]==day&&year==[[currentDate objectForKey:@"year"] intValue]&&month==[[currentDate objectForKey:@"month"] intValue]){
                [dayView drawCirleInRect:YES color:nil];
            }
            [views addObject:dayView];
        }
        weekday = 1;
    }
    int perious=0;
    if(month-1<=0)
        perious = [self getMonthLengthWithMonth:1 withYear:year-1]-firstday+2;
    else
        perious = [self getMonthLengthWithMonth:month-1 withYear:year]-firstday+2;
    
    for(int i=0;i<firstday-1;i++,perious++){
        CBDayView *dayView = [[CBDayView alloc] initWithFrame:CGRectMake(w*i, h*5, w, h)];
        [dayView setDayFontColor:[NSColor colorWithCalibratedRed:184.0/225 green:184.0/225 blue:184.0/225 alpha:1]];
        [dayView setDay:[NSString stringWithFormat:@"%d",perious]];
        dayView.state = -1;
        [views addObject:dayView];
    }
    int nextMonthDays = 43-monthLength-firstday;
    int rawNum = nextMonthDays/7;
    int leastDays = monthLength-(8-firstday);
    
    if(nextMonthDays%7)
        rawNum++;
    for(int i=4-leastDays/7,count=1,j=leastDays%7;i>=0;i--){
        for(;j<7;j++,count++){
            CBDayView *dayView = [[CBDayView alloc] initWithFrame:CGRectMake(w*j, h*i, w, h)];
            [dayView setDayFontColor:[NSColor colorWithCalibratedRed:184.0/225 green:184.0/225 blue:184.0/225 alpha:1]];
            [dayView setDay:[NSString stringWithFormat:@"%d",count]];
            dayView.state = 1;
            [views addObject:dayView];
        }
        j=0;
    }
    
    [self setSubviews:views];
}

- (int)getMonthLengthWithMonth:(int)month withYear:(int)year{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSRange days = [gregorian rangeOfUnit:NSDayCalendarUnit
                                   inUnit:NSMonthCalendarUnit
                                  forDate:date];
    return (int)days.length;
}

- (NSDictionary *)getCurrentMonthDayYear{
    NSCalendar *calendar = [[NSLocale currentLocale] objectForKey:NSLocaleCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit | NSWeekCalendarUnit;
    NSDate *date = [NSDate date];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInteger:comps.month] forKey:@"month"];
    [dict setObject:[NSNumber numberWithInteger:comps.day] forKey:@"day"];
    [dict setObject:[NSNumber numberWithInteger:comps.year] forKey:@"year"];
    return dict;
}

- (int)getWeekdayWithMonth:(int)month withDay:(int)day withYear:(int)year{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    return (int)[weekdayComponents weekday];
}



@end
