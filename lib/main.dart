import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TheLastDaydream',
      theme: darkTheme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final battery = Battery();
  StreamSubscription? _ss;
  var level = -1;

  @override
  void initState() {
    super.initState();
    _ss = Stream.periodic(const Duration(seconds: 5)).listen((event) async {
      level = await battery.batteryLevel;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final tt = t.textTheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("$level %", style: tt.headline1),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ss?.cancel();
    super.dispose();
  }
}
