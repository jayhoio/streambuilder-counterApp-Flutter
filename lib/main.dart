import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Stream<int> stBuildFun() async* {
    for (int i = 0; i < 1000000; i++) {
     await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text("Stream Builder")),
        body: SafeArea(
            child: Center(
                child: StreamBuilder<int>(
          stream: stBuildFun(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.hasData) {
              debugPrint(snapshot.data.toString());
              return Text(snapshot.data.toString(),style: TextStyle(fontSize: 80),);
            }else{
              return const Center(child: CircularProgressIndicator());
            }
          },
        ))),
      ),
    );
  }
}
