//
//  KeyboardController.swift
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

public protocol KeyboardNotificationHandling: class {
    func onKeyboardDidHide()
    func onKeyboardDidShow()
    func onKeyboardWillHide()
    func onKeyboardWillShow()
}

public class KeyboardController: NSObject {
    public weak var delegate: KeyboardNotificationHandling?
    public weak var textFieldDelegate: UITextFieldDelegate?
    let fields: Array<UITextField>

    convenience public init(field: UITextField) {
        self.init(fields: [field])
    }

    public init(fields: Array<UITextField>) {
        self.fields = fields
        super.init()

        for field in self.fields {
            field.delegate = self
        }
        
        self.subscribeToNotifications()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

// MARK: Keybaord Handling
extension KeyboardController {
    
    public func closeKeyboard() {
        for field in self.fields {
            if field.editing {
                field.resignFirstResponder()
            }
        }
    }
    
    public func moveToPreviousField() {
        for index in self.fields.indices {
            if self.fields[index].editing && index != 0 {
                self.fields[index - 1].becomeFirstResponder()
                break
            }
        }
    }

    public func moveToNextField() {
        for index in self.fields.indices {
            if self.fields[index].editing && index != (self.fields.count - 1) {
                self.fields[index + 1].becomeFirstResponder()
                break
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension KeyboardController: UITextFieldDelegate {

    public func textFieldDidBeginEditing(textField: UITextField) {
        self.textFieldDelegate?.textFieldDidBeginEditing?(textField)
    }

    public func textFieldDidEndEditing(textField: UITextField) {
        self.textFieldDelegate?.textFieldDidEndEditing?(textField)
    }

    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.returnKeyType == .Next { self.moveToNextField() }
        if textField.returnKeyType == .Done { self.closeKeyboard() }
        return textField.returnKeyType == .Done
    }
}

// MARK: - KeyboardNotificationHandling
extension KeyboardController: KeyboardNotificationHandling {
    
    public func onKeyboardDidHide() {
        self.delegate?.onKeyboardDidHide()
    }
    
    public func onKeyboardDidShow() {
        self.delegate?.onKeyboardDidShow()
    }
    
    public func onKeyboardWillHide() {
        self.delegate?.onKeyboardWillHide()
    }
    
    public func onKeyboardWillShow() {
        self.delegate?.onKeyboardWillShow()
    }
    
    func subscribeToNotifications() {
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self,
                           selector: #selector(onKeyboardDidHide),
                           name: UIKeyboardDidHideNotification,
                           object: nil)
        center.addObserver(self,
                           selector: #selector(onKeyboardDidShow),
                           name: UIKeyboardDidShowNotification,
                           object: nil)
        center.addObserver(self,
                           selector: #selector(onKeyboardWillHide),
                           name: UIKeyboardWillHideNotification,
                           object: nil)
        center.addObserver(self,
                           selector: #selector(onKeyboardWillShow),
                           name: UIKeyboardWillShowNotification,
                           object: nil)
    }
}
