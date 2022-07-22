import 'dart:async';
import 'dart:math';
import 'package:clock_view/const.dart';
import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  const ClockView({Key? key}) : super(key: key);

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 320,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: blendColor,
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [gradiant1, gradiant2],
              ),
              boxShadow: [
                BoxShadow(
                    blurRadius: 25,
                    spreadRadius: 1,
                    offset: const Offset(25, 15),
                    color: Colors.black.withOpacity(0.2)),
                const BoxShadow(
                  blurRadius: 32,
                  spreadRadius: 0.5,
                  color: Colors.white,
                  offset: Offset(-15, -5),
                ),
              ],
            ),
          ),
          Container(
            width: 140,
            height: 140,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: blendColor,
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [gradiant1, gradiant2],
              ),
              boxShadow: [
                BoxShadow(
                    blurRadius: 25,
                    spreadRadius: 1,
                    offset: const Offset(30, 20),
                    color: Colors.black.withOpacity(0.2)),
                const BoxShadow(
                  blurRadius: 32,
                  spreadRadius: 1,
                  color: Colors.white,
                  offset: Offset(-20, -10),
                ),
              ],
            ),
          ),
          Container(
            constraints: const BoxConstraints.expand(),
            child: Transform.rotate(
              angle: -pi / 2,
              child: CustomPaint(
                painter: ClockPainter(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var datetime = DateTime.now();

    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var centerX1 = size.width / 2;
    var centerY1 = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);
    var radius2 = max(centerX1, centerY1);
    var outerRadius = radius - 20;
    var innerRadius = radius - 30;
    var outerRadius1 = radius2 - 20;
    var innerRadius1 = radius2 - 15;

    var hourDashPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 180; i += 45) {
      double x1 = centerX - outerRadius * cos(i * pi / 90);
      double y1 = centerX - outerRadius * sin(i * pi / 90);
      double x2 = centerX - innerRadius * cos(i * pi / 90);
      double y2 = centerX - innerRadius * sin(i * pi / 90);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), hourDashPaint);
    }

    var minDashPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 180; i += 15) {
      double x1 = centerX1 - outerRadius1 * cos(i * pi / 90);
      double y1 = centerX - outerRadius1 * sin(i * pi / 90);
      double x2 = centerX - innerRadius1 * cos(i * pi / 90);
      double y2 = centerX - innerRadius1 * sin(i * pi / 90);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), minDashPaint);
    }

    var secDashPaint = Paint()
      ..color = const Color.fromARGB(255, 251, 140, 132)
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    var secHandX = centerX + 130 * cos(datetime.second * 6 * pi / 180);
    var secHandY = centerY + 130 * sin(datetime.second * 6 * pi / 180);

    var minHandBrush = Paint()
      ..color = const Color.fromARGB(255, 168, 255, 171)
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    var minHandX = centerX + 100 * cos(datetime.minute * 6 * pi / 180);
    var minHandY = centerY + 100 * sin(datetime.minute * 6 * pi / 180);

    var houHandBrush = Paint()
      ..color = const Color.fromARGB(255, 132, 194, 246)
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    var houHandX = centerX +
        60 * cos((datetime.hour * 30 + datetime.minute * 0.5) * pi / 180);
    var houHandY = centerY +
        60 * sin((datetime.hour * 30 + datetime.minute * 0.5) * pi / 180);

    // ignore: unused_local_variable
    var dashBrush = Paint()
      ..color = Colors.orange[500]!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    canvas.drawLine(center, Offset(secHandX, secHandY), secDashPaint);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);
    canvas.drawLine(center, Offset(houHandX, houHandY), houHandBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
