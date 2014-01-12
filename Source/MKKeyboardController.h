//
//  MKKeyboardController.h
//  MKKeyboardController
//
//  Created by Michal Konturek on 11/01/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MKKeyboardControllerDelegate;

@interface MKKeyboardController : NSObject<UITextFieldDelegate>

+ (id)controllerWithTextField:(UITextField *)textField;
+ (id)controllerWithTextFields:(NSArray *)textFields;

@property (nonatomic, assign) id<MKKeyboardControllerDelegate> delegate;
@property (nonatomic, assign) id<UITextFieldDelegate> textFieldDelegate;
@property (nonatomic, strong) NSArray *textFields;

- (id)initWithTextFields:(NSArray *)textFields;

- (void)moveToNextTextField;
- (void)moveToPreviousTextField;
- (void)closeKeyboard;

- (NSInteger)indexForTextField:(UITextField *)textField;

@end

@protocol MKKeyboardControllerDelegate <NSObject>

- (void)controllerDidHideKeyboard:(MKKeyboardController *)controller;
- (void)controllerDidShowKeyboard:(MKKeyboardController *)controller;
- (void)controllerWillHideKeyboard:(MKKeyboardController *)controller;
- (void)controllerWillShowKeyboard:(MKKeyboardController *)controller;

@end