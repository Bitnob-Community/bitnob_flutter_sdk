import 'dart:async';
import 'package:bitnob/bitnob.dart';
import 'package:bitnob/src/models/model.dart';
import 'package:bitnob/src/utils/const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PreViewScreen extends StatefulWidget {
  final Mode? mode;
  final String? description;
  final String? callbackUrl;
  final String? successUrl;
  final String? notificationEmail;
  final String? customerEmail;
  final int? satoshis;
  final String? reference;
  final String? publicKey;
  final Function(
    dynamic response,
  ) successCallback;
  final Function(
    dynamic response,
  ) failCallback;
  final Function(dynamic response) closeCallBack;
  const PreViewScreen(
      {Key? key,
      required this.mode,
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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
        Response response = await dio.get(
          "${getBaseUrlBaseOnType()}$checkoutStatus${modelClass?.data?.id ?? ""}",
        );
        if (response.data['data']['status'].toString().toLowerCase() ==
            "paid") {
          timer.cancel();
          widget.successCallback(response.data);
        }
      } on DioError catch (e) {
        timer.cancel();
        widget.failCallback(e.error);
      }
    });
  }

  _apicallForPayMent() async {
    try {
      Response response = await dio.get(
        "${getBaseUrlBaseOnType()}$createCheckout",
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
      widget.failCallback(e.error);
      Navigator.pop(context);
    }
  }

  String getBaseUrlBaseOnType() {
    if (widget.mode == Mode.sandbox) {
      return "https://staging-api.flowertop.xyz";
    }
    if (widget.mode == Mode.production) {
      return "https://staging-api.flowertop.xyz";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light, // For iOS: (dark icons)
      statusBarIconBrightness: Brightness.dark, // For Android: (dark icons)
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
