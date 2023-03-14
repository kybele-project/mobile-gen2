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
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: (MediaQuery.of(context).size.height - 80) * 0.5 - 80,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  /*
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconBox(
                        iconBkgColor: const apgarBkgColor,
                        iconColor: const apgarBkgColor,
                        icon: apgarIcon,
                        scalar: _scalar,
                      ),
                      SizedBox(width: _gap),
                      IconBox(
                        iconBkgColor: const oxygenSatBkgColor,
                        iconColor: const oxygenSatIconColor,
                        icon: oxySatIcon,
                        scalar: _scalar,
                      ),
                      SizedBox(width: _gap),
                      IconBox(
                        iconBkgColor: const mainLightPurple,
                        iconColor: const mainWhite,
                        icon: Icons.timer_rounded,
                        scalar: _scalar,
                      ),
                    ],
                  ),
                  SizedBox(height: _gap),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconBox(
                        iconBkgColor: Colors.green.shade400,
                        iconColor: Colors.white,
                        icon: Icons.check_rounded,
                        scalar: _scalar,
                      ),
                      SizedBox(width: _gap),
                      IconBox(
                        iconBkgColor: Colors.red.shade400,
                        iconColor: Colors.white,
                        icon: Icons.priority_high_rounded,
                        scalar: _scalar,
                      ),
                      SizedBox(width: _gap),
                      IconBox(
                        iconBkgColor: const Color(0xffdddddd),
                        iconColor: const Color(0xff555555),
                        icon: recordIcon,
                        scalar: _scalar,
                      ),
                    ],
                  ),
                  SizedBox(height: _gap),
                   */
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
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
