library bitnob;

import 'package:bitnob/src/screens/oauth_preview.dart';
import 'package:flutter/material.dart';
import 'src/screens/preview.dart';

///This is main bitnob class.
class BitNob {
  ///This method use for payment

  Future initialCheckout({
    required Mode mode,
    required String description,
    required String callbackUrl,
    required String successUrl,
    required String notificationEmail,
    required String customerEmail,
    required int satoshis,
    required String reference,
    required String publicKey,
    required BuildContext context,
    required Function(
      dynamic response,
    )
        successCallback,
    required Function(
      dynamic response,
    )
        failCallback,
    required Function(
      dynamic response,
    )
        closeCallBack,
  }) async {
    ///Here navigate to the webview screen.

    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreViewScreen(
            mode: mode,
            description: description,
            callbackUrl: callbackUrl,
            successUrl: successUrl,
            notificationEmail: notificationEmail,
            customerEmail: customerEmail,
            satoshis: satoshis,
            reference: reference,
            publicKey: publicKey,
            closeCallBack: closeCallBack,
            failCallback: failCallback,
            successCallback: successCallback,
          ),
        ));
    return null;
  }

  ///initiateOauth method use for payment
  Future initiateOauth({
    required Mode mode,
    required String clientId,
    required List<String> scope,
    required String state,
    required String redirectUrl,
    required Function(dynamic response) successCallback,
    required Function(dynamic response) failCallback,
    required Function(dynamic response) closeCallBack,
    required BuildContext context,
  }) async {
    ///Here navigate to the webview screen.

    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OAuthPreviewScreen(
            mode: mode,
            clientId: clientId,
            redirectUrl: redirectUrl,
            scope: scope,
            state: state,
            closeCallBack: closeCallBack,
            failCallback: failCallback,
            successCallback: successCallback,
          ),
        ));
    return null;
  }
}

enum Mode {
  sandbox,
  production,
}
