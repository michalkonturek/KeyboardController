# KeyboardController

[![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)](https://github.com/michalkonturek/KeyboardController/blob/master/LICENSE)
[![Build Platform](https://cocoapod-badges.herokuapp.com/p/KeyboardController/badge.png)](https://github.com/michalkonturek/KeyboardController)
[![Build Version](https://cocoapod-badges.herokuapp.com/v/KeyboardController/badge.png)](https://github.com/michalkonturek/KeyboardController)

Simplifies iOS keyboard handling.


## License

Source code of this project is available under the standard MIT license. Please see [the license file][LICENSE].

[PODS]:http://cocoapods.org/
[LICENSE]:https://github.com/michalkonturek/KeyboardController/blob/master/LICENSE


## Usage

To use `KeyboardController`, simply initialize it with an array of `UITextField` of `UITextView` objects.

```objc
id fields = @[_field1, _field2, _field3, _field4, _field5];
self.keyboardController = [KeyboardController controllerWithFields:fields];
```

You can interact with `KeyboardController` directly via the following methods:

```objc
- (void)moveToNextField;
- (void)moveToPreviousField;
- (void)closeKeyboard;
```

`KeyboardController`, depending on a `returnKeyType` property of an `UITextField` instance, will:

* `UIReturnKeyNext` - move to next text field
* `UIReturnKeyDone` - close keyboard


### KeyboardControllerDelegate 

You could also take advantage of delegation methods:

```objc
- (void)controllerDidHideKeyboard:(KeyboardController *)controller;
- (void)controllerDidShowKeyboard:(KeyboardController *)controller;
- (void)controllerWillHideKeyboard:(KeyboardController *)controller;
- (void)controllerWillShowKeyboard:(KeyboardController *)controller;
```

by setting a `delegate` property of a `KeyboardController`:

```objc
self.keyboardController.delegate = self;
```


### UITextFieldDelegate 

There is also an option of setting a `textFieldDelegate` property of all textFields that are under control of `KeyboardController`:

```objc
self.keyboardController.textFieldDelegate = self;
```

This could be particulary useful if you would like to add individual behaviour to `UITextFields` objects.

```objc
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.textField4) [self _moveViewByY:-50];
    if (textField == self.textField5) [self _moveViewByY:-200];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.textField4) [self _moveViewByY:50];
    if (textField == self.textField5) [self _moveViewByY:200];
}
```

<!-- - - - 

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/michalkonturek/keyboardcontroller/trend.png)](https://bitdeli.com/free "Bitdeli Badge") -->