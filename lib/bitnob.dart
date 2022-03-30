library bitnob;

import 'package:bitnob/screens/preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BitNob {
  Dio dio = Dio();

  Future buildWithOptions({
    required String baseUrl,
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
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreViewScreen(
            baseUrl: baseUrl,
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
}
