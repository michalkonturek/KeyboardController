//
//  KeyboardController.m
//  KeyboardController
//
//  Created by Michal Konturek on 11/01/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "KeyboardController.h"

@implementation KeyboardController

+ (instancetype)controllerWithField:(id)field {
    return [[self alloc] initWithFields:@[field]];
}

+ (instancetype)controllerWithFields:(NSArray *)fields {
    return [[self alloc] initWithFields:fields];
}

- (void)dealloc {
    [self _unsubscribeFromNotifications];
}

- (id)initWithFields:(NSArray *)fields {
    self = [super init];
    if (self) {
        self.fields = fields;
        [self _setupFields];
        [self _subscribeToNotifications];
    }
    return self;
}

- (id)init {
    NSString *reason = [NSString stringWithFormat:@"""%@"" Use designated initializer.", NSStringFromSelector(_cmd)];
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil];
}

- (void)_setupFields {
    for (id field in self.fields) {
        [field setDelegate:self];
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

- (void)moveToPreviousField {
    for (int i = 0; i < [self.fields count]; i++) {
        if ([[self.fields objectAtIndex:i] isEditing] && i != 0) {
            [[self.fields objectAtIndex:i - 1] becomeFirstResponder];
            break;
        }
    }
}

- (void)moveToNextField {
    for (int i = 0; i < [self.fields count]; i++) {
        if ([[self.fields objectAtIndex:i] isEditing] && i != [self.fields count] - 1) {
            [[self.fields objectAtIndex:i + 1] becomeFirstResponder];
            break;
        }
    }
}

- (void)closeKeyboard {
    for (id field in self.fields) {
        if ([field isEditing]) {
            [field resignFirstResponder];
            break;
        }
    }
}

- (NSInteger)indexForField:(id)field {
    return [self.fields indexOfObject:field];
}


#pragma mark - Notification Handlers

- (void)_onKeyboardDidHide {
    if (!self.delegate) return;
    if (![self.delegate conformsToProtocol:@protocol(KeyboardControllerDelegate)]) return;
    if (![self.delegate respondsToSelector:@selector(controllerDidHideKeyboard:)]) return;
    [self.delegate controllerDidHideKeyboard:self];
}

- (void)_onKeyboardDidShow {
    if (!self.delegate) return;
    if (![self.delegate conformsToProtocol:@protocol(KeyboardControllerDelegate)]) return;
    if (![self.delegate respondsToSelector:@selector(controllerDidShowKeyboard:)]) return;
    [self.delegate controllerDidShowKeyboard:self];
}

- (void)_onKeyboardWillHide {
    if (!self.delegate) return;
    if (![self.delegate conformsToProtocol:@protocol(KeyboardControllerDelegate)]) return;
    if (![self.delegate respondsToSelector:@selector(controllerWillHideKeyboard:)]) return;
    [self.delegate controllerWillHideKeyboard:self];
}

- (void)_onKeyboardWillShow {
    if (!self.delegate) return;
    if (![self.delegate conformsToProtocol:@protocol(KeyboardControllerDelegate)]) return;
    if (![self.delegate respondsToSelector:@selector(controllerWillShowKeyboard:)]) return;
    [self.delegate controllerWillShowKeyboard:self];
}


#pragma mark - UITextFieldDelegate

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
    if (textField.returnKeyType == UIReturnKeyNext) [self moveToNextField];
    if (textField.returnKeyType == UIReturnKeyDone) [self closeKeyboard];
    return (textField.returnKeyType == UIReturnKeyDone);
}

@end
