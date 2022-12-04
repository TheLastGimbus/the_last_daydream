import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:the_last_daydream/shit_utils.dart';

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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  StreamSubscription? _ss;
  static const animationSpeed = 1.0;
  static const divider = 100000;
  static const refreshTime = Duration(seconds: 10);

  /// loop continuously growing number into 0..1 back and forth
  double l(double value) => (math.sin(value * animationSpeed) + 1) / 2;

  final seed = math.Random().nextInt(694202137);

  align(double e, math.Random r) => FractionalOffset(
      l((e + r.nextInt(6969)) / 1), l((e + r.nextInt(6969)) / 10));

  @override
  void initState() {
    super.initState();
    _ss ??= Stream.periodic(refreshTime).listen((event) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final tt = t.textTheme;
    // reset random generator every build (so we get consistent results)
    final r = math.Random(seed);
    final seconds = DateTime.now().millisecondsSinceEpoch.toDouble() /
        divider *
        animationSpeed;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: AnimatedContainer(
                duration: refreshTime,
                alignment: align(seconds, r),
                child: Text('Matiś ma telefonik naładowany na',
                    style: tt.bodyLarge),
              ),
            ),
            Expanded(
              flex: 1,
              child: AnimatedContainer(
                duration: refreshTime,
                alignment: align(seconds, r),
                child: const BatteryWidget(),
              ),
            ),
            Expanded(
              flex: 1,
              child: AnimatedContainer(
                duration: refreshTime,
                alignment: align(seconds, r),
                child: Text("a godzinka jest", style: tt.bodyLarge),
              ),
            ),
            Expanded(
              flex: 1,
              child: AnimatedContainer(
                duration: refreshTime,
                alignment: align(seconds, r),
                child: const DigitalClock(),
              ),
            ),
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

/// Standalone, auto-updating widget with battery %
class BatteryWidget extends StatelessWidget {
  const BatteryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: -1,
      stream: batteryStream,
      builder: (context, snapshot) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            value: snapshot.data! / 100,
            strokeWidth: 5,
            backgroundColor: const Color(0x33ffffff),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xbfffffff)),
          ),
          const SizedBox(width: 16),
          Text(
            "${snapshot.data}%",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ],
      ),
    );
  }
}

/// Standalone, auto-updating widget with digital clock
class DigitalClock extends StatelessWidget {
  const DigitalClock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: DateTime.now(),
      stream: timeMinutesStream,
      builder: (context, snapshot) {
        final time = snapshot.data!;
        return Text(
          "${time.hour.toString().padLeft(2, '0')}:"
          "${time.minute.toString().padLeft(2, '0')}",
          style: Theme.of(context).textTheme.displayLarge,
        );
      },
    );
  }
}
