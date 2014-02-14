//
//  DemoViewController.h
//  MKKeyboardController
//
//  Created by Michal Konturek on 12/01/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KeyboardController.h"

@interface DemoViewController : UIViewController<
KeyboardControllerDelegate,
UITextFieldDelegate
>

@property (nonatomic, strong) IBOutlet UITextField *field1;
@property (nonatomic, strong) IBOutlet UITextField *field2;
@property (nonatomic, strong) IBOutlet UITextField *field3;
@property (nonatomic, strong) IBOutlet UITextField *field4;
@property (nonatomic, strong) IBOutlet UITextField *field5;

@end
