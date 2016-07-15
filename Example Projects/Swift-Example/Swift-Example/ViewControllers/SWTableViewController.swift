//
//  SWTableViewController.swift
//  Swift-Example
//
//  Created by Petr Korolev on 19/09/14.
//  Copyright (c) 2014 Petr Korolev. All rights reserved.
//

import UIKit
import CoreActionSheetPicker

class SWTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet var UIDatePickerModeTime: UIButton!
    @IBAction func TimePickerClicked(sender: UIButton) {

        let datePicker = ActionSheetDatePicker(title: "Time:", datePickerMode: UIDatePickerMode.Time, selectedDate: NSDate(), target: self, action: "datePicked:", origin: sender.superview!.superview)

        datePicker.minuteInterval = 20

        datePicker.showActionSheetPicker()

    }
    @IBOutlet var textField: UITextField!

    @IBOutlet var localePicker: UIButton!

    @IBAction func localePickerClicked(sender: UIButton) {
        ActionSheetLocalePicker.showPickerWithTitle("Locale picker", initialSelection: NSTimeZone(), doneBlock: {
            picker, index in

            print("index = \(index)")
            print("picker = \(picker)")
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)

    }

    @IBAction func DatePickerClicked(sender: UIButton) {

        let datePicker = ActionSheetDatePicker(title: "Date:", datePickerMode: UIDatePickerMode.Date, selectedDate: NSDate(), doneBlock: {
            picker, value, index in

            print("value = \(value)")
            print("index = \(index)")
            print("picker = \(picker)")
            return
        }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)
        let secondsInWeek: NSTimeInterval = 7 * 24 * 60 * 60;
        datePicker.minimumDate = NSDate(timeInterval: -secondsInWeek, sinceDate: NSDate())
        datePicker.maximumDate = NSDate(timeInterval: secondsInWeek, sinceDate: NSDate())

        datePicker.showActionSheetPicker()
    }

    @IBAction func distancePickerClicked(sender: UIButton) {
        let distancePicker = ActionSheetDistancePicker(title: "Select distance", bigUnitString: "m", bigUnitMax: 2, selectedBigUnit: 1, smallUnitString: "cm", smallUnitMax: 99, selectedSmallUnit: 60, target: self, action: Selector("measurementWasSelected:smallUnit:element:"), origin: sender.superview!.superview)
        distancePicker.showActionSheetPicker()
    }

    func measurementWasSelected(bigUnit: NSNumber, smallUnit: NSNumber, element: AnyObject) {
        print("\(element)")
        print("\(smallUnit)")
        print("\(bigUnit)")
        print("measurementWasSelected")

    }

    @IBAction func DateAndTimeClicked(sender: UIButton) {


        let datePicker = ActionSheetDatePicker(title: "DateAndTime:", datePickerMode: UIDatePickerMode.DateAndTime, selectedDate: NSDate(), doneBlock: {
            picker, value, index in

            print("value = \(value)")
            print("index = \(index)")
            print("picker = \(picker)")
            return
        }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)
        let secondsInWeek: NSTimeInterval = 7 * 24 * 60 * 60;
        datePicker.minimumDate = NSDate(timeInterval: -secondsInWeek, sinceDate: NSDate())
        datePicker.maximumDate = NSDate(timeInterval: secondsInWeek, sinceDate: NSDate())
        datePicker.minuteInterval = 20

        datePicker.showActionSheetPicker()
    }

    @IBAction func CountdownTimerClicked(sender: UIButton) {
        let datePicker = ActionSheetDatePicker(title: "CountDownTimer:", datePickerMode: UIDatePickerMode.CountDownTimer, selectedDate: NSDate(), doneBlock: {
            picker, value, index in

            print("value = \(value)")
            print("index = \(index)")
            print("picker = \(picker)")
            return
        }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)

        datePicker.countDownDuration = 60 * 7
        datePicker.showActionSheetPicker()
    }

    @IBAction func navigationItemPicker(sender: UIBarButtonItem) {
        ActionSheetStringPicker.showPickerWithTitle("Nav Bar From Picker", rows: ["One", "Two", "A lot"], initialSelection: 1, doneBlock: {
            picker, value, index in

            print("value = \(value)")
            print("index = \(index)")
            print("picker = \(picker)")
            return
        }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
    }

    @IBAction func multipleStringPickerClicked(sender: UIButton) {
        let acp = ActionSheetMultipleStringPicker(title: "Multiple String Picker", rows: [
            ["One", "Two", "A lot"],
            ["Many", "Many more", "Infinite"]
            ], initialSelection: [2, 2], doneBlock: {
                picker, values, indexes in

                print("values = \(values)")
                print("indexes = \(indexes)")
                print("picker = \(picker)")
                return
            }, cancelBlock: { ActionMultipleStringCancelBlock in return }, origin: sender)


        acp.setTextColor(UIColor.redColor())
        acp.pickerBackgroundColor = UIColor.blackColor()
        acp.toolbarBackgroundColor = UIColor.yellowColor()
        acp.toolbarButtonsColor = UIColor.whiteColor()
        acp.showActionSheetPicker()
    }


    func datePicked(obj: NSDate) {
        UIDatePickerModeTime.setTitle(obj.description, forState: UIControlState.Normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }

    @IBAction func hideKeyboard(sender: AnyObject) {
        self.textField.becomeFirstResponder()
    }
    // MARK: - Table view data source

    /*
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
