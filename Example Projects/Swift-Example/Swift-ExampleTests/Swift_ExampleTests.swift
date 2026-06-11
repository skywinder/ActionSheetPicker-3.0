//
//  Swift_ExampleTests.swift
//  Swift-ExampleTests
//
//  Created by Petr Korolev on 19/09/14.
//  Copyright (c) 2014 Petr Korolev. All rights reserved.
//

import SnapshotTesting
import UIKit
import XCTest
import CoreActionSheetPicker

/// Snapshot tests hosted in the Swift-Example app so the sheet is captured
/// with `drawHierarchy` (true rendering: picker wheels and the iOS 26
/// Liquid Glass toolbar come out correctly, unlike layer rendering).
/// References live in `__Snapshots__/Swift_ExampleTests/`, suffixed with
/// the iOS major version, and are cropped to the opaque sheet area.
class Swift_ExampleTests: XCTestCase {

    private var osSuffix: String {
        "ios\(UIDevice.current.systemVersion.split(separator: ".").first.map(String.init) ?? "unknown")"
    }

    private func presentAndSnapshot(
        _ picker: AbstractActionSheetPicker,
        file: StaticString = #filePath,
        testName: String = #function,
        line: UInt = #line
    ) {
        picker.show()
        // Let the 0.25s slide-up animation settle before capturing.
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.8))

        guard let sheet = picker.actionSheet, let bgView = sheet.bgView else {
            XCTFail("action sheet was not presented", file: file, line: line)
            return
        }
        // True-pixel render of the sheet, cropped to the opaque content area
        // (bgView spans the toolbar + picker region).
        let image = UIGraphicsImageRenderer(bounds: bgView.frame).image { _ in
            sheet.drawHierarchy(in: sheet.bounds, afterScreenUpdates: true)
        }
        assertSnapshot(of: image, as: .image, named: osSuffix, file: file, testName: testName, line: line)

        picker.hideWithCancelAction()
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.3))
    }

    private func hostView() -> UIView {
        UIApplication.shared.delegate!.window!!.rootViewController!.view
    }

    func testStringPickerSheet() {
        let picker = ActionSheetStringPicker(
            title: "Select an Option",
            rows: ["Option A", "Option B", "Option C"],
            initialSelection: 1,
            doneBlock: nil,
            cancel: nil,
            origin: hostView()
        )!
        presentAndSnapshot(picker)
    }

    func testDatePickerSheet() {
        let picker = ActionSheetDatePicker(
            title: "Select a Date",
            datePickerMode: .date,
            selectedDate: Date(timeIntervalSince1970: 1_767_225_600), // 2026-01-01 UTC
            doneBlock: nil,
            cancel: nil,
            origin: hostView()
        )!
        picker.locale = Locale(identifier: "en_US_POSIX")
        picker.timeZone = TimeZone(identifier: "UTC")
        if #available(iOS 13.4, *) {
            picker.datePickerStyle = .wheels
        }
        presentAndSnapshot(picker)
    }
}
