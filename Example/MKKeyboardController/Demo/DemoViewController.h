//
//  DemoViewController.h
//  MKKeyboardController
//
//  Created by Michal Konturek on 12/01/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MKKeyboardController.h"

@interface DemoViewController : UIViewController<
MKKeyboardControllerDelegate,
UITextFieldDelegate
>

@property (nonatomic, strong) IBOutlet UITextField *textField1;
@property (nonatomic, strong) IBOutlet UITextField *textField2;
@property (nonatomic, strong) IBOutlet UITextField *textField3;
@property (nonatomic, strong) IBOutlet UITextField *textField4;
@property (nonatomic, strong) IBOutlet UITextField *textField5;

@end
