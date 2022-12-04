import 'package:battery_plus/battery_plus.dart';

Stream<int> get batteryStream => Stream.periodic(const Duration(seconds: 1))
    .asyncMap((_) => Battery().batteryLevel)
    .distinct();

Stream<DateTime> get timeSecondsStream =>
    Stream.periodic(const Duration(milliseconds: 50))
        .map((_) => DateTime.now())
        .distinct((p, n) => p.second == n.second);

Stream<DateTime> get timeMinutesStream =>
    Stream.periodic(const Duration(milliseconds: 100))
        .map((_) => DateTime.now())
        .distinct((p, n) => p.minute == n.minute);
