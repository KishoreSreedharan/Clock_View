import 'package:clock_view/const.dart';
import 'package:clock_view/properties.dart/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'properties.dart/colck.dart';
import 'properties.dart/navigation.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool status = true;
  bool status2 = false;
  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size.height;
    var we = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: blendColor,
      body: Container(
        alignment: Alignment.center,
        child: Column(children: [
          const Appbars(),
          SizedBox(
            height: he * 0.05,
          ),
          const ClockView(),
          SizedBox(
            height: he * 0.05,
          ),
          Container(
            width: we * 0.84,
            height: he * 0.07,
            padding: const EdgeInsets.all(0.8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: blendColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[500]!,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(2, 2)),
                const BoxShadow(
                    color: Colors.white,
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(-2, -2))
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "10:00",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: we * 0.01,
                ),
                const Text(
                  "am",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  width: we * 0.4,
                ),
                FlutterSwitch(
                    value: status2,
                    activeColor: activeColor1,
                    inactiveColor: Colors.black,
                    onToggle: (value) {
                      setState(() {
                        status2 = value;
                      });
                    })
              ],
            ),
          ),
          SizedBox(
            height: he * 0.05,
          ),
          Container(
            width: we * 0.84,
            height: he * 0.07,
            padding: const EdgeInsets.all(0.8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: blendColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[500]!,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(2, 2)),
                const BoxShadow(
                    color: Colors.white,
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(-2, -2))
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "2:00",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: we * 0.01,
                ),
                const Text(
                  "pm",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  width: we * 0.425,
                ),
                FlutterSwitch(
                    value: status,
                    activeColor: activeColor1,
                    inactiveColor: Colors.black,
                    onToggle: (value) {
                      setState(() {
                        status = value;
                      });
                    })
              ],
            ),
          ),
        ]),
      ),
      bottomNavigationBar: Bottome(
        pageInxdex: 1,
      ),
    );
  }
}
