//
//  DemoViewController.m
//  MKKeyboardController
//
//  Created by Michal Konturek on 12/01/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()

@property (nonatomic, strong) MKKeyboardController *keyboardController;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setupTextFields];
}

- (void)_setupTextFields {
    id textFields = @[_textField1, _textField2, _textField3, _textField4, _textField5];
    self.keyboardController = [MKKeyboardController controllerWithTextFields:textFields];
    self.keyboardController.delegate = self;
    self.keyboardController.textFieldDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGFloat)keyboardShiftValue {
    return 0;
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.textField4) [self _moveViewByY:-50];
    if (textField == self.textField5) [self _moveViewByY:-200];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.textField4) [self _moveViewByY:50];
    if (textField == self.textField5) [self _moveViewByY:200];
}


#pragma mark - KeyboardControllerDelegate Methods

- (void)controllerDidHideKeyboard:(MKKeyboardController *)controller {
    
}

- (void)controllerDidShowKeyboard:(MKKeyboardController *)controller {
    
}

- (void)controllerWillHideKeyboard:(MKKeyboardController *)controller {
    [self _moveViewByY:[self keyboardShiftValue]];
}

- (void)controllerWillShowKeyboard:(MKKeyboardController *)controller {
    [self _moveViewByY:-[self keyboardShiftValue]];
}

- (void)_moveViewByY:(CGFloat)dy {
    NSTimeInterval animationDuration = 0.2f;
    [self _moveView:self.view byY:dy withAnimationDuration:animationDuration];
}

- (void)_moveView:(UIView *)view byY:(CGFloat)dy withAnimationDuration:(NSTimeInterval)duration {
    __block UIView *blockSafeView = view;
    [UIView animateWithDuration:duration animations:^(void){
        blockSafeView.frame = CGRectOffset(blockSafeView.frame, 0, dy);
    }];
}




@end
