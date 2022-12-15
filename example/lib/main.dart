import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bitnob/bitnob.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Bitnob Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final BitNob _bitNob = BitNob();

  Future<void> payWithOptions() async {
    await _bitNob.initiateCheckout(
      mode: Mode.sandbox,
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
    );
  }

  Future<void> initiateOauth() async {
    await _bitNob.initiateOauth(
      mode: Mode.sandbox,
      clientId: "your clientId",
      scope: [
        "user:custom_ln_address",
        "user:verification_level",
        "user:email",
        "user:username",
        "user:ln_address"
      ],
      state: "test",
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
  }

  Future<void> bitnobTransfer() async {
    await _bitNob.bitnobTransfer(
      mode: Mode.sandbox,
      redirectUrl: "https://google.com",
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
      publicKey: "your public key",
      senderName: "sender name",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await payWithOptions();
              },
              child: const Text("Pay"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                await initiateOauth();
              },
              child: const Text("InitiateOauth"),
            ),
            ElevatedButton(
              onPressed: () async {
                await bitnobTransfer();
              },
              child: const Text("bitnobTransfer"),
            ),
          ],
        ),
      ),
    );
  }
}
