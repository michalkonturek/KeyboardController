//
//  KeyboardControllerTests.swift
//  KeyboardController
//
//  Copyright (c) 2016 Michal Konturek <michal.konturek@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//


import UIKit
import XCTest

@testable import KeyboardController

class KeyboardControllerTests: XCTestCase {
    var sut: KeyboardController!
    
    let fakeCenter: FakeNotificationCenter = FakeNotificationCenter()
    let mockTextField1: MockTextField = MockTextField()
    let mockTextField2: MockTextField = MockTextField()
    var mockFields: Array<MockTextField> = []
    
    override func setUp() {
        super.setUp()
        
        self.mockFields = [mockTextField1, mockTextField2]
        self.sut = KeyboardController(fields: self.mockFields,
                                      notificationCenter: self.fakeCenter)
    }
    
    func test_init() {
    
        // then
        XCTAssertTrue(self.sut.fields == self.mockFields)
        XCTAssertTrue(self.sut.notificationCenter === self.fakeCenter)
        XCTAssertTrue(self.mockTextField1.delegate === self.sut)
        XCTAssertTrue(self.mockTextField2.delegate === self.sut)
        
        self.assertRegisteredObserver(self.fakeCenter.registeredObservers[0],
                                      observer: self.sut,
                                      name: UIKeyboardDidHideNotification,
                                      object: nil)
        self.assertRegisteredObserver(self.fakeCenter.registeredObservers[1],
                                      observer: self.sut,
                                      name: UIKeyboardDidShowNotification,
                                      object: nil)
        self.assertRegisteredObserver(self.fakeCenter.registeredObservers[2],
                                      observer: self.sut,
                                      name: UIKeyboardWillHideNotification,
                                      object: nil)
        self.assertRegisteredObserver(self.fakeCenter.registeredObservers[3],
                                      observer: self.sut,
                                      name: UIKeyboardWillShowNotification,
                                      object: nil)
    }
    
    func assertRegisteredObserver(registered: TestRegisteredObserver,
                                    observer: AnyObject,
                                    name: String?,
                                    object: AnyObject?) {
        XCTAssertTrue(registered.observer === observer)
        XCTAssertTrue(registered.name == name)
        XCTAssertTrue(registered.object === object)
    }
    
    func test_closeKeyboard() {
        
        // given
        self.mockTextField1.editing = false
        self.mockTextField2.editing = true
        
        // when
        self.sut.closeKeyboard()
        
        // then
        XCTAssertFalse(self.mockTextField1.didResignFirstResponder)
        XCTAssertTrue(self.mockTextField2.didResignFirstResponder)
    }
    
    func test_moveToPreviousField() {
        
        // given
        self.mockTextField1.editing = false
        self.mockTextField2.editing = true
        
        // when
        self.sut.moveToPreviousField()
        
        // then
        XCTAssertTrue(self.mockTextField1.didBecomeFirstResponder)
        XCTAssertFalse(self.mockTextField2.didBecomeFirstResponder)
    }
    
    func test_moveToPreviousField_doesNot() {
        
        // given
        self.mockTextField1.editing = true
        self.mockTextField2.editing = false
        
        // when
        self.sut.moveToPreviousField()
        
        // then
        XCTAssertFalse(self.mockTextField1.didBecomeFirstResponder)
        XCTAssertFalse(self.mockTextField2.didBecomeFirstResponder)
    }
    
}

class MockTextField: UITextField {
    internal var mockEditing: Bool = false
    internal var didResignFirstResponder: Bool = false
    internal var didBecomeFirstResponder: Bool = false
    
    override internal var editing: Bool {
        get {
            return mockEditing
        }
        set {
            mockEditing = newValue
        }
    }
    
    override func resignFirstResponder() -> Bool {
        self.didResignFirstResponder = true
        return true
    }
    
    override func becomeFirstResponder() -> Bool {
        self.didBecomeFirstResponder = true
        return true
    }
}

class FakeNotificationCenter: NSNotificationCenter {
    internal var registeredObservers: Array<TestRegisteredObserver> = []
    
    override init () {}
    
    override func addObserver(observer: AnyObject, selector aSelector: Selector, name aName: String?, object anObject: AnyObject?) {
        
        let item = TestRegisteredObserver()
        item.observer = observer
        item.selector = aSelector
        item.name = aName
        item.object = anObject
        self.registeredObservers.append(item)
    }
    
//    override func postNotificationName(aName: String, object anObject: AnyObject?) {
//        self.observer.performSelector(self.selector)
//    }
}

class TestRegisteredObserver {
    internal var observer: AnyObject!
    internal var object: AnyObject?
    internal var selector: Selector!
    internal var name: String?
}
