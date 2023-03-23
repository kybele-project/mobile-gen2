import 'package:flutter/material.dart';

import '../../style/colors.dart';

class KLargeButton extends StatelessWidget {

  final VoidCallback actionFunction;
  final IconData iconData;
  final String label;
  final Color color;

  const KLargeButton({
    super.key,
    required this.actionFunction,
    required this.iconData,
    required this.label,
    this.color = const Color(0xff9F97E3), // mainLightPurple
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: actionFunction,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(iconData, size: 30, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

}