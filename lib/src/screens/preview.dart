// ignore_for_file: avoid_print

import 'dart:async';
import 'package:bitnob/src/models/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utils/const.dart';

// ignore: must_be_immutable
class PreViewScreen extends StatefulWidget {
  String? baseUrl;
  String? description;
  String? callbackUrl;
  String? successUrl;
  String? notificationEmail;
  String? customerEmail;
  int? satoshis;
  String? reference;
  String? publicKey;
  Function(
    dynamic response,
  ) successCallback;
  Function(
    dynamic response,
  ) failCallback;
  Function(dynamic response) closeCallBack;
  PreViewScreen(
      {Key? key,
      required this.baseUrl,
      required this.failCallback,
      required this.successCallback,
      required this.closeCallBack,
      this.callbackUrl,
      this.customerEmail,
      this.description,
      this.notificationEmail,
      this.publicKey,
      this.reference,
      this.satoshis,
      this.successUrl})
      : super(key: key);

  @override
  State<PreViewScreen> createState() => _PreViewScreenState();
}

class _PreViewScreenState extends State<PreViewScreen> {
  bool loading = true;
  ModelClass? modelClass;
  Dio dio = Dio();
  Timer timer = Timer(const Duration(seconds: 0), () {});

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _apicallForPayMent();
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer.isActive) {
      timer.cancel();
    }
  }

  _apiCallForCheckPaymentStatus() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      try {
        Response response = await dio
            .get(widget.baseUrl! + checkout_status + modelClass!.data!.id!);

        print(widget.baseUrl! + checkout_status + modelClass!.data!.id!);

        if (response.data['data']['status'].toString().toLowerCase() ==
            "paid") {
          timer.cancel();
          widget.successCallback(response.data);
        }
      } on DioError catch (e) {
        timer.cancel();
        widget.failCallback(e.response!.data);
      }
    });
  }

  _apicallForPayMent() async {
    try {
      Response response = await dio.get(
        widget.baseUrl! + create_checkout,
        queryParameters: {
          "description": widget.description,
          "callbackUrl": widget.callbackUrl,
          "successUrl": widget.successUrl,
          "notificationEmail": widget.notificationEmail,
          "customerEmail": widget.customerEmail,
          "satoshis": widget.satoshis,
          "reference": widget.reference,
          "publicKey": widget.publicKey
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        modelClass = ModelClass.fromJson(response.data);

        if (mounted) {
          setState(() {});
        }
        _apiCallForCheckPaymentStatus();
      } else {
        widget.failCallback(response.data);
        Navigator.pop(context);
      }
    } on DioError catch (e) {
      widget.failCallback(e.response!.data);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.dark,
      // status bar color
    ));
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            if ((modelClass?.data?.previewLink ?? "").isNotEmpty)
              WebView(
                initialUrl: modelClass?.data?.previewLink ?? "",
                onPageFinished: (val) {
                  loading = false;
                  setState(() {});
                },
                javascriptMode: JavascriptMode.unrestricted,
                zoomEnabled: false,
              ),
            if (loading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.closeCallBack("Close Call Back");
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
