// ignore_for_file: prefer_interpolation_to_compose_strings

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
              },
              javascriptMode: JavascriptMode.unrestricted,
              zoomEnabled: false,
              javascriptChannels: {
                JavascriptChannel(
                  name: "message",
                  onMessageReceived: (message) {
                    print(message);
                  },
                ),
                JavascriptChannel(
                  name: "modal_closed",
                  onMessageReceived: (message) {
                    print(message);
                  },
                ),
                JavascriptChannel(
                  name: "modal_opened",
                  onMessageReceived: (message) {
                    print(message);
                  },
                ),
              },
              navigationDelegate: (request) {
                print("=========> " + request.url);
                // if (request.url.contains("/?error=")) {
                //   var uri = Uri.parse(request.url);
                //   var error = "";
                //   uri.queryParameters.forEach((k, v) {
                //     if (k == "error") {
                //       error = v;
                //     }
                //   });
                //   Navigator.pop(context);
                //   widget.failCallback(error);
                // } else if (!request.url.contains(getBaseUrlBaseOnType()) &&
                //     request.url.contains(widget.redirectUrl)) {
                //   Navigator.pop(context);
                //   widget.successCallback("Success");
                // }
                return NavigationDecision.navigate;
              },
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
