//
//  XCUIApplication+CJTools.swift
//  CornerJob
//
//  Created by Jesus Lopez on 29/05/2017.
//  Copyright © 2017 Clapp Studios. All rights reserved.
//

import XCTest

public enum ExpectationTimeout: TimeInterval {
    case Short = 5
    case Default = 10
    case Long = 20
}


public extension XCUIApplication {

    //MARK: Find
    func findSearchField(placeholder:String, timeout: ExpectationTimeout = .Long) -> XCUIElement {
        let context = XCTestCase()
        let searchField = XCUIApplication().searchFields.element(matching:NSPredicate(format: "placeholderValue = \"\(placeholder)\" OR identifier = \"\(placeholder)\""))
        context.waitForExist(object: searchField, timeout: timeout)
        return searchField
    }
    
    
    func findTextField(placeholder: String, timeout: ExpectationTimeout = .Default) -> XCUIElement {
        let context = XCTestCase()
        let textField = XCUIApplication().textFields.element(matching:NSPredicate(format: "placeholderValue = \"\(placeholder)\" OR identifier = \"\(placeholder)\""))
        context.waitForExist(object: textField, timeout: timeout)
        return textField
    }
    
    func findSecureTextField(placeholder: String, timeout: ExpectationTimeout = .Default) -> XCUIElement {
        let context = XCTestCase()
        let secureTextField = XCUIApplication().secureTextFields.element(matching:NSPredicate(format: "placeholderValue = \"\(placeholder)\" OR identifier = \"\(placeholder)\""))
        context.waitForExist(object: secureTextField, timeout: timeout)
        return secureTextField
    }
    
    func findButton(label: String, timeout: ExpectationTimeout = .Default, continueIfFail:Bool = false) -> XCUIElement {
        let context = XCTestCase()
        let button = XCUIApplication().buttons.element(matching:NSPredicate(format: "label = \"\(label)\" OR identifier = \"\(label)\""))
        context.waitForExist(object: button, timeout: timeout, continueIfFail: continueIfFail)
        return button
    }
    
    func findButtons(label: String) -> XCUIElementQuery {
        let buttons = XCUIApplication().buttons.matching(NSPredicate(format: "label = \"\(label)\" OR identifier = \"\(label)\""))
        return buttons
    }
    
    func findStaticText(value: String, timeout: ExpectationTimeout = .Default) -> XCUIElement {
        let context = XCTestCase()
        let staticTextElement = XCUIApplication().staticTexts[value]
        context.waitForExist(object: staticTextElement, timeout: timeout)
        return staticTextElement
    }
    
    func findFirstTableView(timeout: ExpectationTimeout = .Default) -> XCUIElement {
        let context = XCTestCase()
        let table = XCUIApplication().tables.element(boundBy: 0)
        context.waitForExist(object: table, timeout: timeout)
        return table
    }

    func findOther(identifier: String, timeout: ExpectationTimeout = .Default) -> XCUIElement {
        let context = XCTestCase()
        let otherElement = XCUIApplication().otherElements.element(matching: .other, identifier: identifier)
        context.waitForExist(object: otherElement, timeout: timeout)
        return otherElement
    }
    
    func findAlert(timeout: ExpectationTimeout = .Long) -> XCUIElement {
        let alertsElement = XCUIApplication().alerts; ///.element(matching:NSPredicate(format: "placeholderValue = \"\(placeholder)\" OR identifier = \"\(placeholder)\""))
        return alertsElement.element(boundBy: 0);
    }
    
    func findSheet(timeout: ExpectationTimeout = .Default) -> XCUIElement {
        return XCUIApplication().sheets.element(boundBy: 0);
    }

    func findImage(identifier: String, timeout: ExpectationTimeout = .Default) -> XCUIElement {
        let context = XCTestCase()
        let imageElement = XCUIApplication().images.element(matching: .image, identifier: identifier)
        context.waitForExist(object: imageElement, timeout: timeout)
        return imageElement
    }

    func findTableContainingLabel(label: String, timeout: ExpectationTimeout = .Default, index: Int? = nil) -> XCUIElement {

        let table:XCUIElement

        if let boundIndex = index {
            table = XCUIApplication().tables.staticTexts.matching(NSPredicate(format: "label CONTAINS '\(label)'")).element(boundBy: boundIndex)
        } else {
            table = XCUIApplication().tables.staticTexts.matching(NSPredicate(format: "label CONTAINS '\(label)'")).element(boundBy: 0)
        }

        return table
    }
    
    func findTableview(identifier: String, timeout: ExpectationTimeout = .Default, continueIfFail:Bool = false) -> XCUIElement {
        let context = XCTestCase()
        let tableview = XCUIApplication().tables.element(matching: .table, identifier: identifier)
        context.waitForExist(object: tableview, timeout: timeout, continueIfFail: continueIfFail)
        return tableview
    }
    
    func findTextView(placeholder: String, timeout: ExpectationTimeout = .Default) -> XCUIElement {
        let context = XCTestCase()
        let textView = XCUIApplication().textViews.element(matching:NSPredicate(format: "placeholderValue = \"\(placeholder)\" OR identifier = \"\(placeholder)\""))
        context.waitForExist(object: textView, timeout: timeout)
        return textView
    }
    
    func findCellWithIndex (index:Int, timeout: ExpectationTimeout = .Default, continueIfFail:Bool = false) -> XCUIElement {
        let context = XCTestCase()
        let cellview = XCUIApplication().cells.element(boundBy: index)
        context.waitForExist(object: cellview, timeout: timeout, continueIfFail: continueIfFail)
        return cellview
    }

    //MARK: Typing
    
    func typeSearchField(placeholder:String, value:String, clear:Bool = true, timeout: ExpectationTimeout = .Default) {
        let searchField = findSearchField(placeholder: placeholder, timeout: timeout)
        searchField.tap()
        if (clear) {
            clearTextSearch(searchField: searchField)
        }
        searchField.typeText(value)
    }
    
    
    func typeTextField(placeholder:String, value:String, timeout: ExpectationTimeout = .Default) {
        let textField = findTextField(placeholder: placeholder, timeout: timeout)
        textField.tap()
        textField.typeText(value)
    }
    
    func typeSecureTextField(placeholder: String, value: String, timeout: ExpectationTimeout = .Default) {
        let secureTextField = findSecureTextField(placeholder: placeholder, timeout: timeout)
        secureTextField.tap()
        secureTextField.typeText(value)
    }
    
    func typeTextView(placeholder:String, value:String, timeout: ExpectationTimeout = .Default) {
        let textView = findTextView(placeholder: placeholder, timeout: timeout)
        textView.tap()
        textView.typeText(value)
    }
    
    func tapButton(label: String, timeout: ExpectationTimeout = .Default) {
        let button = findButton(label: label, timeout: timeout)
        button.tap()
    }
    
    func tapButtonWithIndex(label:String, index:Int) {
        let buttons = findButtons(label: label)
        buttons.element(boundBy: index).tap()
    }
    
    func tapNavigationBackButton() {
        XCUIApplication().navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    func tapCellWithIndex (index:Int) {
        XCUIApplication().cells.element(boundBy: index).tap()
    }

    func isButtonWithIndexEnabled (label:String, index:Int) -> Bool {
        let buttons = findButtons(label: label)
        return buttons.element(boundBy: index).isEnabled
    }
    
    func typeKeyboardIntro() {
        XCUIApplication().keyboards.buttons["Return"].tap()
    }
    
    func typeKeyboardNext() {
        XCUIApplication().keyboards.buttons["Next"].tap()
    }
    
    func typeKeyboardSearch() {
        XCUIApplication().keyboards.buttons["Search"].tap()
    }
    
    func clearTextSearch(searchField:XCUIElement) {
        while (searchField.value as! String).count != 0 {
            XCUIApplication().keyboards.keys["delete"].tap()
        }
    }
    
    //Mark: Alerts
    
    func tapAlertOption(value: String, timeout: ExpectationTimeout = .Default) {
        let alert = findAlert()
        alert.buttons[value].tap()
    }

    // MARK: - Sheets
    func tapSheetOption(index: Int, timeout: ExpectationTimeout = .Default) {
        findSheet().buttons.element(boundBy: index).tap()
    }

    func tapSheetOption(label: String, timeout: ExpectationTimeout = .Default) {
        findSheet().buttons[label].tap()
    }
    
    // MARK: - UIPopover
    func dismissPopoverController() {
        children(matching: .window).element(boundBy: 0).tap()
    }

}
