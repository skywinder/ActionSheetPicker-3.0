//
//  NSDate+TCUtils.m
//  ActionSheetPicker
//
//  Created by Tim Cinel on 2011-11-14.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSDate+TCUtils.h"

@implementation NSDate (TCUtils)

- (NSDate *)TC_dateByAddingCalendarUnits:(NSCalendarUnit)calendarUnit amount:(NSInteger)amount {
	NSDateComponents *components = [[NSDateComponents alloc] init];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDate *newDate;
	
	switch (calendarUnit) {
		case NSSecondCalendarUnit:
			[components setSecond:amount];
			break;
		case NSMinuteCalendarUnit:
			[components setMinute:amount];
			break;
		case NSHourCalendarUnit:
			[components setHour:amount];
			break;
		case NSDayCalendarUnit:
			[components setDay:amount];
			break;
		case NSWeekCalendarUnit:
			[components setWeek:amount];
			break;
		case NSMonthCalendarUnit:
			[components setMonth:amount];
			break;
		case NSYearCalendarUnit:
			[components setYear:amount];
			break;
		default:
			NSLog(@"addCalendar does not support that calendarUnit!");
			break;
	}
	
	newDate = [gregorian dateByAddingComponents:components toDate:self options:0];
	return newDate;
}

@end
