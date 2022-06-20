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
    await _bitNob.buildWithOptions(
      mode: Mode.sandbox,
      description: "test133d",
      callbackUrl: "test133",
      successUrl: "",
      notificationEmail: "kasodariyadipak017@gmail.com",
      customerEmail: "kasodariyadipak017@gmail.com",
      satoshis: 2000,
      reference: "test13fdsd3",
      publicKey: "pk.0331f3a.f860370f9e629806ae72e9280e05d4b9",
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
      clientId: "daec5775a95da44e7bca",
      scope: [
        "user:custom_ln_address",
        "user:verification_level",
        "user:email",
        "user:username",
        "user:ln_address"
      ],
      state: "bdfgdfgdfgdf",
      redirectUrl: "https://www.google.com/",
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
          ],
        ),
      ),
    );
  }
}
