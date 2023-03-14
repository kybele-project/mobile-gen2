import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBkgColor;
  final double scalar;

  const IconBox({
    required this.iconColor,
    required this.iconBkgColor,
    required this.icon,
    this.scalar = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40 * scalar,
      height: 40 * scalar,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: iconBkgColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon, size: 20 * scalar, color: iconColor),
        ],
      ),
    );
  }
}

class LaunchGraphic extends StatelessWidget {
  const LaunchGraphic({super.key});

  /*
  final double _scalar = 1;
  final double _gap = 15;
  */

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: const [
          SizedBox(height: 20),
          Text(
            "No events logged",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            "Start timer, log events, or browse resources",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
