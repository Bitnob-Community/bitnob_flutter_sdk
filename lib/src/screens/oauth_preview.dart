import 'package:bitnob/bitnob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OAuthPreviewScreen extends StatefulWidget {
  final Mode mode;
  final String clientId;
  final List scope;
  final String state;
  final String redirectUrl;
  final Function(
    dynamic response,
  ) successCallback;
  final Function(
    dynamic response,
  ) failCallback;
  final Function(dynamic response) closeCallBack;

  const OAuthPreviewScreen(
      {Key? key,
      required this.mode,
      required this.clientId,
      required this.scope,
      required this.state,
      required this.closeCallBack,
      required this.successCallback,
      required this.failCallback,
      required this.redirectUrl})
      : super(key: key);

  @override
  State<OAuthPreviewScreen> createState() => _OAuthPreviewScreenState();
}

class _OAuthPreviewScreenState extends State<OAuthPreviewScreen> {
  bool loading = true;
  String finalUrl = "";

  @override
  void initState() {
    super.initState();
    makeFinalUrl();
  }

  makeFinalUrl() {
    String finalScope = widget.scope.join(" ");
    finalUrl =
        "${getBaseUrlBaseOnType()}/login?scope=$finalScope&clientId=${widget.clientId}&redirectUrl=${widget.redirectUrl}&state=${widget.state}";
  }

  String getBaseUrlBaseOnType() {
    if (widget.mode == Mode.sandbox) {
      return "https://sandbox-oauth.bitnob.co";
    }
    if (widget.mode == Mode.production) {
      return "https://oauth.bitnob.co";
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
              
              navigationDelegate: (request) { 
                if (request.url.contains("/?error=")) {
                  var uri = Uri.parse(request.url);
                  var error = "";
                  uri.queryParameters.forEach((k, v) {
                    if (k == "error") {
                      error = v;
                    }
                  });
                  Navigator.pop(context);
                  widget.failCallback(error);
                } else if (!request.url.contains(getBaseUrlBaseOnType()) &&
                    request.url.contains(widget.redirectUrl)) {
                  Navigator.pop(context);
                  widget.successCallback("Success");
                }
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
