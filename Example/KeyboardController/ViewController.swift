//
//  ViewController.swift
//  KeyboardController
//
//  Created by Michal Konturek on 08/04/2016.
//  Copyright (c) 2016 Michal Konturek. All rights reserved.
//

import UIKit

import KeyboardController

class ViewController: UIViewController {
    @IBOutlet weak var field1: UITextField?
    @IBOutlet weak var field2: UITextField?
    @IBOutlet weak var field3: UITextField?
    @IBOutlet weak var field4: UITextField?
    @IBOutlet weak var field5: UITextField?
    
    var controller: KeyboardController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fields = [field1!, field2!, field3!, field4!, field5!]
        self.controller = KeyboardController(fields: fields)
        self.controller?.delegate = self
        self.controller?.textFieldDelegate = self
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == self.field4) { self.moveViewBy(-10) }
        if (textField == self.field5) { self.moveViewBy(-200) }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == self.field4) { self.moveViewBy(10) }
        if (textField == self.field5) { self.moveViewBy(200) }
    }
    
    func moveViewBy(_ dy: CGFloat) {
        UIView.animate(withDuration: 0.2, animations: { 
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: dy)
        }) 
    }
}

extension ViewController: KeyboardNotificationHandling {
    
    func onKeyboardDidHide() {
        print("\(#function)")
    }
    
    func onKeyboardDidShow() {
        print("\(#function)")
    }
    
    func onKeyboardWillHide() {
        print("\(#function)")
    }
    
    func onKeyboardWillShow() {
        print("\(#function)")
    }
}
