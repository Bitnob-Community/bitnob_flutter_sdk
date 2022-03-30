# bitnob

This SDK equips online businesses using flutter with the ability to accept and process bitcoin payments via on-chain or lightning seamlessly.


## Platform Support

| Android | iOS | 
| :-----: | :-: |
|   ✔️    | ✔️  |  

## ⚙️ Android Setup
    No any requirement

## ⚙️ Ios Setup
    No any requirement

## Getting Started

1.  Open a command line and cd to your projects root folder
2.  In your pubspec, add an entry for bitnob to your dependencies (example below)
3.  pub install

## Installation

You just need to add `bitnob` as a [dependency in your pubspec.yaml file](https://flutter.io/using-packages/).

```yaml
dependencies:
  bitnob: ^0.0.2
```
-Run `flutter packages get` to install the package

## How to Use

```dart
import 'package:bitnob/bitnob.dart';
```

```dart
final BitNob _bitNob = BitNob();
```

## Example
```dart
await _bitNob.buildWithOptions(
      baseUrl: "your base url",
      description: "test",
      callbackUrl: "test",
      successUrl: "",
      notificationEmail: "customer@gmail.com",
      customerEmail: "customer@gmail.com",
      satoshis: 2000,
      reference: "test",
      publicKey: "your public key",
      context: context,
      failCallback: (fail) {
        //fail callBack
      },
      successCallback: (success) {
        //success callBack
      },
      closeCallBack: (close) {
       //close callBack
      },
    );
```

```
Note: successUrl keep blank.
```
## How to get "publicKey" to use bitnob SDK?

- Please [`Sign up`](https://app.bitnob.co/accounts/signup) here, Then follow this [`link`](https://docs.bitnob.com/docs/api-keys) to get publicKey.


## 📷 Screenshots

| Platform | Screenshot |
| ------------- | ------------- |
| Android | <img height="480" src="https://bitnobwhmcsplugin.s3.eu-west-2.amazonaws.com/images/android_checkout.png"> <img height="480" src="https://bitnobwhmcsplugin.s3.eu-west-2.amazonaws.com/images/android_payment_success.png"> <img height="480" src="https://bitnobwhmcsplugin.s3.eu-west-2.amazonaws.com/images/android_timeout.png"> |
| iOS | <img height="414" src="https://bitnobwhmcsplugin.s3.eu-west-2.amazonaws.com/images/ios_checkout.png"> <img height="414" src="https://bitnobwhmcsplugin.s3.eu-west-2.amazonaws.com/images/ios_payment_success.png">  <img height="414" src="https://bitnobwhmcsplugin.s3.eu-west-2.amazonaws.com/images/ios_timeout1.png"> |

# License
```
MIT License

Copyright (c) 2022 bitnob

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
