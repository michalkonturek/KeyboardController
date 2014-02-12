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

+ (instancetype)controllerWithField:(UITextField *)field;
+ (instancetype)controllerWithFields:(NSArray *)fields;

@property (nonatomic, assign) id<KeyboardControllerDelegate> delegate;
@property (nonatomic, assign) id<UITextFieldDelegate> textFieldDelegate;
@property (nonatomic, strong) NSArray *fields;

- (id)initWithFields:(NSArray *)fields;

- (void)moveToNextField;
- (void)moveToPreviousField;
- (void)closeKeyboard;

- (NSInteger)indexForField:(id)field;

@end

@protocol KeyboardControllerDelegate <NSObject>

@optional
- (void)controllerDidHideKeyboard:(KeyboardController *)controller;
- (void)controllerDidShowKeyboard:(KeyboardController *)controller;
- (void)controllerWillHideKeyboard:(KeyboardController *)controller;
- (void)controllerWillShowKeyboard:(KeyboardController *)controller;

@end
