//
//  KeyboardController.h
//  KeyboardController
//
//  Copyright (c) 2014 Michal Konturek
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Foundation/Foundation.h>

@protocol KeyboardControllerDelegate;

@interface KeyboardController : NSObject<UITextFieldDelegate>

+ (instancetype)controllerWithField:(id)field;
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
