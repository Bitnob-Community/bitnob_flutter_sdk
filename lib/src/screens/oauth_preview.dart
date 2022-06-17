import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class OAuthPreviewScreen extends StatefulWidget {
  final String? baseUrl;
  final String? clientId;
  final String? scope;
  final String? state;
  final String? redirectUrl;
  Function(
    dynamic response,
  ) successCallback;
  Function(
    dynamic response,
  ) failCallback;
  Function(dynamic response) closeCallBack;

  OAuthPreviewScreen(
      {Key? key,
      required this.baseUrl,
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
    finalUrl =
        "${widget.baseUrl}/login?scope=${widget.scope}&clientId=${widget.clientId}&redirectUrl=${widget.redirectUrl}&state=${widget.state}";
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
              initialUrl: finalUrl,
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
                } else if (!request.url.contains(widget.baseUrl ?? "") && request.url.contains(widget.redirectUrl ?? "")) {
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
