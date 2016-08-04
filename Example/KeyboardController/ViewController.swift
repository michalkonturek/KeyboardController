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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField == self.field4) { self.moveViewBy(-10) }
        if (textField == self.field5) { self.moveViewBy(-200) }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (textField == self.field4) { self.moveViewBy(10) }
        if (textField == self.field5) { self.moveViewBy(200) }
    }
    
    func moveViewBy(dy: CGFloat) {
        UIView.animateWithDuration(0.2) { 
            self.view.frame = CGRectOffset(self.view.frame, 0, dy)
        }
    }
}

extension ViewController: KeyboardControllerDelegate {
    
    func controllerDidHideKeyboard(controller: KeyboardController) {
        
    }
    
    func controllerDidShowKeyboard(controller: KeyboardController) {
        
    }
    
    func controllerWillHideKeyboard(controller: KeyboardController) {
        
    }
    
    func controllerWillShowKeyboard(controller: KeyboardController) {
        
    }
}
