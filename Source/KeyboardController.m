//
//  KeyboardController.m
//  KeyboardController
//
//  Created by Michal Konturek on 11/01/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "KeyboardController.h"

@implementation KeyboardController

+ (id)controllerWithTextField:(UITextField *)textField {
    return [[self alloc] initWithTextFields:@[textField]];
}

+ (id)controllerWithTextFields:(NSArray *)textFields {
    return [[self alloc] initWithTextFields:textFields];
}

- (void)dealloc {
    [self _unsubscribeFromNotifications];
}

- (id)initWithTextFields:(NSArray *)textFields {
    self = [super init];
    if (self) {
        self.textFields = textFields;
        [self _setupTextFields];
        [self _subscribeToNotifications];
    }
    return self;
}

- (id)init {
    NSString *reason = [NSString stringWithFormat:@"""%@"" Use designated initializer.", NSStringFromSelector(_cmd)];
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil];
}

- (void)_setupTextFields {
    for (UITextField *textField in self.textFields) {
        textField.delegate = self;
    }
}

- (void)_subscribeToNotifications {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(_onKeyboardDidHide) name:UIKeyboardDidHideNotification object:nil];
    [center addObserver:self selector:@selector(_onKeyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(_onKeyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    [center addObserver:self selector:@selector(_onKeyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
}

- (void)_unsubscribeFromNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)moveToPreviousTextField {
    for (int i = 0; i < [self.textFields count]; i++) {
        if ([[self.textFields objectAtIndex:i] isEditing] && i != 0) {
            [[self.textFields objectAtIndex:i - 1] becomeFirstResponder];
            break;
        }
    }
}

- (void)moveToNextTextField {
    for (int i = 0; i < [self.textFields count]; i++) {
        if ([[self.textFields objectAtIndex:i] isEditing] && i != [self.textFields count] - 1) {
            [[self.textFields objectAtIndex:i + 1] becomeFirstResponder];
            break;
        }
    }
}

- (void)closeKeyboard {
    for (UITextField *textField in self.textFields) {
        if ([textField isEditing]) {
            [textField resignFirstResponder];
            break;
        }
    }
}

- (NSInteger)indexForTextField:(UITextField *)textField {
    NSInteger index = 0;
    
    for (UITextField *t in self.textFields) {
        if (textField == t) break;
        index++;
    }
    
    return index;
}


#pragma mark - Notification Handlers

- (void)_onKeyboardDidHide {
    if (!self.delegate) return;
    if (![self.delegate conformsToProtocol:@protocol(KeyboardControllerDelegate)]) return;
    [self.delegate controllerDidHideKeyboard:self];
}

- (void)_onKeyboardDidShow {
    if (!self.delegate) return;
    if (![self.delegate conformsToProtocol:@protocol(KeyboardControllerDelegate)]) return;
    [self.delegate controllerDidShowKeyboard:self];
}

- (void)_onKeyboardWillHide {
    if (!self.delegate) return;
    if (![self.delegate conformsToProtocol:@protocol(KeyboardControllerDelegate)]) return;
    [self.delegate controllerWillHideKeyboard:self];
}

- (void)_onKeyboardWillShow {
    if (!self.delegate) return;
    if (![self.delegate conformsToProtocol:@protocol(KeyboardControllerDelegate)]) return;
    [self.delegate controllerWillShowKeyboard:self];
}


#pragma mark - UITextFieldDelegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (!self.textFieldDelegate) return;
    if (![self.textFieldDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) return;
    [self.textFieldDelegate textFieldDidBeginEditing:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (!self.textFieldDelegate) return;
    if (![self.textFieldDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) return;
    [self.textFieldDelegate textFieldDidEndEditing:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.returnKeyType == UIReturnKeyNext) [self moveToNextTextField];
    if (textField.returnKeyType == UIReturnKeyDone) [self closeKeyboard];
    return (textField.returnKeyType == UIReturnKeyDone);
}

@end
