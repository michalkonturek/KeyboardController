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

/**
 `KeyboardController` delegate.
 
 A `class` with ability to receive changes in keyboard status.
 */
public protocol KeyboardNotificationHandling: class {
    
    /**
     Called when keyboard was hidden.
     
     - author: Michal Konturek
     */
    func onKeyboardDidHide()
    
    /**
     Called when keyboard was shown.
     
     - author: Michal Konturek
     */
    func onKeyboardDidShow()
    
    /**
     Called when keyboard is about to be hidden.
     
     - author: Michal Konturek
     */
    func onKeyboardWillHide()
    
    /**
     Called when keyboard is about to be shown.
     
     - author: Michal Konturek
     */
    func onKeyboardWillShow()
}

/**
 A `class` that controls keyboard.
 */
public class KeyboardController: NSObject {
    
    /**
     A delegate that conforms to `KeyboardNotificationHandling` protocol.
     
     - author: Michal Konturek
     */
    public weak var delegate: KeyboardNotificationHandling?
    
    /**
     A delegate that conforms to `UITextFieldDelegate` protocol.
     
     - author: Michal Konturek
     */
    public weak var textFieldDelegate: UITextFieldDelegate?
    
    let fields: Array<UITextField>

    /**
     Instantiates `KeyboardController` object.
     
     - parameter field: an `UITextField` object.
     
     - author: Michal Konturek
     */
    convenience public init(field: UITextField) {
        self.init(fields: [field])
    }

    /**
     Instantiates `KeyboardController` object.
     
     - parameter fields: an array of `UITextField` objects.
     
     - author: Michal Konturek
     */
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
    
    /**
     Closes keyboard.
     
     - author: Michal Konturek
     */
    public func closeKeyboard() {
        for field in self.fields {
            if field.editing {
                field.resignFirstResponder()
            }
        }
    }
    
    /**
     Sets previous text field as first responder.
     
     - author: Michal Konturek
     */
    public func moveToPreviousField() {
        for index in self.fields.indices {
            if self.fields[index].editing && index != 0 {
                self.fields[index - 1].becomeFirstResponder()
                break
            }
        }
    }

    /**
     Sets next text field as first responder.
     
     - author: Michal Konturek
     */
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
    
    /**
     Called when keyboard was hidden.
     
     - author: Michal Konturek
     */
    public func onKeyboardDidHide() {
        self.delegate?.onKeyboardDidHide()
    }
    
    /**
     Called when keyboard was shown.
     
     - author: Michal Konturek
     */
    public func onKeyboardDidShow() {
        self.delegate?.onKeyboardDidShow()
    }
    
    /**
     Called when keyboard is about to be hidden.
     
     - author: Michal Konturek
     */
    public func onKeyboardWillHide() {
        self.delegate?.onKeyboardWillHide()
    }
    
    /**
     Called when keyboard is about to be shown.
     
     - author: Michal Konturek
     */
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
