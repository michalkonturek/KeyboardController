//
//  DemoViewController.m
//  MKKeyboardController
//
//  Created by Michal Konturek on 12/01/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()

@property (nonatomic, strong) KeyboardController *keyboardController;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setupTextFields];
}

- (void)_setupTextFields {
    id fields = @[_field1, _field2, _field3, _field4, _field5];
    self.keyboardController = [KeyboardController controllerWithFields:fields];
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
    if (textField == self.field4) [self _moveViewByY:-50];
    if (textField == self.field5) [self _moveViewByY:-200];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.field4) [self _moveViewByY:50];
    if (textField == self.field5) [self _moveViewByY:200];
}


#pragma mark - KeyboardControllerDelegate Methods

- (void)controllerDidHideKeyboard:(KeyboardController *)controller {
    
}

- (void)controllerDidShowKeyboard:(KeyboardController *)controller {
    
}

- (void)controllerWillHideKeyboard:(KeyboardController *)controller {
    [self _moveViewByY:[self keyboardShiftValue]];
}

- (void)controllerWillShowKeyboard:(KeyboardController *)controller {
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
