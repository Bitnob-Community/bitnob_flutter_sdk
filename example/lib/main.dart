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
      baseUrl: "https://staging-api.flowertop.xyz",
      description: "test133",
      callbackUrl: "test133",
      successUrl: "",
      notificationEmail: "test133",
      customerEmail: "test133",
      satoshis: 2000,
      reference: "test133",
      publicKey: "pk.1a593.b3b0b105da63ff7b70f3310f355ce0",
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
            )
          ],
        ),
      ),
    );
  }
}
