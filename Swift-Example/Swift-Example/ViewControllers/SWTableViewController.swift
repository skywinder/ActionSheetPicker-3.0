//
//  SWTableViewController.swift
//  Swift-Example
//
//  Created by Petr Korolev on 19/09/14.
//  Copyright (c) 2014 Petr Korolev. All rights reserved.
//

import UIKit
import CoreActionSheetPicker

class SWTableViewController: UITableViewController, UITableViewDelegate {
    @IBOutlet var UIDatePickerModeTime: UIButton!
    @IBAction func TimePickerClicked(sender: UIButton) {

        var datePicker = ActionSheetDatePicker(title: "Time:", datePickerMode: UIDatePickerMode.Time, selectedDate: NSDate(), target: self, action: "datePicked:", origin: sender.superview!.superview)

        datePicker.minuteInterval = 20
        datePicker.showActionSheetPicker()

    }

    @IBAction func DatePickerClicked(sender: UIButton) {

        var datePicker = ActionSheetDatePicker(title: "Date:", datePickerMode: UIDatePickerMode.Date, selectedDate: NSDate(), doneBlock: {
            picker, value, index in

            println("value = \(value)")
            println("index = \(index)")
            println("picker = \(picker)")
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
        println("\(element)")
        println("\(smallUnit)")
        println("\(bigUnit)")
        println("measurementWasSelected")

    }

    @IBAction func DateAndTimeClicked(sender: UIButton) {


        var datePicker = ActionSheetDatePicker(title: "DateAndTime:", datePickerMode: UIDatePickerMode.DateAndTime, selectedDate: NSDate(), doneBlock: {
            picker, value, index in

            println("value = \(value)")
            println("index = \(index)")
            println("picker = \(picker)")
            return
        }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)
        let secondsInWeek: NSTimeInterval = 7 * 24 * 60 * 60;
        datePicker.minimumDate = NSDate(timeInterval: -secondsInWeek, sinceDate: NSDate())
        datePicker.maximumDate = NSDate(timeInterval: secondsInWeek, sinceDate: NSDate())
        datePicker.minuteInterval = 20

        datePicker.showActionSheetPicker()
    }

    @IBAction func CountdownTimerClicked(sender: UIButton) {
        var datePicker = ActionSheetDatePicker(title: "CountDownTimer:", datePickerMode: UIDatePickerMode.CountDownTimer, selectedDate: NSDate(), doneBlock: {
            picker, value, index in

            println("value = \(value)")
            println("index = \(index)")
            println("picker = \(picker)")
            return
        }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)

        datePicker.countDownDuration = 60 * 7
        datePicker.showActionSheetPicker()
    }

    @IBAction func navigationItemPicker(sender: UIBarButtonItem) {
        ActionSheetStringPicker.showPickerWithTitle("Nav Bar From Picker", rows: ["One", "Two", "A lot"], initialSelection: 1, doneBlock: {
            picker, value, index in

            println("value = \(value)")
            println("index = \(index)")
            println("picker = \(picker)")
            return
        }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
    }

    @IBAction func localePickerClicked(sender: UIButton) {
        ActionSheetLocalePicker.showPickerWithTitle("Locale picker", initialSelection: NSTimeZone(), doneBlock: {
            picker, index in

            println("index = \(index)")
            println("picker = \(picker)")
            return
        }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)

    }
    @IBOutlet var localePicker: UIButton!

    func datePicked(obj: NSDate) {
        UIDatePickerModeTime.setTitle(obj.description, forState: UIControlState.Normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
