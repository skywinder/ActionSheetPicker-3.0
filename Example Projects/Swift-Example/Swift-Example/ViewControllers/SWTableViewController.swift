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
    @IBAction func TimePickerClicked(_ sender: UIButton) {

        let datePicker = ActionSheetDatePicker(title: "Time:", datePickerMode: UIDatePickerMode.time, selectedDate: Date(), target: self, action: #selector(SWTableViewController.datePicked(_:)), origin: sender.superview!.superview)

        datePicker?.minuteInterval = 20

        datePicker?.show()

    }
    @IBOutlet var textField: UITextField!

    @IBOutlet var localePicker: UIButton!

    @IBAction func localePickerClicked(_ sender: UIButton) {
        ActionSheetLocalePicker.show(withTitle: "Locale picker", initialSelection: nil, doneBlock: {
            picker, index in

            print("index = \(index)")
            print("picker = \(picker)")
            return
            }, cancel: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)

    }

    @IBAction func DatePickerClicked(_ sender: UIButton) {

        let datePicker = ActionSheetDatePicker(title: "Date:", datePickerMode: UIDatePickerMode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in

            print("value = \(value)")
            print("index = \(index)")
            print("picker = \(picker)")
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)
        let secondsInWeek: TimeInterval = 7 * 24 * 60 * 60;
        datePicker?.minimumDate = Date(timeInterval: -secondsInWeek, since: Date())
        datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())

        datePicker?.show()
    }

    @IBAction func distancePickerClicked(_ sender: UIButton) {
        let distancePicker = ActionSheetDistancePicker(title: "Select distance", bigUnitString: "m", bigUnitMax: 2, selectedBigUnit: 1, smallUnitString: "cm", smallUnitMax: 99, selectedSmallUnit: 60, target: self, action: #selector(SWTableViewController.measurementWasSelected(_:smallUnit:element:)), origin: sender.superview!.superview)
        distancePicker?.show()
    }

    func measurementWasSelected(_ bigUnit: NSNumber, smallUnit: NSNumber, element: AnyObject) {
        print("\(element)")
        print("\(smallUnit)")
        print("\(bigUnit)")
        print("measurementWasSelected")

    }

    @IBAction func DateAndTimeClicked(_ sender: UIButton) {


        let datePicker = ActionSheetDatePicker(title: "DateAndTime:", datePickerMode: UIDatePickerMode.dateAndTime, selectedDate: Date(), doneBlock: {
            picker, value, index in

            print("value = \(value)")
            print("index = \(index)")
            print("picker = \(picker)")
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)
        let secondsInWeek: TimeInterval = 7 * 24 * 60 * 60;
        datePicker?.minimumDate = Date(timeInterval: -secondsInWeek, since: Date())
        datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())
        datePicker?.minuteInterval = 20

        datePicker?.show()
    }

    @IBAction func CountdownTimerClicked(_ sender: UIButton) {
        let datePicker = ActionSheetDatePicker(title: "CountDownTimer:", datePickerMode: UIDatePickerMode.countDownTimer, selectedDate: Date(), doneBlock: {
            picker, value, index in

            print("value = \(value)")
            print("index = \(index)")
            print("picker = \(picker)")
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)

        datePicker?.countDownDuration = 60 * 7
        datePicker?.show()
    }

    @IBAction func navigationItemPicker(_ sender: UIBarButtonItem) {
        ActionSheetStringPicker.show(withTitle: "Nav Bar From Picker", rows: ["One", "Two", "A lot"], initialSelection: 1, doneBlock: {
            picker, value, index in

            print("value = \(value)")
            print("index = \(index)")
            print("picker = \(picker)")
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender)
    }

    @IBAction func multipleStringPickerClicked(_ sender: UIButton) {
        let acp = ActionSheetMultipleStringPicker(title: "Multiple String Picker", rows: [
            ["One", "Two", "A lot"],
            ["Many", "Many more", "Infinite"]
            ], initialSelection: [2, 2], doneBlock: {
                picker, values, indexes in

                print("values = \(values)")
                print("indexes = \(indexes)")
                print("picker = \(picker)")
                return
            }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)


        acp?.pickerTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 8.0)]
        acp?.setTextColor(UIColor.red)
        acp?.pickerBackgroundColor = UIColor.black
        acp?.toolbarBackgroundColor = UIColor.yellow
        acp?.toolbarButtonsColor = UIColor.white
        acp?.show()
    }


    func datePicked(_ obj: Date) {
        UIDatePickerModeTime.setTitle(obj.description, for: UIControlState())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    @IBAction func hideKeyboard(_ sender: AnyObject) {
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
