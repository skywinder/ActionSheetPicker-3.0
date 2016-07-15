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
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDate *newDate;
	
	switch (calendarUnit) {
		case NSCalendarUnitSecond:
			[components setSecond:amount];
			break;
		case NSCalendarUnitMinute:
			[components setMinute:amount];
			break;
		case NSCalendarUnitHour:
			[components setHour:amount];
			break;
		case NSCalendarUnitDay:
			[components setDay:amount];
			break;
		case NSCalendarUnitWeekOfYear:
			[components setWeekOfYear:amount];
			break;
		case NSCalendarUnitMonth:
			[components setMonth:amount];
			break;
		case NSCalendarUnitYear:
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
