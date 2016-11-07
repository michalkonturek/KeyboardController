# KeyboardController

[![Version](https://img.shields.io/cocoapods/v/KeyboardController.svg)](http://cocoapods.org/pods/KeyboardController)
[![Build Status](https://travis-ci.org/michalkonturek/KeyboardController.svg?branch=master)](https://travis-ci.org/michalkonturek/KeyboardController)
[![Swift](https://img.shields.io/badge/%20compatible-swift%203.0-orange.svg)](http://swift.org)
[![License](https://img.shields.io/cocoapods/l/KeyboardController.svg)](http://cocoapods.org/pods/KeyboardController)
[![Twitter](https://img.shields.io/badge/contact-@MichalKonturek-blue.svg)](http://twitter.com/michalkonturek)

Simplifies iOS keyboard handling.


## License

Source code of this project is available under the standard MIT license. Please see [the license file][LICENSE].

[PODS]:http://cocoapods.org/
[LICENSE]:https://github.com/michalkonturek/KeyboardController/blob/master/LICENSE


## Usage

To use `KeyboardController`, simply initialize it with an array of `UITextField` objects.

```swift
let fields = [field1!, field2!, field3!, field4!, field5!]
self.controller = KeyboardController(fields: fields)
```

You can interact with `KeyboardController` directly via the following methods:

```swift
func moveToNextField()
func moveToPreviousField()
func closeKeyboard()
```

`KeyboardController`, depending on a `returnKeyType` property of an `UITextField` instance, will:

* `UIReturnKeyNext` - move to next text field
* `UIReturnKeyDone` - close keyboard


### KeyboardControllerDelegate 

You could also take advantage of delegation methods:

```swift
func controllerDidHideKeyboard(controller: KeyboardController)
func controllerDidShowKeyboard(controller: KeyboardController)
func controllerWillHideKeyboard(controller: KeyboardController)
func controllerWillShowKeyboard(controller: KeyboardController)
```

by setting a `delegate` property of a `KeyboardController`:

```swift
self.keyboardController.delegate = self;
```


### UITextFieldDelegate 

There is also an option of setting a `textFieldDelegate` property of all textFields that are under control of `KeyboardController`:

```swift
self.keyboardController.textFieldDelegate = self;
```

This could be particulary useful if you would like to add individual behaviour to `UITextFields` objects.

```swift
func textFieldDidBeginEditing(_ textField: UITextField) {
    if (textField == self.field4) { self.moveViewBy(-10) }
    if (textField == self.field5) { self.moveViewBy(-200) }
}

func textFieldDidEndEditing(_ textField: UITextField) {
    if (textField == self.field4) { self.moveViewBy(10) }
    if (textField == self.field5) { self.moveViewBy(200) }
}
```

## Contributing

1. Fork it.
2. Create your feature branch (`git checkout -b new-feature`).
3. Commit your changes (`git commit -am 'Added new-feature'`).
4. Push to the branch (`git push origin new-feature`).
5. Create new Pull Request.