import 'dart:math';
import 'package:clock_view/const.dart';
import 'package:clock_view/properties.dart/appbar.dart';
import 'package:clock_view/properties.dart/navigation.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _isHours = true;
  bool isRunning = true;
  bool isRecord = true;

  final _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size.height;
    var we = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: blendColor,
      body: SizedBox(
        height: he,
        width: we,
        child: Column(
          children: [
            const Appbars(),
            SizedBox(
              height: he * 0.05,
            ),
            Container(
              height: 320,
              width: 320,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: blendColor,
                  gradient: LinearGradient(
                    colors: [gradiant1, gradiant2],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 28,
                      spreadRadius: 1,
                      offset: const Offset(30, 20),
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      blurRadius: 28,
                      spreadRadius: 1,
                      offset: Offset(-20, -10),
                    ),
                  ]),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  StreamBuilder<int>(
                      stream: _stopWatchTimer.rawTime,
                      initialData: _stopWatchTimer.rawTime.value,
                      builder: (context, snapShot) {
                        final value = snapShot.data;
                        final displayTime = StopWatchTimer.getDisplayTime(
                            value!,
                            hours: _isHours);
                        return Text(
                          displayTime,
                          style: const TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 103, 54, 104),
                              fontWeight: FontWeight.bold),
                        );
                      }),
                  CustomPaint(
                    painter: ClockTimer(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: he * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buttonStart(
                  context,
                  "Start",
                  Colors.black.withOpacity(0.7),
                ),
                SizedBox(
                  width: we * 0.05,
                ),
                InkWell(
                  onTap: () {
                    isRecord
                        ? _stopWatchTimer.onExecute.add(StopWatchExecute.reset)
                        : _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
                  },
                  child: _buttonStop(context, Colors.red, "Reset"),
                )
              ],
            ),
            Container(
              width: we * 0.9,
              height: he * 0.2,
              margin: const EdgeInsets.only(top: 10),
              child: StreamBuilder<List<StopWatchRecord>>(
                stream: _stopWatchTimer.records,
                initialData: _stopWatchTimer.records.value,
                builder: (context, snapShot) {
                  final value = snapShot.data;
                  if (value!.isEmpty) {
                    return Container();
                  }
                  Future.delayed(const Duration(microseconds: 300), () {
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut);
                  });
                  return ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (c, i) {
                      final data = value[i];
                      return buildCard(
                          context, "${i + 1}", "${data.displayTime}");
                    },
                    itemCount: value.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottome(
        pageInxdex: 2,
      ),
    );
  }

  Widget buildCard(context, String index, String text) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Container(
      width: we * 0.8,
      height: he * 0.07,
      padding: const EdgeInsets.all(0.8),
      margin: const EdgeInsets.all(0.8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 211, 247),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          index,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          width: we * 0.01,
        ),
        const Text(
          "Lap",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        SizedBox(
          width: we * 0.43,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.7)),
        ),
      ]),
    );
  }

  Widget _buttonStart(context, String text, Color color) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        isRunning
            ? _stopWatchTimer.onExecute.add(StopWatchExecute.start)
            : _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
        setState(() {
          isRunning = !isRunning;
          isRecord = !isRecord;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: he * 0.058,
        width: we * 0.41,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: blendColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[500]!,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(4, 4)),
              const BoxShadow(
                color: Colors.white,
                blurRadius: 15,
                spreadRadius: 1,
                offset: Offset(-4, -4),
              ),
            ]),
        child: Text(
          isRunning ? text : "Pause",
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  Widget _buttonStop(context, Color color, String text) {
    var he = MediaQuery.of(context).size.height;
    var we = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.center,
      height: he * 0.058,
      width: we * 0.41,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: blendColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey[500]!,
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(4, 4)),
            const BoxShadow(
              color: Colors.white,
              blurRadius: 15,
              spreadRadius: 1,
              offset: Offset(-4, -4),
            ),
          ]),
      child: Text(
        isRecord ? text : "Record",
        style:
            TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}

class ClockTimer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    // var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);
    var outerRadius = radius - 47;
    var innerRadius = radius - 50;

    var hourDashPaint = Paint()
      ..color = Colors.grey
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < 360; i += 3) {
      double x1 = centerX - outerRadius * 3 * cos(i * pi / 180);
      double y1 = centerY - outerRadius * 3 * sin(i * pi / 180);
      double x2 = centerX - innerRadius * 3 * cos(i * pi / 180);
      double y2 = centerY - innerRadius * 3 * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), hourDashPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
