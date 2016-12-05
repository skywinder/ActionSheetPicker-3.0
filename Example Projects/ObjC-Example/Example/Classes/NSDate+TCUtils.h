//
//  NSDate+TCUtils.h
//  ActionSheetPicker
//
//  Created by Tim Cinel on 2011-11-14.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(TCUtils)
- (NSDate *)TC_dateByAddingCalendarUnits:(NSCalendarUnit)calendarUnit amount:(NSInteger)amount;
@end
