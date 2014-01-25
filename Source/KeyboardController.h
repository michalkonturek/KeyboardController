//
//  KeyboardController.h
//  KeyboardController
//
//  Created by Michal Konturek on 11/01/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KeyboardControllerDelegate;

@interface KeyboardController : NSObject<UITextFieldDelegate>

+ (id)controllerWithTextField:(UITextField *)textField;
+ (id)controllerWithTextFields:(NSArray *)textFields;

@property (nonatomic, assign) id<KeyboardControllerDelegate> delegate;
@property (nonatomic, assign) id<UITextFieldDelegate> textFieldDelegate;
@property (nonatomic, strong) NSArray *textFields;

- (id)initWithTextFields:(NSArray *)textFields;

- (void)moveToNextTextField;
- (void)moveToPreviousTextField;
- (void)closeKeyboard;

- (NSInteger)indexForTextField:(UITextField *)textField;

@end

@protocol KeyboardControllerDelegate <NSObject>

- (void)controllerDidHideKeyboard:(KeyboardController *)controller;
- (void)controllerDidShowKeyboard:(KeyboardController *)controller;
- (void)controllerWillHideKeyboard:(KeyboardController *)controller;
- (void)controllerWillShowKeyboard:(KeyboardController *)controller;

@end
