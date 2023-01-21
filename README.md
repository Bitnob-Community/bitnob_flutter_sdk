# Bitnob SDK

Bitnob SDK equips online businesses using react native with the ability to integrate our API features easily. Example are;
-  Checkout: Accept and process bitcoin payments via on-chain or lightning seamlessly
-  Oauth: Allows you to access Bitnob user details
-  Transfers: Allows businesses to transfer funds to a Bitnob customer, or local mobile money and bank accounts in supported African countries

## Platform Support

| Android | iOS |
| :-----: | :-: |
|   ✔️    | ✔️  |

## ⚙️ Android Setup
    No requirement

## ⚙️ Ios Setup
    No requirement

## Getting Started

1.  Open a command line and cd to your projects root folder
2.  In your pubspec, add an entry for bitnob to your dependencies (example below)
3.  pub install

## Installation

You just need to add `bitnob` as a [dependency in your pubspec.yaml file](https://flutter.io/using-packages/).

```yaml
dependencies:
  bitnob: ^0.1.1
```
-Run `flutter packages get` to install the package

## How to Use

```dart
import 'package:bitnob/bitnob.dart';
```

```dart
final BitNob _bitNob = BitNob();
```
## How to get "publicKey" to use bitnob SDK?


- Create a [`Sandbox`](https://sandboxapp.bitnob.co/) or [`Production`](https://app.bitnob.co/) Account, See the keys at Setting > Developers tab, See [`Documentation`](https://docs.bitnob.com/docs/api-keys) for more.

## Checkout Example
```dart
await _bitNob.initiateCheckout(
      mode: "set mode(sandbox or production)",
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

## How to get cliendID, scope, state to use bitnob OAuth?

- From your dashboard, create an App in Settings > Developers > Oauth apps to get them, See more in our [`OAuth Documentation`](https://docs.bitnob.com/docs/bitnob-for-business-oauth-20).

## OAuth Example
```dart
    await _bitNob.initiateOauth(
      mode: "set mode(sandbox or production)",
      clientId: "your clientId",
      scope: [
        "user:custom_ln_address",
        "user:verification_level",
        "user:email",
        "user:username",
        "user:ln_address"
      ],
      state: "bbdbbbjjk",
      redirectUrl: "your redirect url",
      failCallback: (fail) {
        if (kDebugMode) {
          print("Fail=============> " + fail.toString());
        }
      },
      successCallback: (success) {
        if (kDebugMode) {
          print("Success=============> " + success.toString());
        }
      },
      closeCallBack: (close) {
        if (kDebugMode) {
          print("Close=============> " + close.toString());
        }
      },
      context: context,
    );
```

## How to get "publicKey" to use bitnob SDK?


- Create a [`Sandbox`](https://sandboxapp.bitnob.co/) or [`Production`](https://app.bitnob.co/) Account, See the keys at Setting > Developers tab, See [`Documentation`](https://docs.bitnob.com/docs/api-keys) for more.

## Transfer Example
```dart
await _bitNob.bitnobTransfer(
      mode: Mode.sandbox,
      redirectUrl: "your redirect url",
      failCallback: (fail) {
        if (kDebugMode) {
          print("Fail=============> " + fail.toString());
        }
      },
      successCallback: (success) {
        if (kDebugMode) {
          print("Success=============> " + success.toString());
        }
      },
      closeCallBack: (close) {
        if (kDebugMode) {
          print("Close=============> " + close.toString());
        }
      },
      context: context,
      publicKey: 'your public key',
      senderName: 'sender name',
    );
```

## 📷 Checkout Screenshots

| Platform | Screenshot |
| ------------- | ------------- |
| Android | <img height="480" src="https://bitnobwhmcsplugin.s3.eu-west-2.amazonaws.com/images/android_checkout.png"> <img height="480" src="https://bitnobwhmcsplugin.s3.eu-west-2.amazonaws.com/images/android_payment_success.png"> <img height="480" src="https://bitnobwhmcsplugin.s3.eu-west-2.amazonaws.com/images/android_timeout.png"> |
| iOS | <img height="414" src="https://bitnobwhmcsplugin.s3.eu-west-2.amazonaws.com/images/ios_checkout.png"> <img height="414" src="https://bitnobwhmcsplugin.s3.eu-west-2.amazonaws.com/images/ios_payment_success.png">  <img height="414" src="https://bitnobwhmcsplugin.s3.eu-west-2.amazonaws.com/images/ios_timeout1.png"> |


## 📷 OAuth Screenshots

| Platform | Screenshot |
| ------------- | ------------- |
| Android | <img height="480" src="https://js.bitnob.co/assets/android_oauth.png"> <img height="480" src="https://js.bitnob.co/assets/android_oauth_authorize.png"> |
| iOS | <img height="414" src="https://www.js.bitnob.co/assets/ios_oauth.PNG"> <img height="414" src="https://www.js.bitnob.co/assets/ios_oauth_authorize.PNG"> |

## 📷 Transfer Screenshots

| Platform | Screenshot |
| ------------- | ------------- |
| Android | <img height="480" src="https://www.js.bitnob.co/assets/transfers_sdk/android/1.png"> <img height="480" src="https://www.js.bitnob.co/assets/transfers_sdk/android/2.png"> <img height="480" src="https://www.js.bitnob.co/assets/transfers_sdk/android/3.png"> <img height="480" src="https://www.js.bitnob.co/assets/transfers_sdk/android/4.png"> |
| iOS | <img height="480" src="https://www.js.bitnob.co/assets/transfers_sdk/ios/1.png"> <img height="480" src="https://www.js.bitnob.co/assets/transfers_sdk/ios/2.png"> <img height="480" src="https://www.js.bitnob.co/assets/transfers_sdk/ios/3.png"> <img height="480" src="https://www.js.bitnob.co/assets/transfers_sdk/ios/4.png"> |


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
