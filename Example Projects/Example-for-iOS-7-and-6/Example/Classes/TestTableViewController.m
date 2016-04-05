//
// Created by Petr Korolev on 24/07/14.
//

#import "TestTableViewController.h"
#import "ActionSheetStringPicker.h"
#import "ActionSheetDatePicker.h"


@implementation TestTableViewController
{

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if ([self.tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)])
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellId"
                                                    forIndexPath:indexPath];
    else
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellId"];

    cell.textLabel.text = @(indexPath.row).stringValue;
    cell.detailTextLabel.text = @"Choose me!";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel * sender = cell.detailTextLabel;
//    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
//        if ([sender respondsToSelector:@selector(setText:)]) {
//            [sender performSelector:@selector(setText:) withObject:selectedValue];
//        }
//    };
//    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
//        NSLog(@"Block Picker Canceled");
//    };
//    NSArray *colors = @[@"Red", @"Green", @"Blue", @"Orange"];
//    [ActionSheetStringPicker showPickerWithTitle:@"Select a Block" rows:colors initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Select a time" datePickerMode:UIDatePickerModeTime selectedDate:[NSDate date] target:self action:@selector(timeWasSelected:element:) origin:sender];
    datePicker.minuteInterval = 5;
    [datePicker showActionSheetPicker];
}

-(void)timeWasSelected:(NSDate *)selectedTime element:(id)element {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm a"];
    [element setText:[dateFormatter stringFromDate:selectedTime]];
}



@end