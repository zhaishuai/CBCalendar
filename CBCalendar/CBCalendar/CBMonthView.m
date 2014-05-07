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
//    //////////////////////////////////////////////////////////
//    //取得当前月份的天数
//    NSCalendar *current = [[NSLocale currentLocale] objectForKey:NSLocaleCalendar];
//    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit | NSWeekCalendarUnit;
//    NSDate *today = [NSDate date];
//    NSRange days = [current rangeOfUnit:NSDayCalendarUnit
//                           inUnit:NSMonthCalendarUnit
//                          forDate:today];
//    //
//    //////////////////////////////////////////////////////////
//    
//    //////////////////////////////////////////////////////////
//    //判断1号是周几
//    NSDateComponents *comp = [[NSDateComponents alloc] init];
//    NSDateComponents *comps = [current components:unitFlags fromDate:today];
//    [comp setDay:1];
//    [comp setMonth:comps.month];
//    [comp setMonth:comps.year];
//    NSDate *temp = [[NSDate alloc] initWithTimeIntervalSince1970:[comps weekday]];
//    NSLog(@"%ld  %ld",comps.month,comps.year);
//    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit | NSWeekCalendarUnit fromDate:temp];
//    //
//    //////////////////////////////////////////////////////////
//    
//    NSLog(@"%ld",days.length);

    
//    NSMutableArray *views = [[NSMutableArray alloc] init];
//    double height = self.bounds.size.height,width = self.bounds.size.width;
//    double w = width/7,h = height/6;
//    for(int i=5,count=1;i>=0;i--)
//        for(int j=0;j<7;j++,count++){
//            CBDayView *day = [[CBDayView alloc] initWithFrame:CGRectMake(w*j, h*i, w, h)];
//            day.day = [NSString stringWithFormat:@"%d",count];
//            if(count == 6){
//                [day drawCirleInRect:YES color:nil];
//            }
//            if(count == 3){
//                [day drawPointInRect:YES color:nil];
//            }
//            [views addObject:day];
//        }
//    NSDictionary *date = [self getCurrentMonthDayYear];
//    
//    for(int day = 1,i=5,weekday = (int)components.weekday;day <= days.length ;i--){
//        for(;weekday <= 7;weekday++,day++){
//            CBDayView *dayView = [[CBDayView alloc] initWithFrame:CGRectMake(w*(weekday-1), h*i, w, h)];
//            dayView.day = [NSString stringWithFormat:@"%d",day];
//            if(comps.day==day){
//                [dayView drawCirleInRect:YES color:nil];
//            }
//            [views addObject:dayView];
//        }
//        weekday = 1;
//    }
    NSDictionary *currentDate = [self getCurrentMonthDayYear];
    [self updateCalendarWithMonth:[[currentDate objectForKey:@"month"] intValue] withYear:[[currentDate objectForKey:@"year"] intValue]];
}

- (void)updateCalendarWithMonth:(int)month withYear:(int)year{
    NSMutableArray *views = [[NSMutableArray alloc] init];
    double height = self.bounds.size.height,width = self.bounds.size.width;
    double w = width/7,h = height/6;
    int firstday = [self getWeekdayWithMonth:month withDay:1 withYear:year];
    int monthLength = [self getMonthLengthWithMonth:month withYear:year];
    NSDictionary *currentDate = [self getCurrentMonthDayYear];
    NSLog(@"year:%d  month:%d   firstday:%d monthLength:%d",year,month,firstday,monthLength);
    for(int day = 1,i=5,weekday = firstday;day <= monthLength ;i--){
        for(;weekday <= 7;weekday++,day++){
            CBDayView *dayView = [[CBDayView alloc] initWithFrame:CGRectMake(w*(weekday-1), h*i, w, h)];
            dayView.day = [NSString stringWithFormat:@"%d",day];
            if([[currentDate objectForKey:@"day"] intValue]==day&&year==[[currentDate objectForKey:@"year"] intValue]&&month==[[currentDate objectForKey:@"month"] intValue]){
                [dayView drawCirleInRect:YES color:nil];
            }
            [views addObject:dayView];
        }
        weekday = 1;
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
