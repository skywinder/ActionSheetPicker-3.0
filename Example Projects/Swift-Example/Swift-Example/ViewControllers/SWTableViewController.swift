//
//  SWTableViewController.swift
//  Swift-Example
//
//  Created by Petr Korolev on 19/09/14.
//  Copyright (c) 2014 Petr Korolev. All rights reserved.
//

import CoreActionSheetPicker
import UIKit

class SWTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet var textField: UITextField!

    @IBAction func navigationBarItemPicker(_ sender: UIBarButtonItem) {
        // example of string picker with done and cancel blocks
        ActionSheetStringPicker.show(withTitle: "Picker from navigation bar",
                                     rows: ["One", "Two", "A lot"],
                                     initialSelection: 1,
                                     doneBlock: { picker, value, index in
                                         print("picker = \(String(describing: picker))")
                                         print("value = \(value)")
                                         print("index = \(String(describing: index))")
                                         return
                                     },
                                     cancel: { _ in
                                     },
                                     origin: sender)
    }

    @IBAction func localePickerClicked(_ sender: UIButton) {
        // example of date picker initialized with done and cancel blocks (origin in this case is tableview cell whose contentView has UIButton for picker)
        ActionSheetLocalePicker.show(withTitle: "Locale picker",
                                     initialSelection: nil,
                                     doneBlock: { picker, timezone in
                                         print("picker = \(String(describing: picker))")
                                         print("timezone = \(String(describing: timezone))")
                                         return
                                     },
                                     cancel: { _ in
                                     },
                                     origin: sender.superview!.superview)
    }

    @IBAction func timePickerClicked(_ sender: UIButton) {
        // example of picker initialized with target/action parameters
        let datePicker = ActionSheetDatePicker(
            title: "Time - (Automatic):",
            datePickerMode: ActionSheetDatePickerModeTime,
            selectedDate: Date(),
            doneBlock: { _, selectedDate, _ in
                print("DONE: Date picked \(selectedDate ?? "NO DATE")")
            },
            cancel: { _ in
                print("CANCELLED")
            },
            origin: sender.superview!.superview)
        datePicker?.minuteInterval = 20
        if #available(iOS 13.4, *) {
            datePicker?.datePickerStyle = .automatic
        }
        datePicker?.tapDismissAction = .cancel
        datePicker?.show()
    }

    @IBAction func datePickerClicked(_ sender: UIButton) {
        // example of date picker with min and max values set (as a week in past and week in future from today)
        let datePicker = ActionSheetDatePicker(title: "Date within 2 weeks - (Inline):",
                                               datePickerMode: ActionSheetDatePickerModeDate,
                                               selectedDate: Date(),
                                               doneBlock: { picker, date, origin in
                                                   print("picker = \(String(describing: picker))")
                                                   print("date = \(String(describing: date))")
                                                   print("origin = \(String(describing: origin))")
                                                   return
                                               },
                                               cancel: { _ in
                                               },
                                               origin: sender.superview!.superview)
        let secondsInWeek: TimeInterval = 7 * 24 * 60 * 60
        datePicker?.minimumDate = Date(timeInterval: -secondsInWeek, since: Date())
        datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())
        if #available(iOS 14.0, *) {
            datePicker?.datePickerStyle = .inline
        }

        datePicker?.show()
    }

    @IBAction func dateAndTimePickerClicked(_ sender: UIButton) {
        // example of datetime picker with step interval set to 20 min
        let datePicker = ActionSheetDatePicker(title: "DateTime with 20min intervals - (Automatic):",
                                               datePickerMode: ActionSheetDatePickerModeDateAndTime,
                                               selectedDate: Date(),
                                               doneBlock: { picker, date, origin in
                                                   print("picker = \(String(describing: picker))")
                                                   print("date = \(String(describing: date))")
                                                   print("origin = \(String(describing: origin))")
                                                   return
                                               },
                                               cancel: { _ in
                                               },
                                               origin: sender.superview!.superview)
        datePicker?.minuteInterval = 20
        if #available(iOS 13.4, *) {
            datePicker?.datePickerStyle = .automatic
        }

        datePicker?.show()
    }

    @IBAction func countdownPickerClicked(_ sender: UIButton) {
        // example of countdown time picker with default countdown value set
        let datePicker = ActionSheetDatePicker(title: "CountDownTimer:",
                                               datePickerMode: ActionSheetDatePickerModeCountDownTimer,
                                               selectedDate: nil,
                                               doneBlock: { picker, duration, origin in
                                                   print("picker = \(String(describing: picker))")
                                                   print("duration = \(String(describing: duration))")
                                                   print("origin = \(String(describing: origin))")
                                                   return
                                               },
                                               cancel: { _ in
                                               },
                                               origin: sender)

        datePicker?.countDownDuration = 60 * 7
        datePicker?.show()
    }

    @IBAction func monthAndYearPickerClicked(_ sender: UIButton) {
        // example of date picker with min and max values set (as a week in past and week in future from today)
        let datePicker = ActionSheetDatePicker(title: "MonthAndYear:",
                                               datePickerMode: ActionSheetDatePickerModeMonthAndYear,
                                               selectedDate: Date(),
                                               doneBlock: { picker, date, origin in
                                                   print("picker = \(String(describing: picker))")
                                                   print("date = \(String(describing: date))")
                                                   print("origin = \(String(describing: origin))")
                                                   return
                                               },
                                               cancel: { _ in
                                               },
                                               origin: sender.superview!.superview)
        datePicker?.show()
    }

    @IBAction func yearPickerClicked(_ sender: UIButton) {
        // example of date picker with min and max values set (as a week in past and week in future from today)
        let datePicker = ActionSheetDatePicker(title: "Year:",
                                               datePickerMode: ActionSheetDatePickerModeYear,
                                               selectedDate: Date(),
                                               doneBlock: { picker, date, origin in
                                                   print("picker = \(String(describing: picker))")
                                                   print("date = \(String(describing: date))")
                                                   print("origin = \(String(describing: origin))")
                                                   return
                                               },
                                               cancel: { _ in
                                               },
                                               origin: sender.superview!.superview)
        datePicker?.show()
    }

    @IBAction func distancePickerClicked(_ sender: UIButton) {
        // example of distance picker with target/action selector
        let distancePicker = ActionSheetDistancePicker(title: "Select distance",
                                                       bigUnitString: "m",
                                                       bigUnitMax: 2,
                                                       selectedBigUnit: 1,
                                                       smallUnitString: "cm",
                                                       smallUnitMax: 99,
                                                       selectedSmallUnit: 60,
                                                       target: self,
                                                       action: #selector(self.measurementWasSelected(_:smallUnit:origin:)),
                                                       origin: sender.superview!.superview)
        distancePicker?.show()
    }

    @objc func measurementWasSelected(_ bigUnit: NSNumber, smallUnit: NSNumber, origin: AnyObject) {
        print("measurementWasSelected")
        print("bigUnits = \(bigUnit)")
        print("smallUnits = \(smallUnit)")
        print("origin = \(origin)")
    }

    @IBAction func multipleStringPickerClicked(_ sender: UIButton) {
        // example of multicolumn string picker with custom colors and custom Done button
        let acp = ActionSheetMultipleStringPicker(title: "Multiple String Picker",
                                                  rows: [["One", "Two", "A lot"],
                                                         ["Many", "Many more", "Infinite"]],
                                                  initialSelection: [2, 2],
                                                  doneBlock: { picker, indexes, values in
                                                      print("picker = \(String(describing: picker))")
                                                      print("indexes = \(String(describing: indexes))")
                                                      print("values = \(String(describing: values))")
                                                      return
                                                  },
                                                  cancel: { _ in
                                                  },
                                                  origin: sender)
        // customize appearance of the picker
        acp?.pickerTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0)]
        acp?.setTextColor(UIColor.red)
        acp?.pickerBackgroundColor = UIColor.black
        acp?.toolbarBackgroundColor = UIColor.yellow
        acp?.toolbarButtonsColor = UIColor.white
        // custom done button
        let okButton = UIButton()
        okButton.setTitle("OK", for: .normal)
        let customDoneButton = UIBarButtonItem(customView: okButton)
        acp?.setDoneButton(customDoneButton)
        acp?.show()
    }

    @IBAction func showKeyboard(_ sender: AnyObject) {
        self.textField.becomeFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
