// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'dart:convert';

import 'package:bitnob/bitnob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BitnobTransferScreen extends StatefulWidget {
  final Mode mode;
  final String senderName;
  final String publicKey;
  final String redirectUrl;
  final Function(
    dynamic response,
  ) successCallback;
  final Function(
    dynamic response,
  ) failCallback;
  final Function(dynamic response) closeCallBack;

  const BitnobTransferScreen({
    Key? key,
    required this.mode,
    required this.closeCallBack,
    required this.successCallback,
    required this.failCallback,
    required this.redirectUrl,
    required this.publicKey,
    required this.senderName,
  }) : super(key: key);

  @override
  State<BitnobTransferScreen> createState() => _BitnobTransferScreenState();
}

class _BitnobTransferScreenState extends State<BitnobTransferScreen> {
  bool loading = true;
  String finalUrl = "";
  late WebViewController _webViewController;
  bool isPopScreen = false;
  @override
  void initState() {
    super.initState();
    makeFinalUrl();
  }

  makeFinalUrl() {
    finalUrl =
        "${getBaseUrlBaseOnType()}/senderName?scope=${widget.senderName}&pk=${widget.publicKey}&callbackUrl=${widget.redirectUrl}";
  }

  String getBaseUrlBaseOnType() {
    if (widget.mode == Mode.sandbox) {
      return "https://remit-sandbox.sundownn.top";
    }
    if (widget.mode == Mode.production) {
      return "https://remit.bitnob.co";
    }
    return "";
  }

  String script = 'window.addEventListener("message", receiveMessage, false);' +
      'function receiveMessage(event) {Print.postMessage(event.data);}';

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
            WebView(
              initialUrl: Uri.parse(finalUrl).toString(),
              onPageFinished: (val) {
                loading = false;
                setState(() {});

                _webViewController.runJavascript(script);
              },
              javascriptMode: JavascriptMode.unrestricted,
              zoomEnabled: false,
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              debuggingEnabled: true,
              javascriptChannels: {
                JavascriptChannel(
                    name: 'Print',
                    onMessageReceived: (JavascriptMessage message) {
                      try {
                        if (message.message == "modal_closed") {
                          widget.closeCallBack("Close Call Back");
                          if (!isPopScreen) {
                            isPopScreen = true;
                            Navigator.pop(context);
                          }
                        } else if (message.message == "modal_opened") {
                        } else {
                          widget.successCallback(jsonDecode(message.message));
                          if (!isPopScreen) {
                            isPopScreen = true;
                            Future.delayed(const Duration(seconds: 5), () {
                              Navigator.pop(context);
                            });
                          }
                        }
                      } catch (e) {
                        widget.failCallback(e);
                        if (!isPopScreen) {
                          isPopScreen = true;
                          Navigator.pop(context);
                        }
                      }
                    }),
              },
            ),
            if (loading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
