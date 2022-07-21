import 'package:clock_view/const.dart';
import 'package:clock_view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Bottome extends StatefulWidget {
  int pageInxdex;
  Bottome({Key? key, required this.pageInxdex}) : super(key: key);

  @override
  State<Bottome> createState() => _BottomeState();
}

class _BottomeState extends State<Bottome> {
  bool isOn = true;
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var hi = MediaQuery.of(context).size.height;

    return SizedBox(
      width: wi * 0.2,
      height: hi * 0.12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(PageTransition(
                  child: const MyHomePage(), type: PageTransitionType.fade));
            },
            child: IconChanger(
                icon: Icons.schedule_outlined,
                isOn: widget.pageInxdex == 1 ? false : true),
          ),
          SizedBox(
            width: wi * 0.1,
          ),
          InkWell(
            onTap: () {
              setState(() {});
            },
            child: IconChanger(
                icon: Icons.timer_outlined,
                isOn: widget.pageInxdex == 2 ? false : true),
          ),
          SizedBox(
            width: wi * 0.1,
          ),
          InkWell(
            onTap: () {
              setState(() {});
            },
            child: IconChanger(
                icon: Icons.alarm_outlined,
                isOn: widget.pageInxdex == 3 ? false : true),
          ),
          SizedBox(
            width: wi * 0.1,
          ),
          InkWell(
            onTap: () {
              setState(() {});
            },
            child: IconChanger(
                icon: Icons.more_time_outlined,
                isOn: widget.pageInxdex == 4 ? false : true),
          ),
          SizedBox(
            width: wi * 0.1,
          ),
        ],
      ),
    );
  }
}

class IconChanger extends StatelessWidget {
  bool isOn;
  IconData icon;

  IconChanger({Key? key, required this.icon, required this.isOn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 45,
      height: 45,
      duration: const Duration(milliseconds: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: blendColor,
        boxShadow: isOn
            ? [
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
              ]
            : null,
      ),
      child: Icon(
        icon,
        color: Colors.grey.withOpacity(0.5),
      ),
    );
  }
}
