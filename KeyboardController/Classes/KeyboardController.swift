//
//  KeyboardController.swift
//  KeyboardController
//
//  Created by Michal Konturek on 04/08/2016.
//
//

import UIKit

public protocol KeyboardControllerDelegate: class {
    func controllerDidHideKeyboard(controller: KeyboardController)
    func controllerDidShowKeyboard(controller: KeyboardController)
    func controllerWillHideKeyboard(controller: KeyboardController)
    func controllerWillShowKeyboard(controller: KeyboardController)
}

public class KeyboardController: NSObject {
    public weak var delegate: KeyboardControllerDelegate?
    public weak var textFieldDelegate: UITextFieldDelegate?
    let fields: Array<UITextField>
    
    convenience public init(field field: UITextField) {
        self.init(fields: [field])
    }
    
    public init(fields fields: Array<UITextField>) {
        self.fields = fields
        super.init()
        
        for field in self.fields {
            field.delegate = self
        }
    }
    
    public func closeKeyboard() {
        for field in self.fields {
            if field.editing {
                field.resignFirstResponder()
            }
        }
    }
}

extension KeyboardController {
    
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
