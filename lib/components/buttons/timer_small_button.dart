import 'package:flutter/material.dart';

class TimerSmallButton extends StatelessWidget {

  final VoidCallback actionFunction;
  final IconData iconData;

  const TimerSmallButton({
    super.key,
    required this.actionFunction,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: actionFunction,
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xff9F97E3),
        ),
        child: Icon(iconData,
            size: 30, color: Colors.white),
      ),
    );
  }

}