import 'package:flutter/material.dart';

import '../../style/colors.dart';

class KSmallButton extends StatelessWidget {
  final VoidCallback actionFunction;
  final IconData iconData;

  const KSmallButton({
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
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: mainLightPurple,
        ),
        child: Icon(iconData, size: 30, color: Colors.white),
      ),
    );
  }
}
