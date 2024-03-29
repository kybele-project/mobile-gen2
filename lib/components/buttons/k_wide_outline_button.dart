import 'package:flutter/material.dart';

import '../../style/colors.dart';

class KWideOutlineButton extends StatelessWidget {

  final String header;

  const KWideOutlineButton({
      required this.header,
      super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            border: Border.all(width: 2, color: mainLightPurple)
        ),
        width: MediaQuery.of(context).size.width - 40,
        height: 60,
        child: Center(
          child: Text(
            header,
            style: TextStyle(
              color: mainLightPurple,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
  }
}