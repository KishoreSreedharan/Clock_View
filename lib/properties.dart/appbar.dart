import 'package:clock_view/const.dart';
import 'package:flutter/material.dart';

class Appbars extends StatefulWidget {
  const Appbars({Key? key}) : super(key: key);

  @override
  State<Appbars> createState() => _AppbarsState();
}

class _AppbarsState extends State<Appbars> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var hi = MediaQuery.of(context).size.height;
    var wi = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Clock",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 103, 54, 104)),
          ),
          SizedBox(
            width: wi * 0.54,
          ),
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[500]!,
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(2, 2),
                ),
                const BoxShadow(
                  color: Colors.white,
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: Offset(-2, -2),
                )
              ],
              color: blendColor,
            ),
            child: Icon(
              Icons.settings,
              color: Colors.grey.withOpacity(0.65),
            ),
          ),
        ],
      ),
    );
  }
}
