import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:cpu_reader/cpu_reader.dart';
import 'package:cpu_reader/cpuinfo.dart';
import 'package:flutter/material.dart';



class Bat extends StatefulWidget {
  const Bat({Key? key}) : super(key: key);

  @override
  _BatState createState() => _BatState();
}

class _BatState extends State<Bat> {
  var battery = Battery();
  int level = 100;
  BatteryState batteryState = BatteryState.full;
  late Timer timer;
  late StreamSubscription streamSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBatteryPercentage();
    getBatteryState();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      getBatteryPercentage();
    });
  }

  void getBatteryPercentage() async {
    final batteryLevel = await battery.batteryLevel;

    this.level = batteryLevel;
  }

  void getBatteryState() {
    streamSubscription = battery.onBatteryStateChanged.listen((state) {
      setState(() {
        this.batteryState = state;
      });
    });
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    timer.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Số pin:${level} %',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              StreamBuilder<CpuInfo>(
                  stream: CpuReader.cpuStream(1000),
                  builder: (_, AsyncSnapshot<CpuInfo> snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: SpeedCPU(snapshot),
                      );
                    }
                    return Text('No data!');
                  }),
            ],
          ),
        ),
      ),
    );
  }
  List<Row> SpeedCPU(AsyncSnapshot<CpuInfo> snapshot) {
    return snapshot.data!.currentFrequencies!.entries
        .map((entry) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('CPU ${entry.key} '), Text('${entry.value}')]))
        .toList();
  }
}