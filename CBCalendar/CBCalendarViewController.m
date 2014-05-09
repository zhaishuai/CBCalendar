//
//  CBCalendarViewController.m
//  CBCalendar
//
//  Created by jimzhai on 5/9/14.
//  Copyright (c) 2014 zhaishuai. All rights reserved.
//

#import "CBCalendarViewController.h"
#import "CBMonthView.h"
#import "CBHeadView.h"
#import "CBCircle.h"
#import "CBDayView.h"
#import "CBArrow.h"

@interface CBCalendarViewController ()<dayClick,circleClick,arrowClick>

@end

@implementation CBCalendarViewController
{
    CBMonthView *monthView;
    CBHeadView *headView;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initialize];
}

- (void)initialize{
    NSMutableArray *subViews = [[NSMutableArray alloc] init];
    headView = [[CBHeadView alloc] initWithFrame:NSMakeRect(0, self.view.bounds.size.height*0.75, self.view.bounds.size.width, self.view.bounds.size.height*0.25)];
    for(id view in headView.subviews)
        [view setDelegate:self];
    monthView = [[CBMonthView alloc] initWithFrame:NSMakeRect(0, 0, self.view.bounds.size.width, self.view.bounds.size.height*0.75)];
//    for(id view in monthView.subviews)
//        [view setDelegate:self];
    NSCalendar *calendar = [[NSLocale currentLocale] objectForKey:NSLocaleCalendar];
    headView.SunDayToSatDay = [calendar shortWeekdaySymbols];
    NSDictionary *dict = [monthView currentDate];
    
    self.month = [[dict objectForKey:@"month"] intValue];
    self.year = [[dict objectForKey:@"year"] intValue];
    [self setHeadViewTitle];
    
    [subViews addObject:headView];
    [subViews addObject:monthView];
    [self.view setSubviews:subViews];
}

- (void)clickCircle{
    NSDictionary *dict = [monthView currentDate];
    self.month = [[dict objectForKey:@"month"] intValue];
    self.year = [[dict objectForKey:@"year"] intValue];
    [monthView updateCalendarWithMonth:self.month withYear:self.year];
    [self setHeadViewTitle];
}

- (void)setHeadViewTitle{
    headView.monthAndYear.stringValue = [NSString stringWithFormat:@"%@ %d",[[[NSCalendar currentCalendar] monthSymbols] objectAtIndex:self.month-1],self.year];
    for(id view in monthView.subviews)
        [view setDelegate:self];
}

- (void)clickArrow:(CBArrow *)arrow{
    if(!arrow.left){
        if(self.month<=1){
            self.month = 12;
            self.year--;
        }else{
            self.month--;
        }
        
    }else{
        if(self.month>=12){
            self.month = 1;
            self.year++;
        }else{
            self.month++;
        }
    }
    [monthView updateCalendarWithMonth:self.month withYear:self.year];
    [self setHeadViewTitle];
}

- (void)clickDay:(CBDayView *)dayView{
    NSLog(@"%d",dayView.state);
    if(dayView.state == -1){
        if(self.month<=1){
            self.month = 12;
            self.year--;
        }else{
            self.month--;
        }
        [monthView updateCalendarWithMonth:self.month withYear:self.year];
        [self setHeadViewTitle];
    }else if(dayView.state == 1){
        if(self.month>=12){
            self.month = 1;
            self.year++;
        }else{
            self.month++;
        }
        [monthView updateCalendarWithMonth:self.month withYear:self.year];
        [self setHeadViewTitle];
    }else if(dayView.state==0){
        
    }

}


@end
