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
  var time = DateTime.now();

  @override
  void initState() {
    super.initState();
    battery.batteryLevel.then((v) => setState(() => level = v)); // set initial
    _ss = Stream.periodic(const Duration(seconds: 1)).listen((event) async {
      final newLevel = await battery.batteryLevel;
      if (level != newLevel) {
        level = newLevel;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final tt = t.textTheme;
    final small = tt.bodyLarge!.copyWith(fontWeight: FontWeight.w200);
    final big =
        tt.displayLarge!.copyWith(fontSize: 64, fontWeight: FontWeight.w300);
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Spacer(flex: 10),
            Text('Matiś ma telefonik naładowany na', style: small),
            const Spacer(flex: 3),
            Row(
              children: [
                const Spacer(flex: 20),
                CircularProgressIndicator(
                  value: level / 100,
                  strokeWidth: 5,
                  backgroundColor: const Color(0x33ffffff),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xbfffffff)),
                ),
                const Spacer(flex: 4),
                Text("$level%", style: big),
                const Spacer(flex: 10),
              ],
            ),
            const Spacer(flex: 10),
            Text("a godzinka jest:", style: small),
            const Spacer(flex: 3),
            Row(
              children: [
                const Spacer(flex: 1),
                Text(
                  "${time.hour.toString().padLeft(2, '0')}:"
                  "${time.minute.toString().padLeft(2, '0')}",
                  style: big,
                ),
                const Spacer(flex: 3),
              ],
            ),
            const Spacer(flex: 15),
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
